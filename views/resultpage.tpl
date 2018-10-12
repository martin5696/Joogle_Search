<html>
  <head>
    <link rel="stylesheet" href="/static/resultpage.css">
  </head>
  <div class="resultpage">
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
      <table class="history">
        <caption>History</caption>
        <tr>
          <th>Top 20 Keywords</th>
          <th>Number of Occurrences</th>
        </tr>
        % for word in sorted_words:
          <tr>
            <td class="word">{{ word[0] }}</td>
            <td class="number-of-occurrences">{{ word[1] }}</td>
          </tr>
        % end
      </table>
    </div>
  </div>
</html>