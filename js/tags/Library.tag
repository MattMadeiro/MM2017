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