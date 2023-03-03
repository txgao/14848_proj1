import os
from flask import Flask, render_template, request

# PORT_NUM = 8080

app = Flask(__name__)

files = []

@app.route('/', methods=['GET', 'POST'])
def main():
    if request.method == 'POST':
        for file in request.files.getlist('files'):
            files.append(file.filename)
        return render_template('upload.html', filenames=files)
    else:
        return render_template('upload.html', filenames=files)

if __name__ == "__main__":
    print("Starting my application...")
    app.run(host='0.0.0.0', port=8080)
