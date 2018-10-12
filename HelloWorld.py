from bottle import get, post, route, run, template, request, re, static_file
from operator import itemgetter

word_occurence_history={}

@get('/')
def search():
    return template('homepage')

@post('/')
def do_search():
    global word_occurence_history

    keywords = request.forms.get('keywords')

    words = parseQueryIntoWordList(keywords)

    query_word_occurence = {}

    query_word_occurence = findWordOccurenceInQuery(words)

    inputWordsInOccurrenceHistory(query_word_occurence)

    sorted_words = getTop20KeywordsDescending()
    
    return template('resultpage', keywords = keywords, sorted_words = sorted_words, query_word_occurence = query_word_occurence)

def parseQueryIntoWordList(query):
  #remove any character that's not a char, space
  keywords_without_special_char = re.sub(r'[^\w\s]', ' ', query)
  words = keywords_without_special_char.split()

  return words

def findWordOccurenceInQuery(words):
  query_word_occurence = {}

  for word in words:
    if word in query_word_occurence:
        query_word_occurence[word] += 1
    else:
        query_word_occurence[word] = 1

  return query_word_occurence

def inputWordsInOccurrenceHistory(word_occurrence):
  for word in word_occurrence:
    if word in word_occurence_history:
        word_occurence_history[word] += word_occurrence[word]
    else:
        word_occurence_history[word] = word_occurrence[word]

def getTop20KeywordsDescending():
  return sorted(word_occurence_history.items(), key=itemgetter(1), reverse=True)[:20]

@route('/static/<filename>')
def server_static(filename):
  return static_file(filename, root='./static_files')

run (host='localhost', port=8080, debug=True)



