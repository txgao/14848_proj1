from flask import Flask, render_template, redirect

PORT_NUM = 8888
HOST = '0.0.0.0'

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/hadoop')
def hadoop():
    return redirect('http://34.67.218.224:9870/')

@app.route('/spark')
def spark():
    return redirect('http://35.223.230.207:8080/')

@app.route('/jupyter')
def jupyter():
    return redirect('http://34.171.32.232')

@app.route('/sonar')
def sonar():
    return redirect('http://34.135.205.155:9000/')

if __name__ == "__main__":
    print("Starting my application...")
    app.run(host=HOST, port=PORT_NUM)
