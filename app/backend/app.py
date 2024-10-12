from flask import Flask

app = Flask(__name__)
    username = request.json.get('username', None)

@app.route('/')
def hello():
 return 'Hello, World!'

if __name__ == '__main__':
 app.run(host='0.0.0.0', port=5000)
