# server in python
import subprocess
import re
from flask import Flask, flash, redirect, request, jsonify, render_template, url_for

app = Flask(__name__)

# route to the main page


@app.route('/')
def home():
    return render_template('index.html')


@app.route("/test")
def test():
    return render_template('new_index.html')

# route to the tools page


@app.route('/favtools')
def favtools():
    return render_template('fav_tools.html')


@app.route('/training')
def training():
    return render_template('training.html')

# route to scan.html


@app.route('/scan', methods=['POST', 'GET'])
def scan():
    if request.method == 'POST':
        target = request.form.get('target', '').strip()
        if not target:
            return jsonify({'error': 'Please enter a target to scan'}), 400

        if not re.match(r'^[a-zA-Z0-9\.\-:]+$', target):
            return jsonify({'error': 'Invalid target format'}), 400

        try:
            # Run nmap scan (educational purposes only)
            result = subprocess.run(
                ['nmap', '-T4', '-F', '-Pn', target],
                capture_output=True,
                text=True,
                timeout=30
            )

            if result.returncode == 0:
                return jsonify({'result': result.stdout, 'target': target})
            else:
                return jsonify({'error': f"Scan error: {result.stderr}"}), 500
        except Exception as e:
            return jsonify({'error': f"Scan failed: {str(e)}"}), 500

    # For GET requests, still return the HTML page
    return render_template('scan.html', scan_result=None)

# Port Scanner html


@app.route('/scan_port', methods=['GET', 'POST'])
def handle_port_scan():
    if request.method == 'GET':
        return render_template('scan_port.html')

    if request.method == 'POST':
        try:
            # Check if it's JSON data
            if request.is_json:
                data = request.get_json()
                target = data.get('target', '').strip()
                scan_type = data.get('scan_type', 'quick')
                custom_ports = data.get('ports', '')
            else:
                # Form data handling
                target = request.form.get('target', '').strip()
                scan_type = request.form.get('scan_type', 'quick')
                custom_ports = request.form.get('ports', '')

            if not target:
                return jsonify({'error': 'Target is required'}), 400

            # Build nmap command based on scan type
            if scan_type == 'quick':
                cmd = ['nmap', '-T4', '-F', target]
            elif scan_type == 'full':
                cmd = ['nmap', '-T4', '-p-', target]
            elif scan_type == 'custom' and custom_ports:
                cmd = ['nmap', '-T4', '-p', custom_ports, target]
            else:
                return jsonify({'error': 'Invalid scan type or missing ports'}), 400

            # Run the scan
            result = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                timeout=300  # 5 minutes timeout for full scans
            )

            if result.returncode != 0:
                return jsonify({'error': result.stderr}), 500

            # Parse nmap output and return structured data
            return jsonify(parse_nmap_output(result.stdout, target))

        except Exception as e:
            return jsonify({'error': str(e)}), 500


def parse_nmap_output(output, target):
    # This is a simplified parser - you may need to enhance it
    import re

    ports = []
    open_count = 0
    filtered_count = 0
    closed_count = 0

    # Simple regex to extract port information
    port_pattern = re.compile(
        r'^(\d+)/(tcp|udp)\s+(\w+)\s+(.*)$', re.MULTILINE)

    for match in port_pattern.finditer(output):
        port = int(match.group(1))
        status = match.group(3).lower()
        service = match.group(4).strip() or None

        ports.append({
            'port': port,
            'status': status,
            'service': service
        })

        if status == 'open':
            open_count += 1
        elif status == 'filtered':
            filtered_count += 1
        else:
            closed_count += 1

    return {
        'target': target,
        'results': ports,
        'stats': {
            'open': open_count,
            'filtered': filtered_count,
            'closed': closed_count
        },
        'raw_output': output
    }

# Scan_Website.html


@app.route('/scan_website', methods=['GET', 'POST'])
def handle_website_scan():
    if request.method == 'GET':
        return render_template('scan_website.html')

    if request.method == 'POST':
        try:
            data = request.get_json()
            target = data.get('target', '').strip()
            options = data.get('options', {})

            if not target:
                return jsonify({'error': 'Target URL is required'}), 400

            # Validate URL format
            if not re.match(r'^https?://[^\s/$.?#].[^\s]*$', target):
                return jsonify({'error': 'Invalid URL format'}), 400

            # Here you would implement actual scanning logic
            # This is just a mock response for demonstration
            mock_response = {
                'target': target,
                'summary': {
                    'critical': 1,
                    'high': 2,
                    'medium': 3,
                    'low': 4
                },
                'vulnerabilities': [
                    {
                        'name': 'SQL Injection Vulnerability',
                        'severity': 'critical',
                        'description': 'The website appears vulnerable to SQL injection attacks.',
                        'recommendation': 'Use parameterized queries and prepared statements.',
                        'url': f'{target}/login.php'
                    },
                    {
                        'name': 'Missing Security Headers',
                        'severity': 'high',
                        'description': 'Important security headers like X-XSS-Protection and Content-Security-Policy are missing.',
                        'recommendation': 'Configure proper security headers in your web server.'
                    }
                ],
                'security_headers': {
                    'X-XSS-Protection': 'Not set',
                    'Content-Security-Policy': 'Not set',
                    'Strict-Transport-Security': 'max-age=31536000'
                },
                'tls_info': {
                    'Protocol': 'TLS 1.2',
                    'Cipher': 'AES256-GCM-SHA384',
                    'Certificate Expiry': '30 days remaining'
                }
            }

            return jsonify(mock_response)

        except Exception as e:
            return jsonify({'error': str(e)}), 500

# route to aboutme


@app.route('/contact', methods=['POST', 'GET'])
def about_me():
    user_input = ''
    if request.method == 'POST':
        user_input = request.form.get('xss_input', '')
    return render_template('contact.html', user_input=user_input)


@app.route('/login', methods=['GET', 'POST'])  # route to login page
def login():
    user_input = ''
    if request.method == 'POST':
        user_input = request.form.get('username', '')
    return render_template('login.html', user_input=user_input)


if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True, port=80)
