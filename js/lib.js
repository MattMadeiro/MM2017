function MadeiroStore() {
  riot.observable(this); // Riot provides our event emitter.

  var self = this;

  self.GET = function(url, callback){
    var xmlhttp;
    // compatible with IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function(){
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
          callback(xmlhttp.responseText);
        }
    }
    xmlhttp.open("GET", url, true);
    xmlhttp.send();
  }

  self.articles = [
      {
        "title": "Why I Don't Read Health Blogs Anymore",
        "date": "2015-01-15",
        "slug": "health",
        "category": "none"
      },
      {
        "title": "How to Live a Life Without Fear",
        "date": "2014-07-31",
        "slug": "fear",
        "category": "The Bigger Picture"
      },
      {
        "title": "The Last Stop on the Road",
        "date": "2014-04-23",
        "slug": "last-stop",
        "category": "The Bigger Picture"
      },
      {
        "title": "10 Truths I Hope I Never Forget",
        "date": "2013-09-09",
        "slug": "10-truths",
        "category": "The Bigger Picture"
      },
      {
        "title": "The Secrets of an Endless Optimist",
        "date": "2012-07-05",
        "slug": "optimist",
        "category": "The Bigger Picture"
      },
      {
        "title": "The One Question That Everyone Asks",
        "date": "2014-06-10",
        "slug": "one-question",
        "category": "The Big Damn Trip"
      },
      {
        "title": "Life Lessons From a Stick of Seaweed",
        "date": "2013-08-01",
        "slug": "seaweed",
        "category": "The Big Damn Trip"
      },
      {
        "title": "To the Guy Who Stole My iPod",
        "date": "2013-08-22",
        "slug": "ipod",
        "category": "Lessons Hard Learned"
      },
      {
        "title": "Am I Ready for This?",
        "date": "2013-04-13",
        "slug": "ready",
        "category": "Lessons Hard Learned"
      },
      {
        "title": "You Pack Your Own Bags",
        "date": "2013-12-05",
        "slug": "bags",
        "category": "The Blue Period"
      },
      {
        "title": "A Few Thoughts on Dying",
        "date": "2013-09-14",
        "slug": "dying",
        "category": "The Blue Period"
      },
      {
        "title": "Why I Might Actually be a Phony",
        "date": "2013-05-17",
        "slug": "phony",
        "category": "The Blue Period"
      },
      {
        "title": "I Met My Brother in Mexico",
        "date": "2014-07-01",
        "slug": "mexico",
        "category": "All in the Family"
      },
      {
        "title": "To My Father",
        "date": "2013-06-07",
        "slug": "father",
        "category": "All in the Family"
      },
      {
        "title": "To My Mother",
        "date": "2013-05-12",
        "slug": "mother",
        "category": "All in the Family"
      },
      {
        "title": "What I Wish I'd Known Before Going to College",
        "date": "2013-10-30",
        "slug": "college",
        "category": "The Days of My Youth"
      },
      {
        "title": "8,000 Miles From Who I Used to Be",
        "date": "2013-07-08",
        "slug": "miles",
        "category": "The Days of My Youth"
      },
      {
        "title": "How to Act Like a Kid Again",
        "date": "2012-07-18",
        "slug": "kid",
        "category": "The Days of My Youth"
      }
    ];
  self.slugs = _.map(self.articles, 'slug');

  self.on('load_article', function(slug){
    if(_.includes(self.slugs, slug)) {
      self.GET('secrets/data/articles/' + slug + '.html', function(html){
        if(html) {
          var article = _.find(self.articles, ['slug', slug]);
          self.trigger('article_loaded', article.title, article.date, html);
        }
      });
    }
    else {
      console.log("Article doesn't exist.");
      self.trigger('article_loaded', null, null, null);
    }
  });

};


// Riot Control.

var RiotControl = {
  _stores: [],
  addStore: function(store) {
    this._stores.push(store);
  },
  reset: function() {
    this._stores = [];
  }
};

['on','one','off','trigger'].forEach(function(api){
  RiotControl[api] = function() {
    var args = [].slice.call(arguments);
    this._stores.forEach(function(el){
      el[api].apply(el, args);
    });
  };
});

if (typeof(module) !== 'undefined') module.exports = RiotControl;


// randomColor by David Merfield under the CC0 license
// https://github.com/davidmerfield/randomColor/

;(function(root, factory) {

  // Support AMD
  if (typeof define === 'function' && define.amd) {
    define([], factory);

  // Support CommonJS
  } else if (typeof exports === 'object') {
    var randomColor = factory();

    // Support NodeJS & Component, which allow module.exports to be a function
    if (typeof module === 'object' && module && module.exports) {
      exports = module.exports = randomColor;
    }

    // Support CommonJS 1.1.1 spec
    exports.randomColor = randomColor;

  // Support vanilla script loading
  } else {
    root.randomColor = factory();
  }

}(this, function() {

  // Seed to get repeatable colors
  var seed = null;

  // Shared color dictionary
  var colorDictionary = {};

  // Populate the color dictionary
  loadColorBounds();

  var randomColor = function (options) {

    options = options || {};

    // Check if there is a seed and ensure it's an
    // integer. Otherwise, reset the seed value.
    if (options.seed !== undefined && options.seed !== null && options.seed === parseInt(options.seed, 10)) {
      seed = options.seed;

    // A string was passed as a seed
    } else if (typeof options.seed === 'string') {
      seed = stringToInteger(options.seed);

    // Something was passed as a seed but it wasn't an integer or string
    } else if (options.seed !== undefined && options.seed !== null) {
      throw new TypeError('The seed value must be an integer or string');

    // No seed, reset the value outside.
    } else {
      seed = null;
    }

    var H,S,B;

    // Check if we need to generate multiple colors
    if (options.count !== null && options.count !== undefined) {

      var totalColors = options.count,
          colors = [];

      options.count = null;

      while (totalColors > colors.length) {

        // Since we're generating multiple colors,
        // incremement the seed. Otherwise we'd just
        // generate the same color each time...
        if (seed && options.seed) options.seed += 1;

        colors.push(randomColor(options));
      }

      options.count = totalColors;

      return colors;
    }

    // First we pick a hue (H)
    H = pickHue(options);

    // Then use H to determine saturation (S)
    S = pickSaturation(H, options);

    // Then use S and H to determine brightness (B).
    B = pickBrightness(H, S, options);

    // Then we return the HSB color in the desired format
    return setFormat([H,S,B], options);
  };

  function pickHue (options) {

    var hueRange = getHueRange(options.hue),
        hue = randomWithin(hueRange);

    // Instead of storing red as two seperate ranges,
    // we group them, using negative numbers
    if (hue < 0) {hue = 360 + hue;}

    return hue;

  }

  function pickSaturation (hue, options) {

    if (options.luminosity === 'random') {
      return randomWithin([0,100]);
    }

    if (options.hue === 'monochrome') {
      return 0;
    }

    var saturationRange = getSaturationRange(hue);

    var sMin = saturationRange[0],
        sMax = saturationRange[1];

    switch (options.luminosity) {

      case 'bright':
        sMin = 55;
        break;

      case 'dark':
        sMin = sMax - 10;
        break;

      case 'light':
        sMax = 55;
        break;
   }

    return randomWithin([sMin, sMax]);

  }

  function pickBrightness (H, S, options) {

    var bMin = getMinimumBrightness(H, S),
        bMax = 100;

    switch (options.luminosity) {

      case 'dark':
        bMax = bMin + 20;
        break;

      case 'light':
        bMin = (bMax + bMin)/2;
        break;

      case 'random':
        bMin = 0;
        bMax = 100;
        break;
    }

    return randomWithin([bMin, bMax]);
  }

  function setFormat (hsv, options) {

    switch (options.format) {

      case 'hsvArray':
        return hsv;

      case 'hslArray':
        return HSVtoHSL(hsv);

      case 'hsl':
        var hsl = HSVtoHSL(hsv);
        return 'hsl('+hsl[0]+', '+hsl[1]+'%, '+hsl[2]+'%)';

      case 'hsla':
        var hslColor = HSVtoHSL(hsv);
        return 'hsla('+hslColor[0]+', '+hslColor[1]+'%, '+hslColor[2]+'%, ' + Math.random() + ')';

      case 'rgbArray':
        return HSVtoRGB(hsv);

      case 'rgb':
        var rgb = HSVtoRGB(hsv);
        return 'rgb(' + rgb.join(', ') + ')';

      case 'rgba':
        var rgbColor = HSVtoRGB(hsv);
        return 'rgba(' + rgbColor.join(', ') + ', ' + Math.random() + ')';

      default:
        return HSVtoHex(hsv);
    }

  }

  function getMinimumBrightness(H, S) {

    var lowerBounds = getColorInfo(H).lowerBounds;

    for (var i = 0; i < lowerBounds.length - 1; i++) {

      var s1 = lowerBounds[i][0],
          v1 = lowerBounds[i][1];

      var s2 = lowerBounds[i+1][0],
          v2 = lowerBounds[i+1][1];

      if (S >= s1 && S <= s2) {

         var m = (v2 - v1)/(s2 - s1),
             b = v1 - m*s1;

         return m*S + b;
      }

    }

    return 0;
  }

  function getHueRange (colorInput) {

    if (typeof parseInt(colorInput) === 'number') {

      var number = parseInt(colorInput);

      if (number < 360 && number > 0) {
        return [number, number];
      }

    }

    if (typeof colorInput === 'string') {

      if (colorDictionary[colorInput]) {
        var color = colorDictionary[colorInput];
        if (color.hueRange) {return color.hueRange;}
      }
    }

    return [0,360];

  }

  function getSaturationRange (hue) {
    return getColorInfo(hue).saturationRange;
  }

  function getColorInfo (hue) {

    // Maps red colors to make picking hue easier
    if (hue >= 334 && hue <= 360) {
      hue-= 360;
    }

    for (var colorName in colorDictionary) {
       var color = colorDictionary[colorName];
       if (color.hueRange &&
           hue >= color.hueRange[0] &&
           hue <= color.hueRange[1]) {
          return colorDictionary[colorName];
       }
    } return 'Color not found';
  }

  function randomWithin (range) {
    if (seed === null) {
      return Math.floor(range[0] + Math.random()*(range[1] + 1 - range[0]));
    } else {
      //Seeded random algorithm from http://indiegamr.com/generate-repeatable-random-numbers-in-js/
      var max = range[1] || 1;
      var min = range[0] || 0;
      seed = (seed * 9301 + 49297) % 233280;
      var rnd = seed / 233280.0;
      return Math.floor(min + rnd * (max - min));
    }
  }

  function HSVtoHex (hsv){

    var rgb = HSVtoRGB(hsv);

    function componentToHex(c) {
        var hex = c.toString(16);
        return hex.length == 1 ? '0' + hex : hex;
    }

    var hex = '#' + componentToHex(rgb[0]) + componentToHex(rgb[1]) + componentToHex(rgb[2]);

    return hex;

  }

  function defineColor (name, hueRange, lowerBounds) {

    var sMin = lowerBounds[0][0],
        sMax = lowerBounds[lowerBounds.length - 1][0],

        bMin = lowerBounds[lowerBounds.length - 1][1],
        bMax = lowerBounds[0][1];

    colorDictionary[name] = {
      hueRange: hueRange,
      lowerBounds: lowerBounds,
      saturationRange: [sMin, sMax],
      brightnessRange: [bMin, bMax]
    };

  }

  function loadColorBounds () {

    defineColor(
      'monochrome',
      null,
      [[0,0],[100,0]]
    );

    defineColor(
      'red',
      [-26,18],
      [[20,100],[30,92],[40,89],[50,85],[60,78],[70,70],[80,60],[90,55],[100,50]]
    );

    defineColor(
      'orange',
      [19,46],
      [[20,100],[30,93],[40,88],[50,86],[60,85],[70,70],[100,70]]
    );

    defineColor(
      'yellow',
      [47,62],
      [[25,100],[40,94],[50,89],[60,86],[70,84],[80,82],[90,80],[100,75]]
    );

    defineColor(
      'green',
      [63,178],
      [[30,100],[40,90],[50,85],[60,81],[70,74],[80,64],[90,50],[100,40]]
    );

    defineColor(
      'blue',
      [179, 257],
      [[20,100],[30,86],[40,80],[50,74],[60,60],[70,52],[80,44],[90,39],[100,35]]
    );

    defineColor(
      'purple',
      [258, 282],
      [[20,100],[30,87],[40,79],[50,70],[60,65],[70,59],[80,52],[90,45],[100,42]]
    );

    defineColor(
      'pink',
      [283, 334],
      [[20,100],[30,90],[40,86],[60,84],[80,80],[90,75],[100,73]]
    );

  }

  function HSVtoRGB (hsv) {

    // this doesn't work for the values of 0 and 360
    // here's the hacky fix
    var h = hsv[0];
    if (h === 0) {h = 1;}
    if (h === 360) {h = 359;}

    // Rebase the h,s,v values
    h = h/360;
    var s = hsv[1]/100,
        v = hsv[2]/100;

    var h_i = Math.floor(h*6),
      f = h * 6 - h_i,
      p = v * (1 - s),
      q = v * (1 - f*s),
      t = v * (1 - (1 - f)*s),
      r = 256,
      g = 256,
      b = 256;

    switch(h_i) {
      case 0: r = v; g = t; b = p;  break;
      case 1: r = q; g = v; b = p;  break;
      case 2: r = p; g = v; b = t;  break;
      case 3: r = p; g = q; b = v;  break;
      case 4: r = t; g = p; b = v;  break;
      case 5: r = v; g = p; b = q;  break;
    }

    var result = [Math.floor(r*255), Math.floor(g*255), Math.floor(b*255)];
    return result;
  }

  function HSVtoHSL (hsv) {
    var h = hsv[0],
      s = hsv[1]/100,
      v = hsv[2]/100,
      k = (2-s)*v;

    return [
      h,
      Math.round(s*v / (k<1 ? k : 2-k) * 10000) / 100,
      k/2 * 100
    ];
  }

  function stringToInteger (string) {
    var total = 0
    for (var i = 0; i !== string.length; i++) {
      if (total >= Number.MAX_SAFE_INTEGER) break;
      total += string.charCodeAt(i)
    }
    return total
  }

  return randomColor;
}));







// Riot.route
!function(t){function e(t){return t.split(/[\/?#]/)}function n(t,e){var n=RegExp("^"+e[A](/\*/g,"([^/?#]+?)")[A](/\.\./,".*")+"$"),i=t.match(n)
return i?i.slice(1):void 0}function i(t,e){var n
return function(){clearTimeout(n),n=setTimeout(t,e)}}function r(t){d=i(a,1),E[$](K,d),E[$](N,d),O[$](L,h),t&&a(!0)}function o(){this.$=[],t.observable(this),R.on("stop",this.s.bind(this)),R.on("emit",this.e.bind(this))}function f(t){return t[A](/^\/|\/$/,"")}function u(t){return"string"==typeof t}function c(t){return(t||q.href)[A](y,"")}function s(t){return"#"==p[0]?(t||q.href||"").split(p)[1]||"":(q?c(t):t||"")[A](p,"")}function a(t){var e,n=0==z
if(!(z>=T)&&(z++,j.push(function(){var e=s();(t||e!=m)&&(R[S]("emit",e),m=e)}),n)){for(;e=j.shift();)e()
z=0}}function h(t){if(!(1!=t.which||t.metaKey||t.ctrlKey||t.shiftKey||t.defaultPrevented)){for(var e=t.target;e&&"A"!=e.nodeName;)e=e.parentNode
!e||"A"!=e.nodeName||e[x]("download")||!e[x]("href")||e.target&&"_self"!=e.target||-1==e.href.indexOf(q.href.match(y)[0])||(e.href==q.href||!(e.href.split("#")[0]==q.href.split("#")[0]||"#"!=p[0]&&0!==c(e.href).indexOf(p)||"#"==p[0]&&e.href.split(p)[0]!=q.href.split(p)[0])&&l(s(e.href),e.title||O.title))&&t.preventDefault()}}function l(t,e,n){return k?(t=p+f(t),e=e||O.title,n?k.replaceState(null,e,t):k.pushState(null,e,t),O.title=e,_=!1,a(),_):R[S]("emit",s(t))}var d,p,m,v,b,y=/^.+?\/\/+[^\/]+/,g="EventListener",w="remove"+g,$="add"+g,x="hasAttribute",A="replace",K="popstate",N="hashchange",S="trigger",T=3,E="undefined"!=typeof window&&window,O="undefined"!=typeof document&&document,k=E&&history,q=E&&(k.location||E.location),D=o.prototype,L=O&&O.ontouchstart?"touchstart":"click",P=!1,R=t.observable(),_=!1,j=[],z=0
D.m=function(t,e,n){!u(t)||e&&!u(e)?e?this.r(t,e):this.r("@",t):l(t,e,n||!1)},D.s=function(){this.off("*"),this.$=[]},D.e=function(t){this.$.concat("@").some(function(e){var n=("@"==e?v:b)(f(t),f(e))
return void 0!==n?(this[S].apply(null,[e].concat(n)),_=!0):void 0},this)},D.r=function(t,e){"@"!=t&&(t="/"+f(t),this.$.push(t)),this.on(t,e)}
var B=new o,C=B.m.bind(B)
C.create=function(){var t=new o,e=t.m.bind(t)
return e.stop=t.s.bind(t),e},C.base=function(t){p=t||"#",m=s()},C.exec=function(){a(!0)},C.parser=function(t,i){t||i||(v=e,b=n),t&&(v=t),i&&(b=i)},C.query=function(){var t={},e=q.href||m
return e[A](/[?&](.+?)=([^&]*)/g,function(e,n,i){t[n]=i}),t},C.stop=function(){P&&(E&&(E[w](K,d),E[w](N,d),O[w](L,h)),R[S]("stop"),P=!1)},C.start=function(t){P||(E&&("complete"==document.readyState?r(t):E[$]("load",function(){setTimeout(function(){r(t)},1)})),P=!0)},C.base(),C.parser(),t.route=C}(riot)
