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
		tag.tools = [
		  {
		    "title": "CSV.me",
		    "desc": "A small (and simple!) in-browser CSV editor.",
		    "tech": "Riot.js, Tachyons",
		    "link": "http://mattmadeiro.com/csvme"
		  }
		];

	</script>

</Tools>