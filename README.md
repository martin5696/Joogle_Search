# FRONTEND Overview/Instructions 
# how we are referencing our CSS/tpl files

Main files:
- joogle_search.py
- views/homepage.tpl
- views/resultpage.tpl
- static_files/homepage.css
- static_files/resultpage.css

To access Joogle search please run:
> python joogle_search.py
After the server starts, visit the following in your browser:
http://localhost:8080/

The root page:
-The call back function of the http GET request for this root url is called search() in joogle_search.py
This view uses the following template file:
- views/homepage.tpl
The corresponding CSS file is:
- static_files/homepage.css

The result page:
- The call back function of the http POST request for the root url but after form submission is called do_search() in joogle_search.py
This view uses the following template file:
- views/resultpage.tpl
The corresponding CSS file is:
- static_files/resultpage.css

One additional route in joogle_search.py:
@route('/static/<filename>')
- This route is for static files. Need the corresponding callback server_static() to specify which files to be served and where to find them
- Used to specify CSS files
# ------------------------------------------------------
# BACKEND Overview /Instructions 

# Code

	# New Functions added:
	- get_inverted_index():

	returns the inverted index in this format:

	inverted_index: {
		word_id: set([doc_id1, doc_id2, doc_id3, ...]),
		word_id: set([doc_id1, doc_id2, doc_id3, ...]),
		word_id: set([doc_id1, doc_id2, doc_id3, ...]),
		...
	}

	- get_resolved_inverted_index():

	returns the resolved inverted index in this format:

	resolved_inverted_index: {
		'word1': set(['url1', 'url2', 'url3', ...]),
		'word2': set(['url1', 'url2', 'url3', ...]),
		'word3': set(['url1', 'url2', 'url3', ...]),
		...
	}

# Tests

# Crawler test files can be found in:
- /test_crawler.py
- /test_crawler_html.py     # python file that spins up localhost with a basic HTML template for crawler to parse
- /views/test_html_1.tpl    # first html file that is parsed in the crawler
- /views/test_html_2.tpl    # second html file that is parsed in the crawler

# Crawler test be run in the command line by running:

	# 1. This will start up the http://localhost:8080
	> python test_crawler_html.py

	# 2. in a separate command line, run this file
	# this file tests whether the new functions added into crawler.py return the correct output
	> python test_crawler.py


# Lab 2 AWS Information

To Launch an instance:
> python launch_aws_instance.py

Public IP Address: 52.205.163.37

Benchmark Setup: 
- As the server is currently running on a detached AWS instance screen with the associated Public IP Address, we use another AWS instance as the benchmarks driver
- We use the other AWS instance to run a simple benchmark using ab by specifying the number of requests and number of concurrent connections
- On the detached AWS instance, we run htop, iostat and iftop when the simple benchmark is running and recording that data at its maximum and minimum values

