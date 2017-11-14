<GuestBook>

	<div class='guestbook' onclick={ clickFocus }>

		<div class='bg-white overflow-y-auto' style="max-height: {parent.style.height}px" if={ showingList }>
			<div class='tc pv3 bb b--black-80'>
				<NotButton title="Sign the Guest Book" onclick="{ toggleView }"></NotButton>
			</div>
			<ul class='list pl0 ma0' ref="messages" if={ messages.length }>

				<li each={ messages } class='bb cf pt3 pt0-ns pl4-ns' style='background-color: {color}'>
					<div class='pl3 pr3 w-100 fl bl-ns bg-white' style='min-height: 100px'>
						<p class=''><span class='b f5'>{ formatOutput(name) }</span><span class='light-silver fw4 ml3 f6'>{ formatOutput(location) }</span></p>
						<p class="near-black f6 pb2 pt1 lh-copy measure" style="white-space: pre-wrap">{ formatOutput(message) }</p>
					</div>
				</li>

			</ul>

			<p class='tc pl3 pa0 ma0 mt4 f5 gray' if={ !messages.length }>Nothing here just yet. :(</p>

		</div>

		<div if={ !showingList } class='cf' onclick={ chooseColor }>
			<div class='pl3 pv3'>
				<NotButton title="Back to List" onclick="{ toggleView }"></NotButton>
			</div>
			<form class='pt3'>

				<div class='pl3 pr3 pb2 w-100 mb3 '>
					<label for="author" class='db b mb1 f6 ttu'>Name</label>
					<input onclick={ dontChangeColor } class='input-reset pv2 ph2 w-100 ba bw1 b--black' type="text" ref="author">
				</div>

				<div class='pl3 pr3 pb2 w-100 mb3 '>
					<label for="location" class='db b mb1 f6 ttu'>Location</label>
					<input onclick={ dontChangeColor } class='input-reset pv2 ph2 w-100 ba bw1 b--black' type="text" ref="location">
				</div>

				<div class='pl3 pr3 pb0 pb2-l w-100 mb3 '>
					<label for="message" class='db b mb1 f6 ttu'>Message</label>
					<textarea onclick={ dontChangeColor } class='input-reset pv2 ph2 w-100 ba bw1 b--black' ref="message" style='min-height: 120px'></textarea>
				</div>

				<div class='pr3 pv3 fr'>
					<NotButton title="Submit" onclick='{ submitForm }'></NotButton>
				</div>

			</form>
		</div>
	</div>

	<script>

		var tag = this;
		var parent = tag.parent;
		tag.messages = [];
		tag.authorColor = randomColor({luminosity: 'light'});
		tag.showingList = true;

		tag.toggleView = function(e){
			if(typeof e != 'undefined') {
				e.stopPropagation();
			}
			tag.showingList = !tag.showingList;
			if(tag.showingList) {
				parent.refs.container.style.backgroundColor = "#ffffff";
				tag.update();
			}
			else {
				tag.chooseColor();
			}

		}

		tag.formValid = function(){
			return tag.refs.author.value.length > 1 && tag.refs.location.value.length > 1 && tag.refs.message.value.length > 2;
		}

		tag.submitForm = function(e) {
			e.stopPropagation();
			e.preventDefault();
			if(tag.formValid()) {
				var payload = {
					name: tag.escapeInput(tag.refs.author.value),
					location: tag.escapeInput(tag.refs.location.value),
					msg: tag.escapeInput(tag.refs.message.value),
					color: tag.authorColor
				}
				RiotControl.trigger('guestbook_add', payload);
				tag.refs.author.value = '';
				tag.refs.location.value = '';
				tag.refs.message.value = '';
				tag.toggleView();
			}
		}

		tag.escapeInput = function(str) {
			var replaced = str.replace(/(?:\r\n|\r|\n)/g, '<br />');
			return replaced.replace(/,/g, '~');
		}

		tag.formatOutput = function(str) {
			var replaced = str.replace(/~/g, ',');
			return replaced.split("<br />").join("\n\r");
		}

		tag.setScroll = function(){
			tag.output.scrollTop = tag.output.scrollHeight;
		}

		tag.chooseColor = function(){
			tag.authorColor = randomColor({luminosity: 'light'});
			parent.refs.container.style.backgroundColor = tag.authorColor;
			tag.update();
		}

		tag.dontChangeColor = function(e){
			e.stopPropagation();
		}

		RiotControl.on('guestbook_list', function(entries){
			tag.messages = entries;
			if(tag.isMounted) {
				tag.update();
			}
		});

		tag.on('mount', function(){
			RiotControl.trigger('guestbook_init');
		});

	</script>

</GuestBook>