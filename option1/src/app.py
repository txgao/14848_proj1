import os
from flask import Flask, render_template, request

PORT_NUM = 8888
HOST = '0.0.0.0'

app = Flask(__name__)


@app.route('/', methods=['GET', 'POST'])
def main():
    if request.method == 'POST':
        tool = request.get_json()['tool']
        if tool == 'hadoop':
            # do something
            print(tool)
        elif tool == 'spark':
            # do something
            print(tool)
        elif tool == 'jupyter':
            # do something
            print(tool)
        elif tool =='sonar':
            # do something
            print(tool)

        return 'OK'
    else:
        return render_template('selection.html')

if __name__ == "__main__":
    print("Starting my application...")
    app.run(host=HOST, port=PORT_NUM)
