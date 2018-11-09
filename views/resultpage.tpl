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
<!--       <div class="query-data-tables">
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
      </div> -->
      <div class="result-page-content">
        <p>Showing results for "{{ keywords }}"</p>
        % for result in retrieved_list_of_urls['url_results_info'][retrieved_list_of_urls['current_page_num']]:
          <div>
            <div class="result-url-header">
              <a href="{{ result['url'] }}">
                <h3 class="url-title">{{ result['title'] }}</h3>
                <br>
                <cite>{{ result['url'] }}</cite>
              </a>
            </div>
            <div class="result-url-description">
              <span>{{ result['description'] }}</span>
            </div>
          </div>
        % end
      </div>
      <div class="pagination-buttons">
        <table>
          <tr>
          % for page_num in range(0, retrieved_list_of_urls['total_page_num']):
            <td class="{{ 'cur' if page_num == retrieved_list_of_urls['current_page_num'] else '' }}">
              <a href="/paginate_results/{{page_num}}">{{ page_num + 1 }}</a>
            </td>
          % end
          </tr>
        </table>
      </div>
    </div>
  </div>
</html>