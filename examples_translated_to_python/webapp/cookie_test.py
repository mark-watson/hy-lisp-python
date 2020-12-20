from hy.core.language import name
from flask import Flask, render_template, request, make_response
app = Flask('Flask and Jinja2 test')


@app.route('/')
def index():
    cookie_data = request.cookies.get('hy-cookie')
    print('cookie-data:', cookie_data)
    a_response = render_template('template1.j2', name=cookie_data)
    return a_response


@app.route('/response', methods=['POST'])
def response():
    name = request.form.get('name')
    print(name)
    a_response = make_response(render_template('template1.j2', name=name))
    a_response.set_cookie('hy-cookie', name)
    return a_response


app.run()

