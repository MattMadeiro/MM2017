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