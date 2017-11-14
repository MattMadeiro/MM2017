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