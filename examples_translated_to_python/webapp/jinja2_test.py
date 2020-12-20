from hy.core.language import name
from flask import Flask, render_template, request
app = Flask('Flask and Jinja2 test')


@app.route('/')
def index():
    return render_template('template1.j2')


@app.route('/response', methods=['POST'])
def response():
    name = request.form.get('name')
    print(name)
    return render_template('template1.j2', name=name)


app.run()

