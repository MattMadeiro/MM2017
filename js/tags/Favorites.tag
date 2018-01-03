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
				<button class='ma0 link f4 db bg-light-gray pv1 br br0 bw1 b--black hover-invert pointer' onclick={ backToList } style="width: 15%" aria-label="Return to Main Favorites List">
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

		var peeps = [
		  {
		    "first": "David",
		    "last": "Crandall",
		    "website": "crandallography.com",
		    "instagram": "davidcrandall",
		    "twitter": "davidcrandall",
		    "facebook": "davidcrandall",
		    "notes": "David might actually be a unicorn. Despite that (because of it?), he's a genuinely good father, artist, and someone I'm so proud to call friend. One day, he and I will live in the same city. Heads will roll with happiness."
		  },
		  {
		    "first": "Kym",
		    "last": "Pham",
		    "website": "kympham.com",
		    "instagram": "kympham",
		    "twitter": "null",
		    "facebook": "kympham",
		    "notes": "I first met Kym at the inaugural World Domination Summit in Portland, Oregon back in 2011. We shared a mutual fascination for minimalism, bungee jumping, and exploring every other remarkable human being that attended. Years later, her amazing eye—and unending drive for adventure—have lead her to become one of the best things on Instagram. (And, y'know, the world.)"
		  },
		  {
		    "first": "Mark",
		    "last": "Powers",
		    "website": "powerspercussion.com",
		    "instagram": "markpowers",
		    "twitter": "markpowers",
		    "facebook": "markpowers",
		    "notes": "The best damn drummer/<a class='link blue' href='http://www.powerspercussion.com/products/'>children's book author</a> I know, and a genuinely adventurous eater. The days we spent eating our way through Houston are some of my favorite memories of home. Just make sure you ask him about stinky tofu."
		  },
		  {
		    "first": "Chelsea",
		    "last": "Vincent",
		    "website": "chelseavincent.com",
		    "instagram": "cevincen",
		    "twitter": "cevincen",
		    "facebook": "null",
		    "notes": "The most hard-working actor/yogi/badass I know. I've known Chelsea since fourth grade, and even back then I had an inkling she was something remarkable. Her work ethic, to this day, remains unparalleled. Don't ask her about the spare keys, though."
		  },
		  {
		    "first": "Frank",
		    "last": "Chimero",
		    "website": "frankchimero.com",
		    "instagram": "frankchimero",
		    "twitter": "frankchimero",
		    "facebook": "frankchimero",
		    "notes": "Kind of my design idol. I'm only moderately embarrassed to admit that. Have you read his <a href=\"#library\" class='link blue'>book</a>?"
		  },
		  {
		    "first": "Jon",
		    "last": "Gold",
		    "website": "jon.gold",
		    "instagram": "jongold",
		    "twitter": "jongold",
		    "facebook": "jongold",
		    "notes": "One of my favorite follows on Twitter, both for his unending fascination with American patriotism and his super-wonderful home page. (Spoiler alert: it was a fundamental inspiration for my own.)"
		  },
		  {
		    "first": "Rolf",
		    "last": "Potts",
		    "website": "rolfpotts.com",
		    "instagram": "rolfpotts",
		    "twitter": "rolfpotts",
		    "facebook": "rolfpotts",
		    "notes": "His tiny tome to adventure, <a class='link blue' href=\"https://smile.amazon.com/Vagabonding-Uncommon-Guide-Long-Term-Travel/dp/0812992180/ref=sr_1_1?ie=UTF8&qid=1475458070&sr=8-1&keywords=vagabonding\">Vagabonding</a>, was the chief source of motivation for my year-long stay in Southeast Asia. I can't overstate how important this book was to me, and I plan to keep a copy at hand for years to come."
		  },
		  {
		    "first": "Austin",
		    "last": "Kleon",
		    "website": "austinkleon.com",
		    "instagram": "austinkleon",
		    "twitter": "austinkleon",
		    "facebook": "austinkleon",
		    "notes": "My favorite author of \"make shit, and don't feel bad about it.\" I love his no-nonsense approach to art and creativity, and I hope he takes it as a compliment when I say that I plan to steal from him for the rest of my life."
		  },
		  {
		    "first": "Michelle",
		    "last": "Nickolaisen",
		    "website": "bombchelle.com",
		    "instagram": "michelleshock",
		    "twitter": "_ChelleShock",
		    "facebook": "bombchellebiz",
		    "notes": "A writer, entrepreneur, and—in her words!—productivity nerd. On top of all that, though, she's a greatly kind and considerate friend, one of the few people I can honestly say that I'm glad to have met in my years as a Paleo/minimalist/whatever blogger. She can also kick your ass."
		  },
		  {
		    "first": "Trent",
		    "last": "Walton",
		    "website": "trentwalton.com",
		    "instagram": "null",
		    "twitter": "trentwalton",
		    "facebook": "null",
		    "notes": "A tremendous designer, and a huge source of information about typography. I know very little about fonts, still, but what I've gleaned is solely due to his willingness to share with the world wide web. Thanks, Trent."
		  },
		  {
		    "first": "Maggie",
		    "last": "Doyne",
		    "website": "blinknow.org",
		    "instagram": "blinknoworg",
		    "twitter": "blinknow",
		    "facebook": "BlinkNow.org",
		    "notes": "One of the most genuinely caring and selfless human beings I've ever had the pleasure to meet. A genuine inspiration, and the reason I won't forget my 25th birthday anytime soon."
		  },
		  {
		    "first": "Dallas",
		    "last": "Hartwig",
		    "website": "dallashartwig.com",
		    "instagram": "dallashartwig",
		    "twitter": "dallashartwig",
		    "facebook": "mrdallashartwig",
		    "notes": "I'm pretty uncomfortable with how much technology occupies every hour of my day. Dallas is the only author I've encountered who speaks to that exact sentiment, and I'm trying today to take cues from his <a class='link blue' href='http://dallashartwig.com/moresociallessmedia/'>More Social, Less Media</a> movement. He's also a tremendous nature buff, and I am therefore tremendously jelly."
		  },
		  {
		    "first": "Robert",
		    "last": "Florence",
		    "website": "landofexcitement.com",
		    "instagram": "",
		    "twitter": "robertflorence",
		    "facebook": "",
		    "notes": "I blame Robert for a lot of things. He broke my heart when he wrapped his <a class='link blue' href='https://www.rockpapershotgun.com/2016/09/27/cardboard-children-goodbye/#more-401169'>Cardboard Children column</a> over at Rock, Paper Shotgun after six straight years of incredible work. He also hooked me on board games, and my collection continues to grow in the wake of his departure."
		  },
		  {
		    "first": "Quintin",
		    "last": "Smith",
		    "website": "shutupandsitdown.com",
		    "instagram": "",
		    "twitter": "Quinns108",
		    "facebook": "",
		    "notes": "My favorites writer of games is now an integral part of the team over at Shut Up and Sit Down, a site dedicated wholly to bankrupting my wallet with hysterical video reviews of the best board games around. He's also hysterical."
		  },
		  {
		    "first": "Anne",
		    "last": "Lamott",
		    "website": "",
		    "instagram": "",
		    "twitter": "ANNELAMOTT",
		    "facebook": "",
		    "notes": "My writer idol. Her meditation on writing, <em>Bird by Bird</em>, is my favorite on the subject, a warm, richly comedic, and deeply personal introspective on the sort of madness that must possess a person to sit down and try and permanently record their thoughts."
		  },
		  {
		    "first": "Jodi",
		    "last": "Ettenberg",
		    "website": "legalnomads.com",
		    "instagram": "legalnomads",
		    "twitter": "legalnomads",
		    "facebook": "legalnomads",
		    "notes": "Jodi's a former lawyer turned food writer, and one of my favorites at that. There's a lot to admire: her unflinching dedication to traveling alone as a woman for several years going, her unfortunate tendency to be target number one any time a nearby bird decides to poop, and her deep love for soup. We met for a bowl of bun bo hue in Ho Chi Minh, and it stands still as one of my favorite memories from that month in Vietnam. Keep on rocking, Jodi."
		  },
		  {
		    "first": "Emily",
		    "last": "Short",
		    "website": "emshort.wordpress.com",
		    "instagram": "",
		    "twitter": "emshort",
		    "facebook": "",
		    "notes": "My first exposure to interactive fiction came with ADRIFT, a GUI-ified version of traditional IF-making tools. I've long since left that community, but my interest in dynamic fiction and text-based narratives continues still. Emily Short has the distinction of being my favorite gateway to that world: a reflective, measured voice on the development of the medium, with excitement to spare on all that it could offer, and all that it offers today to a staggering array of unique voices."
		  }
		];

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

		tag.on('updated', function(){
			if(!tag.currentPeep && tag.storedScroll) {
				tag.refs.list.scrollTop = tag.storedScroll;
				tag.storedScroll = 0;
			}
		});

        tag.preparePeeps = function(){
        	tag.peeps = _.orderBy(peeps, 'last', 'asc');
        	tag.byLastName = _.groupBy(tag.peeps, function(peep){
        		return peep.last.charAt(0);
        	});
        }

        tag.preparePeeps();

	</script>

</Favorites>