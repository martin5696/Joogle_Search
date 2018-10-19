<html>
  <head>
    <link rel="stylesheet" href="/static/homepage.css">
  </head>
  <div class="homepage">
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
      <h1 class="title">Joogle</h1>
      <form action="/results" method="post">
        <input name="keywords" type="text" class="input-search-box"/>
        <br>
        <div class="search-buttons">
          <input value="Joogle Search" type="submit" />
          <input value="I'm Feeling Joogle" type="submit" />
        </div>
      </form>
    </div>
  </div>
</div>