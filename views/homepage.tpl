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
      <form autocomplete="off" action="/results" method="post">
        <div class="autocomplete">
          <input id="inputField" name="keywords" type="text" class="input-search-box" placeholder="Why is Joogle better than Google?" required/>
        </div>
        <br>
        <div class="search-buttons">
          <input value="Joogle Search" type="submit" />
          <input value="I'm Feeling Joogle" type="submit" />
        </div>
      </form>

    </div>
  </div>
</div>

<script>
  //Auto-refill implementation based on the following tutorial: https://www.w3schools.com/howto/howto_js_autocomplete.asp
        function test(){

          var existing = document.getElementById('inputField').value
          document.getElementById("inputField").value=existing+"Ssup";
        }

        function autocomplete(inp, arr) {
  /*the autocomplete function takes two arguments,
  the text field element and an array of possible autocompleted values:*/
  var currentFocus;
  /*execute a function when someone writes in the text field:*/
  inp.addEventListener("input", function(e) {
      var a, b, i, val = this.value;

      val = val.split(" ");
      //let last = val[val.length - 1];
      let last = val.splice(-1,1)[0];

      let rest = val.join(" ")

      /*close any already open lists of autocompleted values*/
      closeAllLists();
      if (!val) { return false;}
      currentFocus = -1;
      /*create a DIV element that will contain the items (values):*/
      a = document.createElement("DIV");
      a.setAttribute("id", this.id + "autocomplete-list");
      a.setAttribute("class", "autocomplete-items");
      /*append the DIV element as a child of the autocomplete container:*/
      if (this.parentNode.childElementCount<5)
        this.parentNode.appendChild(a);
      /*for each item in the array...*/

      for (i = 0; i < arr.length; i++) {
        /*check if the item starts with the same letters as the text field value:*/
        if (arr[i].substr(0, last.length).toUpperCase() == last.toUpperCase()) {
          /*create a DIV element for each matching element:*/
          b = document.createElement("DIV");
          /*make the matching letters bold:*/
          b.innerHTML = "<strong>" + arr[i].substr(0, last.length) + "</strong>";
          b.innerHTML += arr[i].substr(last.length);
          /*insert a input field that will hold the current array item's value:*/
          b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
          /*execute a function when someone clicks on the item value (DIV element):*/
              b.addEventListener("click", function(e) {
              /*insert the value for the autocomplete text field:*/
              inp.value = rest + " "+ this.getElementsByTagName("input")[0].value;
              /*close the list of autocompleted values,
              (or any other open lists of autocompleted values:*/
              closeAllLists();
          });
              if (a.childElementCount<5)
                a.appendChild(b);
        }
      }
  });
  /*execute a function presses a key on the keyboard:*/
  inp.addEventListener("keydown", function(e) {
      var x = document.getElementById(this.id + "autocomplete-list");
      if (x) x = x.getElementsByTagName("div");
      if (e.keyCode == 40) {
        /*If the arrow DOWN key is pressed,
        increase the currentFocus variable:*/
        currentFocus++;
        /*and and make the current item more visible:*/
        addActive(x);
      } else if (e.keyCode == 38) { //up
        /*If the arrow UP key is pressed,
        decrease the currentFocus variable:*/
        currentFocus--;
        /*and and make the current item more visible:*/
        addActive(x);
      } else if (e.keyCode == 13) {
        /*If the ENTER key is pressed, prevent the form from being submitted,*/
        e.preventDefault();
        if (currentFocus > -1) {
          /*and simulate a click on the "active" item:*/
          if (x) x[currentFocus].click();
        }
      }
  });
  function addActive(x) {
    /*a function to classify an item as "active":*/
    if (!x) return false;
    /*start by removing the "active" class on all items:*/
    removeActive(x);
    if (currentFocus >= x.length) currentFocus = 0;
    if (currentFocus < 0) currentFocus = (x.length - 1);
    /*add class "autocomplete-active":*/
    x[currentFocus].classList.add("autocomplete-active");
  }
  function removeActive(x) {
    /*a function to remove the "active" class from all autocomplete items:*/
    for (var i = 0; i < x.length; i++) {
      x[i].classList.remove("autocomplete-active");
    }
  }
  function closeAllLists(elmnt) {
    /*close all autocomplete lists in the document,
    except the one passed as an argument:*/
    var x = document.getElementsByClassName("autocomplete-items");
    for (var i = 0; i < x.length; i++) {
      if (elmnt != x[i] && elmnt != inp) {
      x[i].parentNode.removeChild(x[i]);
    }
  }
}

function Get(yourUrl){
    var Httpreq = new XMLHttpRequest(); // a new request
    Httpreq.open("GET",yourUrl,false);
    Httpreq.send(null);
    return Httpreq.responseText;          
}
/*execute a function when someone clicks in the document:*/
document.addEventListener("click", function (e) {
    closeAllLists(e.target);
});
}


//var randomWords = require('random-words');
//console.log(randomWords());
var words = ["yellow","four","sleep","captain","forget","whose","under","risk","rise","shoot","every","govern","affect","school","cause","solution","enjoy","force","direct","likely","street","blue","above","new","ever","told","never","here","path","dry","property","daughter","study","military","divide","campaign","brought","total","unit","spoke","would","hospital","call","type","tell","successful","glass","warm","adult","hole","hold","must","me","join","room","work","root","example","give","involve","want","end","turn","provide","travel","machine","how","hot","answer","beauty","after","wrong","lay","president","law","third","maintain","green","enter","democratic","order","wind","office","over","vary","before","fit","personal","better","production","fig","then","them","safe","break","band","they","one","silver","bank","bread","meat","oxygen","good","each","went","side","bone","mean","financial","series","carry","ring","clothe","network","got","written","hang","free","standard","onto","already","wash","another","thick","service","top","master","too","listen","tool","serve","took","western","tree","second","project","matter","iron","feeling","ran","modern","mind","mine","seed","seem","seek","snow","even","though","object","mouth","letter","professor","camp","metal","dog","consumer","came","radio","earth","busy","explain","sugar","rich","do","watch","coast","despite","report","bat","bar","method","bag","bad","stead","steam","respond","human","fair","result","fail","best","subject","said","away","sail","score","finger","approach","we","men","nature","however","wear","news","improve","protect","cow","country","cup","against","argue","tough","character","speak","conference","three","been","quickly","much","interest","basic","life","excite","lift","child","catch","save","air","near","voice","seven","is","it","player","in","if","perform","suggest","make","several","wheel","social","rail","rain","hand","opportunity","kid","kept","ocean","mother","the","left","just","sentence","identify","victim","yes","yet","candidate","ease","had","shout","spread","board","easy","has","hat","gave","possible","cultural","shoulder","hunt","specific","officer","night","security","attorney","right","old","deal","people","dead","born","election","dear","guess","for","bottom","ice","track","corn","pose","post","magazine","civil","two","down","multiply","east","crowd","support","fight","way","music","was","war","happy","head","form","offer","heat","hear","true","inside","until","evidence","exist","ship","trip","physical","no","when","reality","role","test","tie","smell","roll","picture","surprise","why","felt","fell","billion","phone","assume","together","time","push","serious","coach","dance","focus","invent","manager","mile","skin","chair","milk","row","certainly","depend","everything","father","environment","finally","brown","string","choice","cook","word","trouble","exact","minute","cool","level","did","die","brother","leave","item","settle","team","quick","guy","round","prevent","discover","sign","cost","patient","port","appear","current","international","burn","water","address","alone","along","teacher","change","wait","box","boy","my","trial","usually","love","market","everybody","prove","positive","visit","live","memory","today","effort","fly","car","cat","can","arrive","heart","figure","agent","heard","sharp","occur","winter","discussion","dinner","write","economy","map","product","information","may","southern","produce","such","data","grow","man","natural","remember","liquid","maybe","truck","tall","talk","indeed","course","shake","cold","still","group","thank","interesting","window","policy","main","nation","interview","half","not","now","discuss","nor","term","name","drop","rock","square","yeah","year","girl","space","increase","correct","theory","million","quite","quart","card","care","training","language","motion","thing","place","think","first","question","yourself","fast","vote","message","open","size","city","little","sheet","silent","caught","anyone","indicate","white","friend","fraction","that","season","copy","than","population","wide","television","require","future","were","and","say","anger","saw","any","sat","note","take","performance","wonder","begin","sure","pain","opposite","syllable","price","knew","molecule","pair","operate","especially","egg","later","drive","wing","professional","senior","salt","shop","shot","show","bright","shoe","corner","ground","slow","behind","crime","only","wood","black","get","soon","nearly","reveal","resource","artist","morning","scientist","bought","where","husband","seat","college","sport","concern","federal","outside","between","across","notice","parent","article","come","many","region","according","among","cancer","color","colony","period","boat","stretch","west","mark","engine","direction","thousand","observe","former","those","case","myself","these","mount","n't","newspaper","situation","soil","quiet","middle","sudden","somebody","technology","worry","different","participant","doctor","pay","same","check","speech","week","oil","I","director","fruit","vowel","floor","without","solve","very","model","summer","money","rest","kill","touch","speed","blow","death","rose","except","instrument","treatment","swim","around","read","dark","world","lady","audience","nose","substance","tube","legal","moon","business","throw","on","stone","ok","oh","island","industry","violence","stand","neighbor","act","or","road","image","determine","your","log","prepare","area","there","start","low","lot","valley","fish","complete","enough","with","pull","grass","agree","connect","gone","certain","describe","am","deep","an","as","at","politics","film","fill","again","field","you","poor","separate","symbol","teeth","important","building","wife","mass","original","represent","all","consider","dollar","month","follow","religious","children","to","tail","program","smile","sound","woman","song","far","fat","verb","decide","fall","difference","condition","list","large","sand","small","ten","past","rate","design","lawyer","pass","investment","what","stood","clock","sun","section","public","movement","full","strong","search","ahead","experience","soldier","amount","pick","action","quotient","family","suddenly","ask","establish","select","eye","charge","more","flat","door","company","American","stick","broke","particular","hurry","glad","town","none","hour","science","remain","paragraph","nine","learn","history","beautiful","compare","division","share","accept","sense","phrase","dress","huge","court","goal","rather","plant","reflect","plane","blood","develop","response","a","short","coat","author","shore","responsibility","media","dream","help","don't","mission","trade","held","paper","through","suffer","its","style","actually","late","might","evening","return","food","foot","always","decimal","someone","found","heavy","everyone","weight","generation","house","energy","hard","reduce","idea","gun","finish","expect","operation","beyond","event","really","magnet","flower","since","research","equate","health","hill","print","issue","horse","reason","base","imagine","put","teach","Congress","threat","feed","major","feel","relate","number","feet","done","miss","story","temperature","twenty","least","paint","station","statement","hundred","store","option","relationship","hotel","part","consonant","believe","king","kind","grew","double","marriage","toward","sell","lie","self","majority","build","play","electric","populate","reach","chart","most","plan","significant","nothing","clear","sometimes","cover","traditional","clean","particularly","gold","melody","fine","find","impact","writer","pretty","factor","circle","his","triangle","famous","reply","during","him","enemy","cry","remove","common","activity","river","wrote","set","art","sex","culture","see","defense","are","sea","close","arm","practice","probable","expert","movie","please","various","probably","available","recently","attention","both","last","foreign","whole","point","simple","Mr","community","simply","church","throughout","raise","create","political","strategy","whom","meeting","firm","fire","gas","else","fund","understand","look","straight","bill","budget","rope","while","behavior","fun","guide","real","pound","century","itself","ready","grand","numeral","development","mountain","moment","purpose","recent","early","task","analysis","person","edge","organization","spend","know","chord","shape","continent","cut","also","danger","source","big","couple","game","bit","success","collect","continue","popular","often","spring","some","back","economic","sight","scale","decision","shall","benefit","per","either","be","run","rub","agreement","step","chick","subtract","by","shine","anything","range","block","into","within","lone","long","suit","forward","himself","atom","line","up","us","planet","similar","medical","bell","flow","single","cotton","TV","peace","nice","draw","insect","desert","structure","ago","land","age","crease","fresh","noon","once","go","young","send","include","sent","garden","wave","arrange","entire","try","race","challenge","crop","jump","power","cell","experiment","capital","bird","exercise","body","led","degree","leg","commercial","let","others","sing","great","receive","climb","apple","claim","win","manage","private","duck","apply","cloud","use","from","stream","next","few","camera","themselves","sort","about","train","baby","central","women","customer","account","this","ride","thin","of","meet","control","process","tax","high","something","slip","hit","sit","six","forest","animal","instead","stock","farm","stop","collection","Mrs","light","element","chief","allow","move","including","choose","dad","material","mention","front","day","truth","society","measure","our","differ","sexual","special","out","plural","red","dictionary","spot","yard","her","could","keep","length","south","suffix","scene","owner","quality","management","system","their","attack","final","shell","exactly","environmental","noun","herself","institution","neck","steel","bed","individual","tonight","gentle","have","need","clearly","afraid","agency","able","mix","which","so","who","eight","segment","class","gather","disease","face","painting","fact","son","bring","fear","debate","decade","staff","knowledge","tire","should","employee","local","hope","meant","beat","bear","gray","organ","stuff","she","contain","won't","view","national","pitch","computer","wire","pattern","tend","favor","state","Republican","PM","ability","joy","Democrat","job","key","police","instant","career","equal","drug","admit","wall","walk","laugh","table","poem","cent","treat","kitchen","general","present","plain","value","will","wild","almost","thus","site","surface","partner","perhaps","began","administration","cross","member","strange","inch","party","difficult","ball","slave","drink","upon","effect","student","off","center","weapon","well","thought","position","usual","less","executive","distant","tone","skill","supply","sky","lake","realize","add","book","citizen","match","government","five","whatever","press","loss","necessary","like","lost","lose","become","soft","page","because","village","authority","hair","growth","proper","home","lead","broad","avoid","does","leader","locate","noise","pressure","although","stage","sister","column","own","weather","tiny","buy","north","but","ear","eat","he","count","made","whether","wish","official","record","problem","piece","recognize","education","happen","spell","loud","detail","other","branch","repeat","star","worker","stay","chance","rule"];




autocomplete(document.getElementById("inputField"), words);
    </script>
