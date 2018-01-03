<MadeirOS>

    <nav class='bg-white bb bw1' ref="nav">
        <ul class='list pl0 pv2 ma0'>
            <li class='dib ml3 ml4-l i f4-ns f5'>madeirOS</li>
            <li class='dib ml4 f6 f5-ns'>File</li>
            <li class='dib ml4 f6 f5-ns'>Edit</li>
            <li class='dib ml4 f6 f5-ns'><a class='link blue' href="#help">Help</a></li>
        </ul>
    </nav>

    <div class='cf absolute w-100 mt3' style="z-index: 1; top: 50px">
        <Icons items={icons}></Icons>
    </div>

    <div role="main" class='cf absolute w-100' style="z-index: 5;">
        <App each={ openApps }></App>
    </div>

    <script>

        var tag = this;
        tag.localZ = 10;
        tag.currentTheme = 1;
        tag.onPhone = false;

        tag.apps = _.valuesIn(opts.apps);
        tag.icons = _.valuesIn(opts.apps);
        _.remove(tag.icons, function(app){
            return _.has(app, 'icon') && !app.icon;
        });
        tag.openApps = [];

        tag.closeApp = function(item) {

            var index = _.indexOf(tag.openApps, item);

            if(index != -1) {
                tag.openApps.splice(index, 1);
                tag.update();
            }

            riot.route('/');

        }
        tag.startApp = function(name) {
            var app = _.find(tag.apps, function(app){
                return app.tagName.toLowerCase() === name;
            });
            if(typeof app != 'undefined') {
                if(_.indexOf(tag.openApps, app) === -1) {
                    app.style.z = tag.getNextZ();
                    if(tag.onPhone) {
                        tag.openApps = [];
                    }
                    tag.openApps.push(app);
                    tag.update();
                }
            }
        }

        tag.getNextZ = function(){
            tag.localZ += 1;
            return tag.localZ;
        }

        tag.calculateWindowDimensions = function(){
            var wWidth = 0, wHeight = 0;
            if( typeof( window.innerWidth ) == 'number' ) {
                //Non-IE
                wWidth = window.innerWidth;
                wHeight = window.innerHeight;
            }
            else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
                //IE 6+ in 'standards compliant mode'
                wWidth = document.documentElement.clientWidth;
                wHeight = document.documentElement.clientHeight;
            }
            else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
                //IE 4 compatible
                wWidth = document.body.clientWidth;
                wHeight = document.body.clientHeight;
            }
            return {
                width: wWidth,
                height: wHeight
            }
        }

        tag.checkForPhone = function(){
            tag.mq = window.matchMedia('screen and (min-width: 60em)');
            if(tag.mq.matches) {
                tag.onPhone = false;
            }
            else {
                tag.onPhone = true;
            }
        }

        tag.fetchArticle = function(slug) {
            tag.startApp('documents');
            RiotControl.trigger('load_article', slug);

        }

        tag.setupRoutes = function(){
            riot.route(function(name) {
                tag.startApp(name);
            });
            riot.route('writing/*', function(name){
                tag.startApp('writing');
                tag.fetchArticle(name);
            });
            if(window.location.hash === ''){
                tag.startApp('help');
            }
        }

        tag.on('mount', function(){
            tag.checkForPhone();
            tag.setupRoutes();
            riot.route.start(true);
        });

    </script>

</MadeirOS>


<Icons>

    <ul role="navigation" class='list pl0 ma0 w-100 w-10-l relative-l fr cf' style='min-width: 150px' each={ apps, i in lists }>
        <li class='mb4 fl w-33 tc w-100-l relative-l' each={ apps }>
            <a href="#{ tagName.toLowerCase() }" class='no-underline pointer dib'>
                <div class='center mb2' style="width: 75px;">
                    <img aria-hidden="true" name='img' class='mw-100' src="icons/{ tagName }.png" />
                </div>
                <p class='black-80 ma0 fw5 f6 pt1'>{ name }</p>
            </a>
        </li>
    </ul>

    <script>

        var parent = this.parent;
        var tag = this;
        tag.lists = [];
        tag.fullList = [];
        tag.segmented = [];

        tag.prepareLists = function(){
            tag.fullList.push(opts.items);
            tag.segmented.push(_.slice(opts.items, 0, 5));
            tag.segmented.push(_.slice(opts.items, 5, opts.items.length));

            var self = this;
            if(!parent.onPhone) {
                tag.lists = tag.segmented;
            }
            else {
                tag.lists = tag.fullList;
            }
            parent.mq.addListener(function(changed) {
                if(changed.matches) {
                    console.log('use segmented list');
                    self.lists = self.segmented;
                    parent.onPhone = false;
                } else {
                    console.log('use full list');
                    self.lists = self.fullList;
                    parent.onPhone = true;
                }
                self.update();
            });
        }

        tag.on('mount', function(){
            tag.prepareLists();
            tag.update();
        });

    </script>

</Icons>

<App>

    <article ref="{ tagName.toLowerCase() }" class='{!parent.onPhone ? "mw-400" : ''} w-100 w-{style.width}-l bl-l br-l bb-l {draggable ? "bt-l" : ''} bw1-l b--black absolute-l' style='z-index: {style.z}; left: {style.left}px; top: {style.top}px; right: {style.right}px; opacity: 0.999999;' onclick={ clickFocus }>

        <div class='bg-light-gray bb bw1 b--black header' ref="header" id="{ name }">
            <div class='cf overflow-hidden'>
                <div class='fl pv2 w-80 w-90-ns {draggable ? "cursor-move" : ''}'>
                    <h2 class='ma0 ml3 normal fw4 f6 f5-ns ttu tracked'>{name}</h2>
                </div>
                <button class='db bg-light-gray fl w-20 w-10-ns tc pv2 bl bw1 br0 b--black bt-0 br-0 bb-0 hover-invert pointer' onclick={ clickClose } aria-label="Close {name} Window">
                    <svg class="center f4-ns f5 db icon icon-cross" aria-hidden="true">
                        <use xlink:href="#icon-cross"></use>
                    </svg>
                </button>
            </div>
        </div>

        <div class='{style.additionalClasses} overflow-auto' ref="container" style='min-height: {style.height}px; max-height: {style.maxHeight}px'>

            <div data-is="{ tagName }"></div>

        </div>
    </article>

    <style scoped>
        .mw-400 {
            min-width: 400px;
        }
    </style>

    <script>

        var parent = this.parent;
        var tag = this;
        // var tag =
        this.dragging = false;
        this.resized = false;

        this.clickFocus = function(e){
            var curTag = this.refs[this.tagName.toLowerCase()];
            this.style.z = this.parent.getNextZ();
            if(typeof curTag != 'undefined' && _.has(curTag, 'clickFocus')) {
                curTag.clickFocus();
            }
            if(this.tagName.toLowerCase() === 'documents') {
                e.preventUpdate = true;
            }
        }

        this.clickClose = function(e){
            e.stopPropagation();
            e.preventDefault();
            e.preventUpdate = true;
            parent.closeApp(e.item);
        }

        this.calculateAbsolutePosition = function(obj) {
            var curleft = curtop = 0;
            if (obj.offsetParent) {
                do {
                    curleft += obj.offsetLeft;
                    curtop += obj.offsetTop;
                } while (obj = obj.offsetParent);
            }
            return {
                left : curleft,
                top : curtop
            };
        }

        this.handleDrag = function(e) {
            var self = this;

            if(e.which != 1) {
                return;
            }

            this.dragging = true;
            this.style.z = parent.getNextZ();
            var abs = this.calculateAbsolutePosition(e.currentTarget);
            var wDimensions = parent.calculateWindowDimensions();
            var appHeight = this.refs[this.tagName.toLowerCase()].clientHeight;
            var appWidth = this.refs[this.tagName.toLowerCase()].clientWidth;
            document.body.className = 'dragging';
            if(typeof appHeight === 'undefined') {
                var a = this[this.tagName.toLowerCase()];
                appHeight = a[a.length - 1].clientHeight;
                appWidth = a[a.length - 1].clientWidth;
            }

            var offset = {
                left: e.pageX - abs.left,
                top: e.pageY - abs.top + 41
            };

            document.onmouseup = function(){
                self.dragging = false;
                document.body.className = '';
                document.onmousemove = null;
            }

            document.onmousemove = function(e) {

                var x, y, diffX, diffY;
                var prevX = self.style.left, prevY = self.style.top;

                if(!self.dragging) {
                    return;
                }

                if(_.has(e, 'originalEvent')) {
                    x = e.originalEvent.touches ?  e.originalEvent.touches[0].pageX : e.pageX;
                    y = e.originalEvent.touches ?  e.originalEvent.touches[0].pageY : e.pageY;
                } else {
                    x = e.pageX;
                    y = e.pageY;
                }

                x = x - offset.left;
                y = y - offset.top;

                diffX = Math.abs(x - prevX);
                diffY = Math.abs(y - prevY);

                if(diffX >= 200) {
                    return;
                }

                if(x <= 2) {
                    x = 2;
                }
                else if((x + appWidth + 6) >= wDimensions.width) {
                    x = wDimensions.width - appWidth - 6;
                }

                if(y <= 2) {
                    y = 2;
                }
                else if((y + appHeight + 5) >= wDimensions.height - 41) {
                    y = wDimensions.height - appHeight - 47;
                }

                self.style.left = x;
                self.style.top = y;
                self.update();

            }
        }

        this.setDraggable = function() {
            if(TOUCH_ENABLED) {
                this.refs.header.addEventListener('touchstart', this.handleDrag);
            }
            else {
                this.refs.header.addEventListener('mousedown', this.handleDrag);
            }
        }

        tag.setHeight = function(){
            if(parent.onPhone || !tag.draggable) {
                var dimensions = parent.calculateWindowDimensions();
                var navHeight = parent.refs.nav.clientHeight;
                var headerHeight = tag.refs.header.clientHeight;
                tag.style.height = dimensions.height - navHeight - headerHeight - 4;
                tag.style.maxHeight = dimensions.height - navHeight - headerHeight - 4;
                tag.update();
            }
        }

        this.on('mount', function(){
            _.bindAll(this, 'handleDrag');
            if(this.draggable) {
                this.setDraggable();
            }
            setTimeout(tag.setHeight, 5);
            // this.update();
        });

    </script>

</App>

<Help>

    <article class='help ph3 pb4'>

        <p class='near-black pt2 lh-copy'><span class='b'>Hi! Welcome to <strong class='unicorn animate i fw4'>madeirOS</strong> v1.0.</span> (I've worked hard on this, and I'm very eager to show you.)</p>

        <p class='near-black pt1 lh-copy'>My name is Matt Madeiro. I'm a web designer, developer, and <a class='link blue' href="#writing">sometimes-writer</a> based in Austin, Texas. This is all my stuff. I hope you like it! <span class='dn di-ns'>Click all the things, and don't be afraid to move these windows around, too.</span></p>

        <p class='near-black pt1 lh-copy dn-ns b'>To get started, click the big X button in the upper right.</p>

        <p class='near-black pt1 lh-copy'>(Psst. Don't forget to sign the <a class='link blue' href="#guestbook">Guest Book</a> before you leave!)</p>

    </article>

</Help>

<RawHTML>

    <script>
        this.root.innerHTML = this.opts.html;

        this.on('update', function(){
            this.root.innerHTML = this.opts.html;
        });
    </script>

</RawHTML>