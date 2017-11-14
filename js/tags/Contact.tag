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