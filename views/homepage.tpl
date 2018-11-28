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
      <svg viewBox="0 0 400 200" class="title">
        <symbol id="s-text">
          <text text-anchor="middle" x="50%" y="50%" dy=".35em">Joogle</text>
        </symbol>
        <use class="text" xlink:href="#s-text"></use>
        <use class="text" xlink:href="#s-text"></use>
        <use class="text" xlink:href="#s-text"></use>
        <use class="text" xlink:href="#s-text"></use>
        <use class="text" xlink:href="#s-text"></use>
      </svg>
      <form action="/results" method="post">
        <input name="keywords" type="text" class="input-search-box" required/>
        <br>
        <div class="search-buttons">
          <input value="Joogle Search" type="submit" />
          <input value="I'm Feeling Joogle" type="submit" />
        </div>
      </form>
    </div>
  </div>
</div>