from bottle import get, post, route, run, template, request, re, static_file
from operator import itemgetter

import bottle as bottle
import json
import httplib2

import requests

from beaker.middleware import SessionMiddleware

#Google Authentication
from oauth2client.client import OAuth2WebServerFlow
from oauth2client.client import flow_from_clientsecrets
from googleapiclient.errors import HttpError
from googleapiclient.discovery import build

#call back function for GET http request. It returns template/homepage.tpl as the view for the root page
@get('/')
def search():
    return template('homepage')

#redirect_uri is what the API server automatically after user have completed the authorization flow once. 
#we're authorizing user for access of data, not authenticating. we can't log user out of authorization flow, but we can revoke the token.
#if we revoke the token, they would have to log in again.

#sign-in page
@route('/login', 'GET')
def home():
  flow = flow_from_clientsecrets("client_secrets.json",scope='https://www.googleapis.com/auth/plus.me https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile', redirect_uri="http://localhost:8080/redirect")
  #if already authorized, uri contains code. If node it conains access_denied
  uri = flow.step1_get_authorize_url()
  print ("---------in login method")
  print ("----------redirect uri is {}",uri)
  bottle.redirect(str(uri))


@route('/redirect')
def redirect_page():
  code = request.query.get('code', '')

  #parse json to get client id and client secret
  with open('client_secrets.json','r') as f:
    data = json.load(f)

  CLIENT_ID = data["web"]["client_id"]
  CLIENT_SECRET = data["web"]["client_secret"]
  REDIRECT_URI = data["web"]["redirect_uris"][0]

  #get access token
  flow = OAuth2WebServerFlow(client_id=CLIENT_ID, client_secret=CLIENT_SECRET, scope='https://www.googleapis.com/auth/plus.me https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile', redirect_uri=REDIRECT_URI)
  credentials = flow.step2_exchange(code)
  token = credentials.id_token['sub']
  print ("hi this is the token1",token)
  token2,expiry = credentials.get_access_token()
  
  print ("hi this is token 2",token2)
  print ("hi this is credentials",credentials)

  http = httplib2.Http()
  http = credentials.authorize(http)
  # Get user email
  users_service = build('oauth2', 'v2', http=http)
  user_document = users_service.userinfo().get().execute()
  user_email = user_document['email']
  #session['email'] = user_email
  #http2 = httplib2.Http()
  #credentials.revoke(http)

  #session = bottle.request.environ.get('beaker.session')
  #session.delete()
  print ("-------------Redirecting------------")
  r = requests.post('https://accounts.google.com/o/oauth2/revoke',
    params={'token': token2},
    headers = {'content-type': 'application/x-www-form-urlencoded'})  #r = requests.post('https://accounts.google.com/o/oauth2/revoke',
   # params={'token': token},
    #headers = {'content-type': 'application/x-www-form-urlencoded'})
  print ("hi this is r",r)
  bottle.redirect('/')
  return user_document




# #session management
# session_opts = {
#     'session.type': 'file',
#     'session.cookie_expires': 300,
#     'session.data_dir': './data',
#     'session.auto': True
# }
# app = SessionMiddleware(bottle.app(), session_opts)
# bottle.run(app=app)



#global variable hash to store how many times each word has appeared in all the searches in current session
word_occurence_history={}



#call back function for POST http request. It's the result page after form submission and returns template/resultpage.tpl
@post('/')
def do_search():
    global word_occurence_history

    #get the raw input from user using an html form
    keywords = request.forms.get('keywords')

    #parse words to remove special characters and split into a list of individual words
    words = parseQueryIntoWordList(keywords)

    #hash to store each word and how many times it has appeared in current search. {word:word_occurence}
    query_word_occurence = {}

    #populate query_word_occurence
    query_word_occurence = findWordOccurenceInQuery(words)

    #input words from current search into the global variable word_occurence_history
    inputWordsInOccurrenceHistory(query_word_occurence)

    #return the top 20 most frequently searched words in word_occurence_history
    sorted_words = getTop20KeywordsDescending()
    
    #use template/resultpage.tmp as the view for the search results page
    return template('resultpage', keywords = keywords, sorted_words = sorted_words, query_word_occurence = query_word_occurence)

#parse words to remove special characters and split into a list of individual words
def parseQueryIntoWordList(query):
  #remove any character that's not a char, space
  keywords_without_special_char = re.sub(r'[^\w\s]', ' ', query)
  #split the words and store into a list
  words = keywords_without_special_char.split()

  return words

#populate query_word_occurence with number of appearances of each word in current search
def findWordOccurenceInQuery(words):
  query_word_occurence = {}

  for word in words:
    if word in query_word_occurence:
        query_word_occurence[word] += 1
    else:
        query_word_occurence[word] = 1

  return query_word_occurence

#input words from current search into the global variable word_occurence_history
def inputWordsInOccurrenceHistory(word_occurrence):
  for word in word_occurrence:
    if word in word_occurence_history:
        word_occurence_history[word] += word_occurrence[word]
    else:
        word_occurence_history[word] = word_occurrence[word]

#return the top 20 most frequently searched words in word_occurence_history
def getTop20KeywordsDescending():
  return sorted(word_occurence_history.items(), key=itemgetter(1), reverse=True)[:20]


#route for static files. Need this callback to specify which files to be served and where to find them
@route('/static/<filename>')
def server_static(filename):
  return static_file(filename, root='./static_files')

run (host='localhost', port=8080, debug=True)
