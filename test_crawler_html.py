from bottle import get, route, run, template

@get('/')
def default():
  return template('test_html_1')

@route('/test')
def first_link():
  return template('test_html_2')

run (host='localhost', port=8080, debug=True)



