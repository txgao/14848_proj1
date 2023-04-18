from flask import Flask, render_template, redirect
import json

def get_ip(filename):
    return 'http://{}'.format(json.load(open('../services/{}.json'.format(filename)))['status']['loadBalancer']['ingress'][0]['ip'])

SPARK_IP = get_ip('spark')
HADOOP_IP = get_ip('hadoop')
JUPYTER_IP = get_ip('jupyter')
SONAR_IP = get_ip('sonarscanner')

PORT_NUM = 8888
HOST = '0.0.0.0'

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/hadoop')
def hadoop():
    return redirect(HADOOP_IP)

@app.route('/spark')
def spark():
    return redirect(SPARK_IP)

@app.route('/jupyter')
def jupyter():
    return redirect(JUPYTER_IP)

@app.route('/sonar')
def sonar():
    return redirect(SONAR_IP)

if __name__ == "__main__":
    print("Starting my application...")
    app.run(host=HOST, port=PORT_NUM)
