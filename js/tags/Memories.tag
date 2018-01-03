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

		var memories = [
		  {
		    "date": "2014-05-09",
		    "title": "The Big Damn Trip Ends",
		    "imgurl": "false",
		    "imgalt": "",
		    "imgsize": "",
		    "desc": "288 days after this reckless, life-changing journey began, my plane finally touched down in familiar territory: Houston, Texas. I might not know what it looks like, but I'm excited still to begin the next chapter of my life. First, however, I owe my mother several dozen hugs."
		  },
		  {
		    "date": "2014-04-28",
		    "title": "Rode My School Bus",
		    "imgurl": "bus",
		    "imgalt": "A bright yellow school bus with a cheering group of volunteers and Nepalese children in front of it.",
		    "imgsize": 37,
		    "desc": "I rounded out my Big Damn Trip through Asia in the best manner possible: spending an incredible week at the Kopila Valley Children's Home in Surkhet, Nepal. There, amidst the color and commotion of the first week of the school year, I hopped on a familiar yellow school bus and rode along for its first morning route through Surkhet's sleepy streets. Watching the seats crinkle under the weight of dozens of shy, smiling students made for a morning I'll never forget."
		  },
		  {
		    "date": "2014-04-09",
		    "title": "4,130 Meters Above",
		    "imgurl": "annapurna",
		    "imgalt": "Snow-covered peaks as seen from the Annapurna Base Camp.",
		    "imgsize": 66,
		    "desc": "Perched high in the white crags of the Himalaya, the Annapurna Base Camp has quickly--and rightfully--become a rite of passage for Nepali trekkers. My week-long slog there and back forced me to walk uphill six hours daily through sloped farmlands, white rock riverbeds, and slick paths carved into the ice, snow and hail dogging my footsteps through the mountains. Standing at the base camp, blinding white all around, I realized something profound: I'm an idiot. Don't do this in Converse, people. Don't be like Matt."
		  },
		  {
		    "date": "2014-03-09",
		    "title": "Wild Dogs & Dunes",
		    "imgurl": "brothersm",
		    "imgalt": "My brother and myself posing in by the dunes.",
		    "imgsize": 41,
		    "desc": "Slept by the runes of the Thor desert. I woke a little after midnight, choking a little on the camel stench soaked into my blanket. Footsteps filled my ears — soft pads at first, then quiet sniffling. A wild dog came into sight, snout pointed at my group's big pile of backpacks, before loping away on needle-thin legs. My eyes turned back to the stars. I'd never seen them painted in such broad strokes, and for a minute, at least, I forgot to breathe."
		  },
		  {
		    "date": "2013-07-25",
		    "title": "The Big Damn Trip Begins",
		    "imgurl": "tripbegins",
		    "imgalt": "My brother and myself posing in Shangri-la.",
		    "imgsize": 44,
		    "desc": "With my brother beside me, I grabbed a 10kg backpack and set out for a year-long excursion through Southeast Asia. We hit China, Malaysia, Singapore, Indonesia, Vietnam, Laos, Cambodia, Thailand, and India over the course of the journey, making great friends and greater memories all the while. The early plan was to blog the whole experience, keeping family and friends in the loop about our adventures, but the site never materialized. We made a conscious decision, early on, to keep most of the memories to ourselves. That's the antithesis of modern sharing culture, and most certainly didn't boost my Online Blogger Brand, but what we lost in followers, we more than made up for in time spent anywhere but with our screens."
		  },
		  {
		    "date": "2012-12-25",
		    "title": "Bought a School Bus(?)!",
		    "imgurl": "xmas2012",
		    "imgalt": "Matt Madeiro holding a birthday cake with a school bus on top.",
		    "imgsize": 44,
		    "desc": "For my 25th birthday, I decided to do something reckless: give up my birthday and try and raise $25,000 to buy a school bus for the students of Kopila Valley. I still can't believe it worked. I also can't believe we blew straight past to $25K and on to $43,870. <a class='link blue' href='/25'>Read the full story here.</a>"
		  },
		  {
		    "date": "2011-08-09",
		    "title": "My Accidental Acting Debut",
		    "imgurl": "acting",
		    "imgalt": "A screenshot from the music video.",
		    "imgsize": 30,
		    "desc": "On a whim, I attended the filming of Scotty McCreer's debut music video, 'I Love You This Big.' I, uh, didn't know who he was beforehand, but that didn't stop the directors from shoving my plaid-clad self into several <em>pivotal</em> scenes. <a href=\"https://www.youtube.com/watch?v=ZVq8nEHCKd4\">Watch it here</a>, and please pretend that you're impressed."
		  },
		  {
		    "date": "2011-01-10",
		    "title": "Moved to California",
		    "imgurl": "false",
		    "imgalt": "",
		    "imgsize": "",
		    "desc": "Blessed with both restless feet and an amazing friend (with a couch!) in Hollywood, I packed a single backpack and hopped a plane to LA. This simple, strange move kickstarted a year of transformation, laughter, and much debate over who in the hell had the spare keys."
		  },
		  {
		    "date": "1987-12-25",
		    "title": "A Christmas Baby!",
		    "imgurl": "babby",
		    "imgalt": "My mother holding a stocking-clad baby me in her lap.",
		    "imgsize": 13,
		    "desc": "In celebration of my sudden (and safe!) arrival, the doctors slid my tiny baby self into a Christmas stocking before handing me to my mother. 25 years later, this would come back to bite me in the ass."
		  },
		  {
		    "date": "2016-10-01",
		    "title": "Out with the Old, Etc.",
		    "imgurl": "false",
		    "imgalt": "",
		    "imgsize": "",
		    "desc": "The first website I ever built was an awkward Geocities thing, some neon temple of cheat codes and fanfiction splayed at the feet of Pokémon Blue. Two decades have passed, but I'm every bit as goofy as I was back then. The latest incarnation of mattmadeiro.com was built to reflect that, and to capture at least some of the excitement I felt back when the Internet—and its early Wild West interpretation of personal expression—was new."
		  },
		  {
		    "date": "2015-09-07",
		    "title": "The Northern Cascades",
		    "imgurl": "cascades",
		    "imgalt": "A winding path along the crest of the northern Cascade mountain range.",
		    "imgsize": 68,
		    "desc": "Take note: when a park ranger describes as 'grueling,' she's likely not joking around. Twelve miles round-trip yesterday were some of the most difficult of my life, but a fifteen-minute stretch of sunlight in the northern Cascades made the sharp ascent all the more worthwhile."
		  },
		  {
		    "date": "2015-09-01",
		    "title": "Olympic National Park",
		    "imgurl": "olympic",
		    "imgalt": "A photo of a lake inside Olympic National Park.",
		    "imgsize": 80,
		    "desc": "My first proper backcountry hike. I wish I could say that we brought water-proof gloves. I wish I could say that my brother brought a sleeping bag rated for freezing temps. I wish I could say that we didn't completely miss the side snake of a trail to our first camp site and spend a solid two hours wandering through a frozen, biting rain. I wish I could say that we were in any way remotely prepared for a several-day hike along the upper loop trail through Olympic National Park, but here's the truth: it hurt, it sucked, and I would so, so do it again."
		  },
		  {
		    "date": "2015-01-21",
		    "title": "Hello, Meshify!",
		    "imgurl": "false",
		    "imgalt": "",
		    "imgsize": "",
		    "desc": "I submitted the application in my boxers, not thinking I'd receive a phone call from one of the cofounders less than an hour later. He asked if I could come in for an interview. I mentioned I needed to put on pants, but agreed to come in. The rest, as they say, is history.<br/><br/>I'm not a conventional coder. My background is in Professional Writing, and I taught myself HTML, CSS, and Javascript for a simple reason: I'd grown tired of paying other people to build websites. Despite this, I have a natural affection for the fluid web, and my time at Meshify—nearly two years, at this time of writing—have only deepened my love for what is capable inside a browser. In my time here, I've spear-headed the design and development of a brand-new dashboard for the Meshify core product, and I've been tasked time and time again with adding new core features while still maintaining a simple and readable interface. I've learned a tremendous amount, and I'm grateful still that Meshify took a chance in giving me the reins of the front-facing portion of their offerings."
		  },
		  {
		    "date": "2016-09-08",
		    "title": "Colorado Calling",
		    "imgurl": "rmnp",
		    "imgalt": "Miller Lake, situated outside of Estes Park and just past the entrance to the RMNP.",
		    "imgsize": 80,
		    "desc": "Colorado! We stole a few days in Boulder, then a few more in Denver, but the memories linger far outside the city. My favorite moment from the trip might be the simplest: rising around 5am, moving through the darkness out past Estes Park and into the Rocky Mountains proper, then beginning a long, cold hike up to Mills Lake. We passed a half-dozen other hikers in those early hours, and our reward was an unobstructed view of one of the most gorgeous bodies of water I've ever seen. Let the record show that I love mountains more than almost anything."
		  },
		  {
		    "date": "2016-12-28",
		    "title": "Adios, Houston",
		    "imgurl": "false",
		    "imgalt": "",
		    "imgsize": "",
		    "desc": "It's been grand. My next chapter begins just a stone's throw down the interstate, in Austin, TX. I hear it has live music. I also hear it has good food. Most importantly, it has my job, a handful of old friends, and an opportunity to start anew."
		  }
		];

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

		tag.prepareMemories = function(){
			var ordered = _.orderBy(memories, 'date', 'asc');
			tag.memoriesByYear = _.groupBy(ordered, function(m){
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
		}

		tag.prepareMemories();

	</script>

</Memories>