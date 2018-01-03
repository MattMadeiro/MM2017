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

		var tag = this;
		tag.articles = [];
		tag.articleYears = [];
		tag.articlesByYear = {};
		tag.monthNames = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
		var articles = [
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

		tag.calculateHeight = function(){
			return 500;
		}

		tag.setScroll = function(){
			tag.output.scrollTop = tag.output.scrollHeight;
		}

		tag.formatDate = function(date) {
			return tag.monthNames[new Date(date).getMonth()];
		}

		tag.prepareArticles = function(){
			tag.articles = _.orderBy(articles, 'date', 'desc');
			tag.articlesByYear = _.groupBy(tag.articles, function(a){
				return a.date.split('-')[0];
			});
			tag.articleYears = _.sortBy(_.keys(tag.articlesByYear), function(year){
				return -1 * parseInt(year);
			});
		}

		tag.prepareArticles();

	</script>

</Writing>