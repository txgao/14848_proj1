from flask import Flask, render_template, redirect
import json

def get_ip(filename):
    return 'http://{}'.format(json.load(open('services/{}.json'.format(filename)))['status']['loadBalancer']['ingress'][0]['ip'])

spark_ip = get_ip('spark')
hadoop_ip = get_ip('hadoop')
jupyter_ip = get_ip('jupyter')
sonar_ip = get_ip('sonarscanner')

PORT_NUM = 8888
HOST = '0.0.0.0'

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/hadoop')
def hadoop():
    return redirect(hadoop_ip)

@app.route('/spark')
def spark():
    return redirect(spark_ip)

@app.route('/jupyter')
def jupyter():
    return redirect(jupyter_ip)

@app.route('/sonar')
def sonar():
    return redirect(sonar_ip)

if __name__ == "__main__":
    print("Starting my application...")
    app.run(host=HOST, port=PORT_NUM)
