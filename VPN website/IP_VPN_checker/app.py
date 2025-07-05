from flask import Flask, render_template, request, jsonify
import sqlite3
from datetime import datetime
import requests

app = Flask(__name__)

DATABASE = 'ip_checker.db'


def init_db():
    conn = sqlite3.connect(DATABASE)
    c = conn.cursor()

    c.execute('''CREATE TABLE IF NOT EXISTS ip_checks
                 (id INTEGER PRIMARY KEY AUTOINCREMENT,
                  ip TEXT NOT NULL,
                  city TEXT,
                  region TEXT,
                  country TEXT,
                  isp TEXT,
                  asn TEXT,
                  is_vpn INTEGER,
                  is_proxy INTEGER,
                  is_tor INTEGER,
                  ip_type TEXT,
                  check_time TIMESTAMP)''')

    c.execute('''CREATE TABLE IF NOT EXISTS ip_history
                 (id INTEGER PRIMARY KEY AUTOINCREMENT,
                  ip TEXT NOT NULL,
                  check_time TIMESTAMP,
                  FOREIGN KEY(ip) REFERENCES ip_checks(ip))''')

    conn.commit()
    conn.close()


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/check_ip', methods=['POST'])
def check_ip():
    ip = request.form.get('ip', '').strip()

    try:
        url = f'https://ipapi.co/{ip}/json/' if ip else 'https://ipapi.co/json/'
        response = requests.get(url)
        data = response.json()

        if 'error' in data:
            return jsonify({'error': data.get('reason', 'Unknown error')}), 400

        ip_address = data.get('ip', '')
        ip_type = 'Public'
        if ip_address.startswith('10.') or \
           ip_address.startswith('192.168.') or \
           (ip_address.startswith('172.') and 16 <= int(ip_address.split('.')[1]) <= 31):
            ip_type = 'Private'
        elif ip_address == '127.0.0.1':
            ip_type = 'Localhost'

        privacy = data.get('privacy', {})
        is_vpn = privacy.get('vpn', False) or 'vpn' in data.get(
            'org', '').lower()
        is_proxy = privacy.get('proxy', False)
        is_tor = privacy.get('tor', False)

        conn = sqlite3.connect(DATABASE)
        c = conn.cursor()

        c.execute('''INSERT OR REPLACE INTO ip_checks 
                     (ip, city, region, country, isp, asn, is_vpn, is_proxy, is_tor, ip_type, check_time)
                     VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)''',
                  (data['ip'],
                   data.get('city'),
                   data.get('region'),
                   data.get('country_name'),
                   data.get('org'),
                   data.get('asn'),
                   int(is_vpn),
                   int(is_proxy),
                   int(is_tor),
                   ip_type,
                   datetime.now().isoformat()))

        c.execute('INSERT INTO ip_history (ip, check_time) VALUES (?, ?)',
                  (data['ip'], datetime.now().isoformat()))

        conn.commit()
        conn.close()

        result = {
            'ip': data['ip'],
            'location': f"{data.get('city', 'N/A')}, {data.get('region', 'N/A')}, {data.get('country_name', 'N/A')}",
            'isp': data.get('org', 'N/A'),
            'asn': data.get('asn', 'N/A'),
            'is_vpn': is_vpn,
            'is_proxy': is_proxy,
            'is_tor': is_tor,
            'ip_type': ip_type,
            'check_time': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
            'privacy_flags': privacy
        }

        return jsonify(result)

    except Exception as e:
        return jsonify({'error': str(e)}), 500


@app.route('/get_history', methods=['GET'])
def get_history():
    try:
        conn = sqlite3.connect(DATABASE)
        c = conn.cursor()

        c.execute('''SELECT i.ip, i.city, i.country, i.is_vpn, MAX(h.check_time) as last_check
                     FROM ip_checks i
                     JOIN ip_history h ON i.ip = h.ip
                     GROUP BY i.ip
                     ORDER BY last_check DESC''')

        history = []
        for row in c.fetchall():
            history.append({
                'ip': row[0],
                'location': f"{row[1] or 'N/A'}, {row[2] or 'N/A'}",
                'is_vpn': bool(row[3]),
                'last_check': row[4]
            })

        conn.close()
        return jsonify(history)

    except Exception as e:
        return jsonify({'error': str(e)}), 500


if __name__ == '__main__':
    init_db()
    app.run(debug=True, host="0.0.0.0", port=80)
