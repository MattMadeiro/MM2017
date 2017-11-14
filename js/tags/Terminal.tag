<Terminal>
	<div class='terminal' onclick={ clickFocus }>
		<ul class='list pl0 ma0 b--none overflow-y-auto mw-100 fw2' style="max-height: 230px" ref="output">
			<li each={ msg, i in messages } class='mb2'>
				<p class="ma0 mb2 mw-80 f6 lh-copy">{msg}</p>
			</li>

		</ul>
		<form id="input" ref="input" class='pl3 pb3 w-100' onsubmit={ submitMSG } autocomplete="off">
			$&nbsp;<input type="text" ref="cmd" class='terminal white w-90 input-reset bg-transparent b--none' onkeydown={ handleKey } autofocus>
		</form>
	</div>

	<style scoped>
		.terminal {
			font: 16px/23px Monaco, Courier, font-monospace;
		}
		.blink {
			animation: blink-empty 1s infinite;
  			border-right: transparent solid 0.5em;
		}
		@keyframes blink-empty {
		  50% {border-right: 0.5em solid #333;}
		}
		input:focus {
			outline: none;
		}
		#input {
			position: absolute;
			bottom: 0;
			left: 0;
		}

	</style>

	<script>

		var tag = this;
		tag.messages = [];
		tag.commands = [];
		tag.currentKeys = [];
		tag.konamiKeys = [38,38,40,40,37,39,37,39,66,65];
		tag.currentCommand = 0;

		tag.clickFocus = function(){
			tag.refs.cmd.focus();
		}

		tag.submitMSG = function(e) {
			var val = tag.refs.cmd.value;
			if(val.length > 1) {
				tag.commands.push(val);
				tag.currentCommand = tag.commands.length;
				tag.sendCommand(val.toLowerCase());
				tag.refs.cmd.value = "";
				tag.update();
				tag.setScroll();
			}
			e.preventDefault();
		}

		tag.setScroll = function(){
			tag.refs.output.scrollTop = tag.refs.output.scrollHeight;
		}

		tag.sendCommand = function(cmd) {
			tag.currentKeys = [];
			RiotControl.trigger('terminal_input', cmd);
		}

		tag.clearMessages = function(){
			RiotControl.trigger('terminal_clear');
		}

		tag.checkKonami = function(e) {
			tag.currentKeys.push(e.keyCode);
			if(tag.currentKeys.length === 10) {
				if(_.isEqual(tag.currentKeys, tag.konamiKeys)) {
					tag.konami();
					tag.currentKeys = [];
				}
				else {
					tag.currentKeys = [];
				}
			}
		}

		tag.konami = function(){
			RiotControl.trigger('terminal_msg', "Oh, you.");
			tag.refs.cmd.value = "";
		}

		tag.handleKey = function(e) {
			// console.log(e.keyCode);
			tag.checkKonami(e);
			if(e.keyCode === 38) {
				tag.currentCommand -= 1;
				if(tag.currentCommand < 0) {
					tag.currentCommand = 0;
				}
				tag.refs.cmd.value = typeof tag.commands[tag.currentCommand] != 'undefined' ? tag.commands[tag.currentCommand] : "";
			}
			else if(e.keyCode === 40) {
				tag.currentCommand += 1;
				if(tag.currentCommand >= tag.commands.length) {
					tag.currentCommand = tag.commands.length - 1;
					tag.refs.cmd.value = "";
					return true;
				}
				tag.refs.cmd.value = typeof tag.commands[tag.currentCommand] != 'undefined' ? tag.commands[tag.currentCommand] : "";
			}
		}

		RiotControl.on('terminal_command', function(f){
			tag[f]();
			if(tag.isMounted) {
				tag.update();
			}
		});

		RiotControl.on('terminal_list', function(messages){
			tag.messages = messages;
			if(tag.isMounted) {
				tag.update();
			}
		});

		tag.on('mount', function(){
			tag.refs.cmd.focus();
			RiotControl.trigger('terminal_init');
			tag.update();
		});

	</script>

</Terminal>