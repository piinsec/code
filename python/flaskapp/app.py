

# def main():
#     print(f"File name : {__name__}")

# if __name__ == '__main__':
#     main()

#server in python

from flask import Flask

app = Flask(__name__)   

@app.route('/')         # route to the main page
def hello_world():      # define function
    return '<h1>Hello World</h1>'# main page output

#@app.route('/page/2')    # route to other page by name
@app.route('/page/<int:number>')
def bye(number):
    return f'This is page {number}'

if __name__ == '__main__':
    app.run(debug=True)