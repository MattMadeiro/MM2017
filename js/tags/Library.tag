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

		var tag = this;
		tag.books = [
		  {
		    "name": "Bird by Bird",
		    "author": "Anne Lamott",
		    "amazon": "http://amzn.to/2dlfw83",
		    "filename": "birdbybird"
		  },
		  {
		    "name": "City of Saints and Madmen",
		    "author": "Jeff VanderMeer",
		    "amazon": "http://amzn.to/2dCzNbb",
		    "filename": "cityofsaints"
		  },
		  {
		    "name": "Letters of Note",
		    "author": "Shaun Usher",
		    "amazon": "http://amzn.to/2cLgRpL",
		    "filename": "lettersofnote"
		  },
		  {
		    "name": "Name of the Wind",
		    "author": "Patrick Rothfuss",
		    "amazon": "http://amzn.to/2dlfgWC",
		    "filename": "nameofthewind"
		  },
		  {
		    "name": "Show Your Work",
		    "author": "Austin Kleon",
		    "amazon": "http://amzn.to/2d7h6Hv",
		    "filename": "showyourwork"
		  },
		  {
		    "name": "Steal Like an Artist",
		    "author": "Austin Kleon",
		    "amazon": "http://amzn.to/2dlgyRf",
		    "filename": "steal"
		  },
		  {
		    "name": "Vagabonding",
		    "author": "Rolf Potts",
		    "amazon": "http://amzn.to/2dCzTQh",
		    "filename": "vagabonding"
		  },
		  {
		    "name": "The Shape of Design",
		    "author": "Frank Chimero",
		    "amazon": "http://shapeofdesignbook.com/",
		    "filename": "chimero"
		  }
		];

	</script>

</Library>