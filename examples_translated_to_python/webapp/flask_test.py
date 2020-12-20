from flask import Flask
app = Flask('Flask test')


@app.route('/')
def index():
    return 'Hello World !'


app.run()

