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
		tag.messages = ["Hello, world. Type help for more information."];;
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
			tag.commands.push(cmd);
			tag.checkCommand(cmd);
		}

		tag.clearMessages = function(){
			tag.messages = [];
			tag.update();
		}

		tag.checkCommand = function(cmd) {
			// Cheater.
			var result = "";
			switch (cmd) {
				case 'matt madeiro':
					result = "That's me!";
					break;
				case 'xenia kulick':
					result = "<3, princess.";
					break;
				case 'tyler owens':
					result = "You silly bitch.";
					break;
				case 'elyse owens':
					result = "SWEET TEA, MOTHER@#$#@!";
					break;
				case 'chelsea vincent':
					result = "WE DON'T HAVE THE SPARE KEYS!";
					break;
				case 'will decker':
					result = "Stupidly tall.";
					break;
				case 'jason cook':
					result = "Stupid sexy Flanders.";
					break;
				case 'adam madeiro':
					result = "Ah, yes. Mi hermano de Mexico.";
					break;
				case 'cheryle madeiro':
					result = "The best woman I know.";
					break;
				case 'john madeiro':
					result = "A goddamn rockstar and a great father.";
					break;
				case 'maggie doyne':
					result = "The most caring person I know, and a genuine inspiration.";
					break;
				case 'david crandall':
					result = "YOU'RE A UNICORN, HARRY";
					break;
				case 'help':
					result = "Type things! All sorts of things. Some things will say funny things, and others will do funny things. Here's something decidedly unfunny, but still useful: type and enter 'clear' (sans quotes) to wipe this display clean.";
					break;
				case 'ls':
					result = "Writing.exe Tools.exe Terminal.exe GuestBook.exe Library.exe Contact.exe Favorites.exe MysteriousFolder";
					break;
				case 'pwd':
					result = '/MadeirOS/users/guest/home';
					break;
				case 'cd mysteriousfolder':
					result = "Nothing in here...yet.";
					break;
				// Functions
				case 'clear':
					tag.clearMessages();
					result = '';
					break;
				default:
					result = "$ " + cmd + ": command not found";
					break;
			}
			tag.messages.push(result);
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
			tag.messages.push("Oh, you.");
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

	</script>

</Terminal>