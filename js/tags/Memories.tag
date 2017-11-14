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