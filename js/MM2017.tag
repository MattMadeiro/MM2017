<Contact>

	<div class='contact cf bg-dijon' onclick={ clickFocus }>

		<div class='w-100 w-25-ns bb bn-ns fl overflow-x-auto overflow-x-visible-ns horizontal-flow nowrap ws-normal-ns'>
			<h3 class='dn db-ns pl3 ttu f6 white fw3'>Channels <span class='black-50 ml1'>({_.keys(allBlurbs).length})</span></h3>
			<ul class='list pa0 ma0 mb4-ns dib db-ns'>
				<li onclick={ changeView.bind(this, 'advice') } class='{ linkCSS }{ currentView == "advice" ? "active" : "" }'><span class='white-50 mr1'>#</span>advice</li>
				<li onclick={ changeView.bind(this, 'tech') } class='dn db-ns { linkCSS }{ currentView == "tech" ? "active" : "" }'><span class='white-50 mr1'>#</span>tech</li>
				<li onclick={ changeView.bind(this, 'work') } class='{ linkCSS }{ currentView == "work" ? "active" : "" }'><span class='white-50 mr1'>#</span>work</li>
			</ul>

			<h3 class='dn db-ns pl3 ttu f6 white fw3'>Messages <span class='black-50 ml1'>(1)</span></h3>
			<ul class='list pa0 ma0 mb3-ns dib db-ns'>
				<li onclick={ changeView.bind(this, 'matt') } class='{ linkCSS }{ currentView == "matt" ? "active" : "" }'>matt</li>
			</ul>
		</div>

		<div class='w-100 w-75-ns fl bl-ns bg-white overflow-auto' style='min-height: {parent.style.height}px;'>

			<ol class='list pa0 ma0 pt3' if={currentView != "matt"}>

				<li each={ blurbs } class='cf pb1 mb3 bb b--black-20'>
					<div class='fl dn db-ns pa3 pt0 ma0 relative' style="width: 25%; max-width: 60px">
						<img if={author == "matt"} src="./icons/moi.jpg" class='absolute' />
						<div if={author != "matt"} class=''>
							<i class='db' style="width: 48px; height: 48px; background-color: { getRandomColor() }"></i>
						</div>
					</div>
					<div class='fl w-80 pl3'>
						<p class='pa0 b ma0 mb2'>{ author }</p>
						<p each={ msg, i in messages } class='pa0 ma0 pb1 mb2 near-black lh-copy'>
							<RawHTML html="{ parseMessage(msg) }"></RawHTML>
						</p>
						<p class='pa0 ma0 pb2 mb2 lh-copy' if={ final }>
							{ final[0] } <a class='link blue ma0 pa0' href="#" onclick={ parent.changeView.bind(parent, 'matt') } >{ final[1] }</a>
						</p>
					</div>
				</li>

			</ol>

			<form class='pt3 cf' if={ currentView == "matt"}>

				<div class='cf pb1 mb4 bb b--black-20'>
					<div class='fl dn db-ns pa3 pt0 ma0 relative' style="width: 25%; max-width: 60px">
						<img src="./icons/moi.jpg" class='absolute' />
					</div>
					<div class='fl w-80 pl3'>
						<p class='pa0 b ma0 mb2'>matt</p>
						<p class='pa0 ma0 pb1 mb2 near-black lh-copy measure'>Thanks for reaching out! I'll respond to you as soon as I'm able &mdash; typically in a few days. If you need to reach me sooner, <a class='link blue' target="_blank" href="http://twitter.com/MattMadeiro">send me a tweet</a>. If email is more your thing, however, hit me up <a class="link blue" target="_blank" href="mailto:contact@mattmadeiro.com">right here</a>.</p>
					</div>
				</div>

			</form>

		</div>

	</div>

	<style scoped>
		.link-hover:hover {
			background-color: rgba(0,0,0,.35);
		}
		.active {
			background-color: rgba(0,0,0,.6);
		}
		.active.link-hover:hover {
			background-color: rgba(0,0,0,.6);
		}
	</style>

	<script>

		this.currentView = null;
		this.linkCSS = "dib db-ns link-hover pl3 pr3 pv2 pv1-ns pointer fw3 white ";
		this.blurbs = [];
		this.allBlurbs = {
			"advice": [
				{
					author: "matt",
					messages: ["Questions about travel? Coding? Books? Board games?"]
				},
				{
					author: "you",
					messages: ["I am curious about approximately none of those things."]
				},
				{
					author: "matt",
					messages: ["T-that's fine. I don't know everything, but I know enough to be dangerous."],
					final: ["Want advice on anything? I'd love to meet you!", "Hit me up."]
				},
			],
			"tech": [
				{
					author: "matt",
					messages: ["This site was built with <a target='_blank' class='link blue' href='http://riotjs.com'>RiotJS</a>. (Imagine React, except simpler and less terrifying). Styling is provided by <a target='_blank' class='link blue' href='http://tachyons.io'>tachyons</a>, arguably the best thing that has happened to CSS in recent memory."]
				},
				{
					author: "matt",
					final: ["If you're curious about either one, or curious about how and why I used them to build this awkward, colorful thing, you know what to do.", "Get in touch!"]
				},
			],
			"work": [
				{
					author: "matt",
					messages: ["Hey, thanks for asking!", "As of August 2016, I'm leading front-end design and development of a pretty badass IoT application for Meshify in Houston, TX.","I can't stop sweating. Please send coconut water."]
				}
			]
		}

		this.changeView = function(name) {
			this.currentView = name;
			this.blurbs = this.allBlurbs[name];
		}

		this.getRandomColor = function(){
			return randomColor({luminosity: "light"});
		}

		this.parseMessage = function(msg) {
			var link = "<a href='#'>message</a>";
			return msg.replace(/@/g, link);
		}

		this.on('mount', function(){
			this.changeView('advice');
			this.update();
		});

	</script>

</Contact>
<Documents>

	<article ref="doc" class='documents overflow-y-auto cf bg-white f5 pb3 pb0-l f4-ns lh-copy avenir' if={ article.html && loaded }>
		<header class='bb b--black-20 pa3'>
			<h1 class='mv2 f4 f2-m f1-l lh-title'>{article.title}</h1>
			<time class='f5 gray lh-copy mb4'>{article.date}</time>
		</header>
		<div class='pa3 measure-wide'>
			<RawHTML html={ article.html }></RawHTML>
		</div>
	</article>

	<div class='pa3 tc' if={ !article.html && loaded }>
		<h1 class='f2 mv2 lh-title black-90'>Article not found. :(</h1>
		<p class='f5 gray lh-copy'>
			But don't sweat it.
			<span class='dn-ns'>Hit the back button below to return to the full list of articles.</span>
			<span class='dn di-l'>Why not choose one from the list over to the left?</span>
		</p>
	</div>

	<div class='absolute bg-light-gray bt w-100 bw1 b--black db dn-l' style="bottom: 0; left: 0">
		<button class='ma0 link f4 db bg-light-gray pv1 br bw1 b--black hover-invert pointer' onclick={ backToList } style="width: 15%" aria-label="Return to Main Favorites List">
			<svg class="db center icon icon-arrow-left" aria-hidden="true"><use xlink:href="#icon-arrow-left"></use></svg>
		</button>
	</div>

	<style scoped>
		button {
            border-left-style: none;
            border-top-style: none;
            border-bottom-style: none;
        }
	</style>

	<script>

		var tag = this;
		var parent = tag.parent;
		tag.article = {};
		tag.loaded = false;

		tag.backToList = function(e) {
			parent.clickClose(e);
			parent.parent.startApp('writing');
		}

		RiotControl.on('article_loaded', function(title, date, html){
			tag.loaded = true;
			tag.article = {
				title: title,
				date: date,
				html: html
			};
			tag.update();
		});

		tag.on('update', function(){
			parent.refs.container.scrollTop = 0;
		});

		tag.on('unmount', function(){
			RiotControl.off('article_loaded');
		});

	</script>

</Documents>
<Favorites>

	<div if={ !currentPeep } class='favorites overflow-y-auto' style="max-height: {parent.style.height}px" ref="list">

		<div each={ peeps, char in byLastName }>

			<p class="bg-dijon bt bb b--black-80 white pl3 pv1 ma0 f6 fw3">{ char }</p>

			<ul class='list pa0 ma0 cf' style="-webkit-overflow-scrolling: touch;">

				<li each={ peep in peeps } onclick={ parent.showProfile } class='peep cf w-100 bb b--black-20 pt2 pb2 pointer pl3'>
					<a class='db no-underline black pv1' href="#favorites">{ peep.first } <span class='b'>{ peep.last }</span></a>
				</li>

			</ul>

		</div>

	</div>

	<div class='db cf overflow-y-auto' style="max-height: {parent.style.height}px" if={ currentPeep }>

		<article class='bg-white db'>

			<div class='cf pv2 bb b--light-silver'>

				<h2 class='f3 pl3 b mb2 pt3 mt0 black-90'>{ currentPeep.first + " " + currentPeep.last }</h2>
				<a href="http://{ currentPeep.website }" target="_blank" class='pl3 pt2 pb3 db link blue fw2 mt2' if={ currentPeep.website != null }>http://{ currentPeep.website }</a>

				<ul class='list ma0 mt1 pb3 pl3' if={ hasSocial() }>
					<li class='dib mr3' if={ currentPeep.twitter }>
						<a target="_blank" class='link blue f5 db' href="http://twitter.com/{ currentPeep.twitter }">
							<svg class="icon icon-twitter" aria-labelledby="Twitter"><use xlink:href="#icon-twitter"></use></svg>
						</a>
					</li>
					<li class='dib mr3' if={ currentPeep.instagram }>
						<a target="_blank" class='link blue f5 db' href="http://instagram.com/{ currentPeep.instagram }">
							<svg class="icon icon-instagram" aria-labelledby="Instagram"><use xlink:href="#icon-instagram"></use></svg>
						</a>
					</li>
					<li class='dib mr3' if={ currentPeep.facebook }>
						<a target="_blank" class='link blue f5 db' href="http://facebook.com/{ currentPeep.facebook }">
							<svg class="icon icon-facebook" aria-labelledby="Facebook"><use xlink:href="#icon-facebook"></use></svg>
						</a>
					</li>
				</ul>

			</div>

			<div class='cf pt1 pb4'>
				<h3 class='pl3 mb2 mt3 light-silver fw2 i f6'>Notes</h3>
				<ul class='list pa0 pr3'>
					<li class='pl3 black-90 lh-copy measure' each={ note, i in [currentPeep.notes]  }><RawHTML html="{ note }"></RawHTML></li>
				</ul>
			</div>

			<div class='absolute bg-light-gray bt w-100 bw1 b--black' style="bottom: 0; left: 0">
				<button class='ma0 link f4 db bg-light-gray pv1 br bw1 b--black hover-invert pointer' onclick={ backToList } style="width: 15%" aria-label="Return to Main Favorites List">
					<svg class="db center icon icon-arrow-left" aria-hidden="true"><use xlink:href="#icon-arrow-left"></use></svg>
				</button>
			</div>

		</article>



	</div>

	<style scoped>
		.peep:hover {
			background-color: #eee;
		}
		button {
            border-left-style: none;
            border-top-style: none;
            border-bottom-style: none;
        }
	</style>

	<script>

		var tag = this;
		tag.peeps = [];
		tag.byLastName = {};
		tag.lastnames = [];
		tag.currentPeep = false;
		tag.storedScroll = 0;

		tag.showProfile = function(e) {
			tag.storePosition();
			tag.currentPeep = e.item.peep;
		}

		tag.showList = function(e) {
			tag.currentPeep = false;
		}

		tag.storePosition = function(){
			tag.storedScroll = tag.refs.list.scrollTop;
		}

		tag.hasSocial = function(){
			return tag.currentPeep.twitter || tag.currentPeep.instagram || tag.currentPeep.facebook;
		}

		tag.checkFinal = function(){
			if(tag.currentPeep.twitter && tag.currentPeep.instagram) {
				return '';
			}
			return 'br b--light-silver';
		}

		tag.backToList = function(){
			tag.currentPeep = false;
		}

		RiotControl.on('favorites_list', function(favorites){
			tag.peeps = _.orderBy(favorites, 'last', 'asc');
			tag.byLastName = _.groupBy(tag.peeps, function(peep){
				return peep.last.charAt(0);
			});
			if(tag.isMounted) {
				console.log(tag.byLastName);
				tag.update();
			}
		});

		tag.on('updated', function(){
			if(!tag.currentPeep && tag.storedScroll) {
				tag.refs.list.scrollTop = tag.storedScroll;
				tag.storedScroll = 0;
			}
		});

		tag.on('mount', function(){
            RiotControl.trigger('favorites_init');
        });

	</script>

</Favorites>
<GuestBook>

	<div class='guestbook' onclick={ clickFocus }>

		<div class='bg-white overflow-y-auto' style="max-height: {parent.style.height}px" if={ showingList }>
			<div class='tc pv3 bb b--black-80'>
				<NotButton title="Sign the Guest Book" onclick="{ toggleView }"></NotButton>
			</div>
			<ul class='list pl0 ma0' ref="messages" if={ messages.length }>

				<li each={ messages } class='bb cf pt3 pt0-ns pl4-ns' style='background-color: {color}'>
					<div class='pl3 pr3 w-100 fl bl-ns bg-white' style='min-height: 100px'>
						<p class=''><span class='b f5'>{ formatOutput(name) }</span><span class='light-silver fw4 ml3 f6'>{ formatOutput(location) }</span></p>
						<p class="near-black f6 pb2 pt1 lh-copy measure" style="white-space: pre-wrap">{ formatOutput(message) }</p>
					</div>
				</li>

			</ul>

			<p class='tc pl3 pa0 ma0 mt4 f5 gray' if={ !messages.length }>Nothing here just yet. :(</p>

		</div>

		<div if={ !showingList } class='cf' onclick={ chooseColor }>
			<div class='pl3 pv3'>
				<NotButton title="Back to List" onclick="{ toggleView }"></NotButton>
			</div>
			<form class='pt3'>

				<div class='pl3 pr3 pb2 w-100 mb3 '>
					<label for="author" class='db b mb1 f6 ttu'>Name</label>
					<input onclick={ dontChangeColor } class='input-reset pv2 ph2 w-100 ba bw1 b--black' type="text" ref="author">
				</div>

				<div class='pl3 pr3 pb2 w-100 mb3 '>
					<label for="location" class='db b mb1 f6 ttu'>Location</label>
					<input onclick={ dontChangeColor } class='input-reset pv2 ph2 w-100 ba bw1 b--black' type="text" ref="location">
				</div>

				<div class='pl3 pr3 pb0 pb2-l w-100 mb3 '>
					<label for="message" class='db b mb1 f6 ttu'>Message</label>
					<textarea onclick={ dontChangeColor } class='input-reset pv2 ph2 w-100 ba bw1 b--black' ref="message" style='min-height: 120px'></textarea>
				</div>

				<div class='pr3 pv3 fr'>
					<NotButton title="Submit" onclick='{ submitForm }'></NotButton>
				</div>

			</form>
		</div>
	</div>

	<script>

		var tag = this;
		var parent = tag.parent;
		tag.messages = [];
		tag.authorColor = randomColor({luminosity: 'light'});
		tag.showingList = true;

		tag.toggleView = function(e){
			if(typeof e != 'undefined') {
				e.stopPropagation();
			}
			tag.showingList = !tag.showingList;
			if(tag.showingList) {
				parent.refs.container.style.backgroundColor = "#ffffff";
				tag.update();
			}
			else {
				tag.chooseColor();
			}

		}

		tag.formValid = function(){
			return tag.refs.author.value.length > 1 && tag.refs.location.value.length > 1 && tag.refs.message.value.length > 2;
		}

		tag.submitForm = function(e) {
			e.stopPropagation();
			e.preventDefault();
			if(tag.formValid()) {
				var payload = {
					name: tag.escapeInput(tag.refs.author.value),
					location: tag.escapeInput(tag.refs.location.value),
					msg: tag.escapeInput(tag.refs.message.value),
					color: tag.authorColor
				}
				RiotControl.trigger('guestbook_add', payload);
				tag.refs.author.value = '';
				tag.refs.location.value = '';
				tag.refs.message.value = '';
				tag.toggleView();
			}
		}

		tag.escapeInput = function(str) {
			var replaced = str.replace(/(?:\r\n|\r|\n)/g, '<br />');
			return replaced.replace(/,/g, '~');
		}

		tag.formatOutput = function(str) {
			var replaced = str.replace(/~/g, ',');
			return replaced.split("<br />").join("\n\r");
		}

		tag.setScroll = function(){
			tag.output.scrollTop = tag.output.scrollHeight;
		}

		tag.chooseColor = function(){
			tag.authorColor = randomColor({luminosity: 'light'});
			parent.refs.container.style.backgroundColor = tag.authorColor;
			tag.update();
		}

		tag.dontChangeColor = function(e){
			e.stopPropagation();
		}

		RiotControl.on('guestbook_list', function(entries){
			tag.messages = entries;
			if(tag.isMounted) {
				tag.update();
			}
		});

		tag.on('mount', function(){
			RiotControl.trigger('guestbook_init');
		});

	</script>

</GuestBook>
<Library>

	<div class='library bg-white'>

		<ul class='list pl0 ma0 overflow-y-auto cf pb4' style="max-height: {parent.style.height}px" name="books">

			<li each={ book in books } class='book w-50 w-third-ns fl'>
				<a href="{ book.amazon }" target="_blank" class='no-underline tc blue db'>
					<div class='aspect-ratio aspect-ratio--1x1 db mb2'>
						<img alt="The book cover for { book.name } by { book.author }." src="images/{ book.filename }-o.jpg" class='absolute' style="left: 25%; width: 50%; bottom: 0" />
					</div>
					<cite class='near-black f6 tc db mb2 link blue'>{ book.name }</cite>
					<p class='gray f6 ma0'>{ book.author }</p>
				</a>
			</li>

		</ul>

	</div>

	<script>

		var self = this;
		this.books = [];

		this.setScroll = function(){
			this.output.scrollTop = this.output.scrollHeight;
		}

		RiotControl.on('library_list', function(books){
			self.books = books;
			self.update();
		});

		this.on('mount', function(){
			RiotControl.trigger('library_init');
		});

	</script>

</Library>
<MadeirOS>

    <nav class='bg-white bb bw1' ref="nav">
        <ul class='list pl0 pv2 ma0'>
            <li class='dib ml3 ml4-l i f4-ns f5'>madeirOS</li>
            <li class='dib ml4 f6 f5-ns'>File</li>
            <li class='dib ml4 f6 f5-ns'>Edit</li>
            <li class='dib ml4 f6 f5-ns'><a class='link blue' href="#help">Help</a></li>
        </ul>
    </nav>

    <div class='cf absolute w-100 mt3' style="z-index: 1; top: 50px">
        <Icons items={icons}></Icons>
    </div>

    <div role="main" class='cf absolute w-100' style="z-index: 5;">
        <App each={ openApps }></App>
    </div>

    <script>

        var tag = this;
        tag.localZ = 10;
        tag.currentTheme = 1;
        tag.onPhone = false;

        tag.apps = _.valuesIn(opts.apps);
        tag.icons = _.valuesIn(opts.apps);
        _.remove(tag.icons, function(app){
            return _.has(app, 'icon') && !app.icon;
        });
        tag.openApps = [];

        tag.closeApp = function(item) {

            var index = _.indexOf(tag.openApps, item);

            if(index != -1) {
                tag.openApps.splice(index, 1);
                tag.update();
            }

            riot.route('/');

        }
        tag.startApp = function(name) {
            var app = _.find(tag.apps, function(app){
                return app.tagName.toLowerCase() === name;
            });
            if(typeof app != 'undefined') {
                if(_.indexOf(tag.openApps, app) === -1) {
                    app.style.z = tag.getNextZ();
                    if(tag.onPhone) {
                        tag.openApps = [];
                    }
                    tag.openApps.push(app);
                    tag.update();
                }
            }
        }

        tag.getNextZ = function(){
            tag.localZ += 1;
            return tag.localZ;
        }

        tag.calculateWindowDimensions = function(){
            var wWidth = 0, wHeight = 0;
            if( typeof( window.innerWidth ) == 'number' ) {
                //Non-IE
                wWidth = window.innerWidth;
                wHeight = window.innerHeight;
            }
            else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
                //IE 6+ in 'standards compliant mode'
                wWidth = document.documentElement.clientWidth;
                wHeight = document.documentElement.clientHeight;
            }
            else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
                //IE 4 compatible
                wWidth = document.body.clientWidth;
                wHeight = document.body.clientHeight;
            }
            return {
                width: wWidth,
                height: wHeight
            }
        }

        tag.reloadData = function(){
            var self = this;
            GET('secrets/sourcedata.php', function(sData) {
                sourceData = JSON.parse(sData);
                self._allData = sourceData;
                self.update();
                riot.update();
            });
        }

        tag.checkForPhone = function(){
            tag.mq = window.matchMedia('screen and (min-width: 60em)');
            if(tag.mq.matches) {
                tag.onPhone = false;
            }
            else {
                tag.onPhone = true;
            }
        }

        tag.fetchArticle = function(slug) {
            tag.startApp('documents');
            RiotControl.trigger('load_article', slug);
        }

        tag.setupRoutes = function(){
            riot.route(function(name) {
                tag.startApp(name);
            });
            riot.route('writing/*', function(name){
                tag.startApp('writing');
                tag.fetchArticle(name);
            });
            if(window.location.hash === ''){
                tag.startApp('help');
            }
        }

        tag.on('mount', function(){
            tag.checkForPhone();
            RiotControl.trigger('reload_data');
            RiotControl.one('data_loaded', function(){
                tag.setupRoutes();
                riot.route.start(true);
                tag.update();
            });
        });

    </script>

</MadeirOS>


<Icons>

    <ul role="navigation" class='list pl0 ma0 w-100 w-10-l relative-l fr cf' style='min-width: 150px' each={ apps, i in lists }>
        <li class='mb4 fl w-33 tc w-100-l relative-l' each={ apps }>
            <a href="/#{ tagName.toLowerCase() }" class='no-underline pointer dib'>
                <div class='center mb2' style="width: 75px;">
                    <img aria-hidden="true" name='img' class='mw-100' src="icons/{ tagName }.png" />
                </div>
                <p class='black-80 ma0 fw5 f6 pt1'>{ name }</p>
            </a>
        </li>
    </ul>

    <script>

        var parent = this.parent;
        var tag = this;
        tag.lists = [];
        tag.fullList = [];
        tag.segmented = [];

        tag.prepareLists = function(){
            tag.fullList.push(opts.items);
            tag.segmented.push(_.slice(opts.items, 0, 5));
            tag.segmented.push(_.slice(opts.items, 5, opts.items.length));

            var self = this;
            if(!parent.onPhone) {
                tag.lists = tag.segmented;
            }
            else {
                tag.lists = tag.fullList;
            }
            parent.mq.addListener(function(changed) {
                if(changed.matches) {
                    console.log('use segmented list');
                    self.lists = self.segmented;
                    parent.onPhone = false;
                } else {
                    console.log('use full list');
                    self.lists = self.fullList;
                    parent.onPhone = true;
                }
                self.update();
            });
        }

        tag.on('mount', function(){
            tag.prepareLists();
            tag.update();
        });

    </script>

</Icons>

<App>

    <article ref="{ tagName.toLowerCase() }" class='{!parent.onPhone ? "mw-400" : ''} w-100 w-{style.width}-l bl-l br-l bb-l {draggable ? "bt-l" : ''} bw1-l b--black absolute-l' style='z-index: {style.z}; left: {style.left}px; top: {style.top}px; right: {style.right}px; opacity: 0.999999;' onclick={ clickFocus }>

        <div class='bg-light-gray bb bw1 b--black header' ref="header" id="{ name }">
            <div class='cf overflow-hidden'>
                <div class='fl pv2 w-80 w-90-ns {draggable ? "cursor-move" : ''}'>
                    <h2 class='ma0 ml3 normal fw4 f6 f5-ns ttu tracked'>{name}</h2>
                </div>
                <button class='db bg-light-gray fl w-20 w-10-ns tc pv2 bl bw1 b--black bt-0 br-0 bb-0 hover-invert pointer' onclick={ clickClose } aria-label="Close {name} Window">
                    <svg class="center f4-ns f5 db icon icon-cross" aria-hidden="true">
                        <use xlink:href="#icon-cross"></use>
                    </svg>
                </button>
            </div>
        </div>

        <div class='{style.additionalClasses} overflow-auto' ref="container" style='min-height: {style.height}px; max-height: {style.maxHeight}px'>

            <div data-is="{ tagName }"></div>

        </div>
    </article>

    <style scoped>
        .mw-400 {
            min-width: 400px;
        }
    </style>

    <script>

        var parent = this.parent;
        var tag = this;
        // var tag =
        this.dragging = false;
        this.resized = false;

        this.clickFocus = function(e){
            var curTag = this.refs[this.tagName.toLowerCase()];
            this.style.z = this.parent.getNextZ();
            if(typeof curTag != 'undefined' && _.has(curTag, 'clickFocus')) {
                curTag.clickFocus();
            }
            if(this.tagName.toLowerCase() === 'documents') {
                e.preventUpdate = true;
            }
        }

        this.clickClose = function(e){
            e.stopPropagation();
            e.preventDefault();
            e.preventUpdate = true;
            parent.closeApp(e.item);
        }

        this.calculateAbsolutePosition = function(obj) {
            var curleft = curtop = 0;
            if (obj.offsetParent) {
                do {
                    curleft += obj.offsetLeft;
                    curtop += obj.offsetTop;
                } while (obj = obj.offsetParent);
            }
            return {
                left : curleft,
                top : curtop
            };
        }

        this.handleDrag = function(e) {
            var self = this;

            if(e.which != 1) {
                return;
            }

            this.dragging = true;
            this.style.z = parent.getNextZ();
            var abs = this.calculateAbsolutePosition(e.currentTarget);
            var wDimensions = parent.calculateWindowDimensions();
            var appHeight = this.refs[this.tagName.toLowerCase()].clientHeight;
            var appWidth = this.refs[this.tagName.toLowerCase()].clientWidth;
            document.body.className = 'dragging';
            if(typeof appHeight === 'undefined') {
                var a = this[this.tagName.toLowerCase()];
                appHeight = a[a.length - 1].clientHeight;
                appWidth = a[a.length - 1].clientWidth;
            }

            var offset = {
                left: e.pageX - abs.left,
                top: e.pageY - abs.top + 41
            };

            document.onmouseup = function(){
                self.dragging = false;
                document.body.className = '';
                document.onmousemove = null;
            }

            document.onmousemove = function(e) {

                var x, y, diffX, diffY;
                var prevX = self.style.left, prevY = self.style.top;

                if(!self.dragging) {
                    return;
                }

                if(_.has(e, 'originalEvent')) {
                    x = e.originalEvent.touches ?  e.originalEvent.touches[0].pageX : e.pageX;
                    y = e.originalEvent.touches ?  e.originalEvent.touches[0].pageY : e.pageY;
                } else {
                    x = e.pageX;
                    y = e.pageY;
                }

                x = x - offset.left;
                y = y - offset.top;

                diffX = Math.abs(x - prevX);
                diffY = Math.abs(y - prevY);

                if(diffX >= 200) {
                    return;
                }

                if(x <= 2) {
                    x = 2;
                }
                else if((x + appWidth + 6) >= wDimensions.width) {
                    x = wDimensions.width - appWidth - 6;
                }

                if(y <= 2) {
                    y = 2;
                }
                else if((y + appHeight + 5) >= wDimensions.height - 41) {
                    y = wDimensions.height - appHeight - 47;
                }

                self.style.left = x;
                self.style.top = y;
                self.update();

            }
        }

        this.setDraggable = function() {
            if(TOUCH_ENABLED) {
                this.refs.header.addEventListener('touchstart', this.handleDrag);
            }
            else {
                this.refs.header.addEventListener('mousedown', this.handleDrag);
            }
        }

        tag.setHeight = function(){
            if(parent.onPhone || !tag.draggable) {
                var dimensions = parent.calculateWindowDimensions();
                var navHeight = parent.refs.nav.clientHeight;
                var headerHeight = tag.refs.header.clientHeight;
                tag.style.height = dimensions.height - navHeight - headerHeight - 4;
                tag.style.maxHeight = dimensions.height - navHeight - headerHeight - 4;
                tag.update();
            }
        }

        this.on('mount', function(){
            _.bindAll(this, 'handleDrag');
            if(this.draggable) {
                this.setDraggable();
            }
            setTimeout(tag.setHeight, 5);
            // this.update();
        });

    </script>

</App>

<Help>

    <article class='help ph3 pb4'>

        <p class='near-black pt2 lh-copy'><span class='b'>Hi! Welcome to <strong class='unicorn animate i fw4'>madeirOS</strong> v1.0.</span> (I've worked hard on this, and I'm very eager to show you.)</p>

        <p class='near-black pt1 lh-copy'>My name is Matt Madeiro. I'm a web developer, designer, and <a class='link blue' href="#writing">sometimes-writer</a> based in Houston, Texas. This is all my stuff. I hope you like it! <span class='dn di-ns'>Click all the things, and don't be afraid to move these windows around, too.</span></p>

        <p class='near-black pt1 lh-copy dn-ns b'>To get started, click the big X button in the upper right.</p>

        <p class='near-black pt1 lh-copy'>(Psst. Don't forget to sign the <a class='link blue' href="#guestbook">Guest Book</a> before you leave!)</p>

    </article>

</Help>

<RawHTML>

    <script>
        this.root.innerHTML = this.opts.html;

        this.on('update', function(){
            this.root.innerHTML = this.opts.html;
        });
    </script>

</RawHTML>
<Memories>

	<div class='memories overflow-y-auto cf bg-white' style="max-height: {parent.style.height}px">

		<div if={showWarning}>

			<div class='pa3 bg-light-gray ma3'>
				<p class='ma0 mb3 f6 f5-m f5-l lh-copy b'>Pictures are heavy.</p>
				<p class='ma0 f6 f5-m f5-l lh-copy'>This section features { imageCount } of them, totaling <strong>{ imageWeight } kilobytes of data</strong>. If you're on a cellular connection or have an otherwise limited data plan, you might want to save this section for later. If you're rocking wifi, though, you do you.</p>
			</div>

			<div class='tc mt4 pv2 db cf'>

				<NotButton title="Just the Text is Fine, Thanks" onclick={ startTheShow }></NotButton>

			</div>

			<div class='tc mt3 mt4-l db cf'>

				<NotButton title="Show Me the Photos, Please" onclick={ startWithPictures }></NotButton>

			</div>

		</div>

		<div if={!showWarning} class='cf'>

			<div class='overflow-x-auto overflow-x-visible-ns horizontal-flow nowrap ws-normal-ns mb3'>

				<ol class='list ma0 pa0 pb1-ns pt1-ns bb b--black-80'>
					<li each={year, i in memoryYears} class='dib'>
						<button onclick={changeYear} class='db bg-white bn pointer f4 pa3 pv2 no-underline link {year === chosenYear ? "black-80" : "black-30"}'>{year}</button>
					</li>
				</ol>

			</div>

			<div if={ chosenYear }>

				<article class='pa3 pt2 mb3 bb b--black-20 avenir' each={ memory, i in chosenMemories }>

					<h1 class='mv2 f4 f3-m f2-l lh-title'>{ memory.title }</h1>
					<time class='f5 gray lh-copy mb4'>{ formatDate(memory.date) }</time>

					<p class='f5 f4-m f4-l mt4 lh-copy measure'>
						<RawHTML html="{memory.desc}"></RawHTML>
					</p>

					<img if={ showPictures && memory.imgurl !== "false" } src="/images/{memory.imgurl}-o.jpg" class='measure-m measure-l mw-100 mv3'/>

				</article>

			</div>

		</div>

	</div>

	<script>

		var tag = this;
		tag.showWarning = true;
		tag.showPictures = false;
		tag.imageCount = 0;
		tag.imageWeight = 0;
		tag.allImages = [];
		tag.chosenMemories = [];
		tag.memoryYears = [];
		tag.memoriesByYear = {};
		tag.monthNames = ["January","February","March","April","May","June","July","August","September","October","November","December"];
		tag.chosenYear = false;

		tag.setScroll = function(){
			tag.output.scrollTop = tag.output.scrollHeight;
		}

		tag.calculateWidth = function(){
			return tag.root.querySelector('.memories').clientWidth + "px";
		}

		tag.formatDate = function(date) {
			var parts = date.split('-');
			var d = new Date(parts[0], parts[1] - 1, parts[2]);
			return tag.monthNames[d.getMonth()] + " " + d.getDate() + ", " + parts[0];
		}

		tag.startWithPictures = function(){
			tag.showPictures = true;
			tag.startTheShow();
		}

		tag.startTheShow = function(){
			tag.showWarning = false;
			tag.update();
		}

		tag.changeYear = function(e) {
			tag.chosenYear = e.item.year;
			tag.chosenMemories = tag.memoriesByYear[e.item.year];
			tag.update();
		}

		RiotControl.on('memories_list', function(memories){
			var memories = _.orderBy(memories, 'date', 'desc');
			tag.memoriesByYear = _.groupBy(memories, function(m){
				return m.date.split('-')[0];
			});
			tag.memoryYears = _.sortBy(_.keys(tag.memoriesByYear), function(year){
				return -1 * parseInt(year);
			});
			tag.chosenYear = tag.memoryYears[0];
			tag.chosenMemories = tag.memoriesByYear[tag.chosenYear];
			tag.chosenMemory = tag.chosenMemories[0];
			tag.allImages = _.map(memories, function(m){
				if(m.imgurl != "false") {
					return m.imgurl;
				}
				return false;
			});
			var weights = _.map(memories, function(m){
				var size = parseInt(m.imgsize);
				if(!_.isNaN(size)) {
					tag.imageCount += 1;
					return size;
				}
				return 0;
			});
			tag.imageWeight = _.sum(weights);
			tag.update();
		});

		tag.on('mount', function(){
			RiotControl.trigger('memories_init');
		});

	</script>

</Memories>
<NotButton>

	<button class='ba pa2 ph3 bg-white bw1 b--black tc b f5 pointer hover-invert'>{ opts.title }</button>

</NotButton>
<Terminal>
	<div class='terminal' onclick={ clickFocus }>
		<ul class='list pl0 ma0 b--none overflow-y-auto mw-100 fw2' style="max-height: 230px" ref="output">
			<li each={ msg, i in messages } class='mb2'>
				<p class="ma0 mb2 mw-80 f6 lh-copy">{msg}</p>
			</li>

		</ul>
		<form id="input" ref="input" class='pl3 pb3 w-100' onsubmit={ submitMSG } autocomplete="off">
			$&nbsp;<input type="text" ref="cmd" class='terminal white w-90 input-reset bg-transparent b--none' onkeydown={ handleKey } autofocus>
		</form>
	</div>

	<style scoped>
		.terminal {
			font: 16px/23px Monaco, Courier, font-monospace;
		}
		.blink {
			animation: blink-empty 1s infinite;
  			border-right: transparent solid 0.5em;
		}
		@keyframes blink-empty {
		  50% {border-right: 0.5em solid #333;}
		}
		input:focus {
			outline: none;
		}
		#input {
			position: absolute;
			bottom: 0;
			left: 0;
		}

	</style>

	<script>

		var tag = this;
		tag.messages = [];
		tag.commands = [];
		tag.currentKeys = [];
		tag.konamiKeys = [38,38,40,40,37,39,37,39,66,65];
		tag.currentCommand = 0;

		tag.clickFocus = function(){
			tag.refs.cmd.focus();
		}

		tag.submitMSG = function(e) {
			var val = tag.refs.cmd.value;
			if(val.length > 1) {
				tag.commands.push(val);
				tag.currentCommand = tag.commands.length;
				tag.sendCommand(val.toLowerCase());
				tag.refs.cmd.value = "";
				tag.update();
				tag.setScroll();
			}
			e.preventDefault();
		}

		tag.setScroll = function(){
			tag.refs.output.scrollTop = tag.refs.output.scrollHeight;
		}

		tag.sendCommand = function(cmd) {
			tag.currentKeys = [];
			RiotControl.trigger('terminal_input', cmd);
		}

		tag.clearMessages = function(){
			RiotControl.trigger('terminal_clear');
		}

		tag.checkKonami = function(e) {
			tag.currentKeys.push(e.keyCode);
			if(tag.currentKeys.length === 10) {
				if(_.isEqual(tag.currentKeys, tag.konamiKeys)) {
					tag.konami();
					tag.currentKeys = [];
				}
				else {
					tag.currentKeys = [];
				}
			}
		}

		tag.konami = function(){
			RiotControl.trigger('terminal_msg', "Oh, you.");
			tag.refs.cmd.value = "";
		}

		tag.handleKey = function(e) {
			// console.log(e.keyCode);
			tag.checkKonami(e);
			if(e.keyCode === 38) {
				tag.currentCommand -= 1;
				if(tag.currentCommand < 0) {
					tag.currentCommand = 0;
				}
				tag.refs.cmd.value = typeof tag.commands[tag.currentCommand] != 'undefined' ? tag.commands[tag.currentCommand] : "";
			}
			else if(e.keyCode === 40) {
				tag.currentCommand += 1;
				if(tag.currentCommand >= tag.commands.length) {
					tag.currentCommand = tag.commands.length - 1;
					tag.refs.cmd.value = "";
					return true;
				}
				tag.refs.cmd.value = typeof tag.commands[tag.currentCommand] != 'undefined' ? tag.commands[tag.currentCommand] : "";
			}
		}

		RiotControl.on('terminal_command', function(f){
			tag[f]();
			if(tag.isMounted) {
				tag.update();
			}
		});

		RiotControl.on('terminal_list', function(messages){
			tag.messages = messages;
			if(tag.isMounted) {
				tag.update();
			}
		});

		tag.on('mount', function(){
			tag.refs.cmd.focus();
			RiotControl.trigger('terminal_init');
			tag.update();
		});

	</script>

</Terminal>
<Tools>

	<div class='tools overflow-y-auto cf bg-white' style="max-height: {parent.style.height}px">

		<div each={ tool in tools }>

			<ul class='list pl0 ma0 cf' >

				<li class='tool cf w-100 bb b--black-20 pt3'>
					<a class='link blue pl3 pv3 b f3 f2-ns mt1 mh0 pa0' href="{ tool.link }">{ tool.title }</a>
					<p class='ph3 f5'>{ tool.desc }</p>
					<p class='gray f6 pl3'>{ tool.tech }</p>
				</li>

			</ul>

		</div>

	</div>

	<script>

		var tag = this;
		tag.tools = [];

		RiotControl.on('tools_list', function(tools){
			tag.tools = tools;
			tag.update();
		});

		tag.on('mount', function(){
			RiotControl.trigger('tools_init');
		});

	</script>

</Tools>
<Writing>

	<div class='writing overflow-y-auto cf bg-white' style="max-height: {parent.style.height}px">

		<div class='pa3'>
			<p class='ma0 bg-light-gray pa3 f5 lh-copy'>This is a curated list &mdash; not everything I've written, but the words worth keeping.</p>
		</div>

		<div each={ year, i in articleYears }>

			<p class="bg-dijon bt bb b--black-50 white pl3 pv1 ma0 f6 fw2">{ year }</p>

			<ul class='list pl0 ma0 cf' >

				<li each={ article in articlesByYear[year] } class='article cf w-100 pv2 pv0-ns bb b--black-20'>
					<a class='link blue lh-title fl w-100 w-80-ns mb0 pl3 pr3 pv2 pv3-ns f5' href="#writing/{ article.slug }">{ article.title }</a>
					<span class='db fl w-100 w-20-ns pb2 pb0-ns pv3-ns pl3 pl0-ns pr3 light-silver f6 tr-ns'>{ formatDate(article.date) } { year }</span>
				</li>

			</ul>

		</div>

	</div>

	<script>

		var self = this;
		this.articles = [];
		this.articleYears = [];
		this.articlesByYear = {};
		this.monthNames = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];

		this.calculateHeight = function(){
			return 500;
		}

		this.setScroll = function(){
			this.output.scrollTop = this.output.scrollHeight;
		}

		this.formatDate = function(date) {
			return this.monthNames[new Date(date).getMonth()];
		}

		RiotControl.on('writing_list', function(articles){
			self.articles = _.orderBy(articles, 'date', 'desc');
			self.articlesByYear = _.groupBy(self.articles, function(a){
				return a.date.split('-')[0];
			});
			self.articleYears = _.sortBy(_.keys(self.articlesByYear), function(year){
				return -1 * parseInt(year);
			});
			console.log(self.articlesByYear);
			self.update();
		});

		this.on('mount', function(){
			RiotControl.trigger('writing_init');
		});

	</script>

</Writing>
