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
    <div class="search-box">
      <form action="/results" method="post">
        <input name="keywords" type="text" class="input-search-box" required/>
        <input value="Joogle Search" type="submit" class="search-buttons"/>
      </form>
    </div>
    <div class="body">
      <div class="result-page-content">
        <p class="result-sentence">Showing results for "{{ keywords }}"</p>
        % if is_search_a_calculation_expression:
          <p class="calculation-result">Calculation result is: {{ calculation }}</p>
        % else:
          % if (retrieved_list_of_urls['url_results_info'] != []):
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
          % else: 
          <p>No results found</p>
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
      % end
    </div>
  </div>
</html>