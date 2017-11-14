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