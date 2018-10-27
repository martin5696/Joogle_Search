<html>
  <head>
    <link rel="stylesheet" href="/static/resultpage.css">
  </head>
  <div class="resultpage">
    <div class="header">
      % if user_info['logged_in']:
      <div class="left-side">
        <div class="user-info">
          <img src="{{ user_info['picture_path'] }}">
          <span class="name">{{ user_info['name'] }}</span>
        </div>
      </div>
      <div class="right-side">
        <a class="sign-out" href="/signout">Sign out</a>
      </div>
      % else:
      <div class="left-side">
        <div class="user-info">
          <span>Anonymous Mode</span>
        </div>
      </div>
      <div class="right-side">
        <a class="sign-in" href="/signin">Sign in</a>
      </div>
      % end
    </div>
    <div class="body">
      <div class="query-data-tables">
        <p>Search for "{{ keywords }}"</p>
        <table class="results">
          <caption>Results</caption>
          <tr>
            <th>Keywords</th>
            <th>Number of Occurrences</th>
          </tr>
          % for word in query_word_occurence:
            <tr>
              <td class="word">{{ word }}</td>
              <td class="number-of-occurrences">{{ query_word_occurence[word] }}</td>
            </tr>
          % end
        </table>
        % if user_info['logged_in']:
          <table class="history">
            <caption>10 Most Recent Searches</caption>
            <tr>
              <th>Keywords</th>
            </tr>
            % for word in recent_search_list:
              <tr>
                <td class="word">{{ word}}</td>
              </tr>
            % end
          </table>
        % end
      </div>
    </div>
  </div>
</html>