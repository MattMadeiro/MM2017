TOUCH_ENABLED = false;
var store = new MadeiroStore();
RiotControl.addStore(store);

if('ontouchstart' in window) {
    TOUCH_ENABLED = true;
}

riot.mount('MadeirOS', {
    apps:
        {
            "Terminal": {
                name: "Terminal",
                tagName: "terminal",
                draggable: true,
                style: {
                    height: 300,
                    width: 40,
                    additionalClasses: 'bg-dijon white overflow-hidden pa3',
                    left: 40,
                    top: 40,
                    color: '#E986B8',
                }
            },
            "Guest Book": {
                name: "Guest Book",
                tagName: "guestbook",
                draggable: true,
                style: {
                    height: 450,
                    width: "third",
                    additionalClasses: "bg-white black",
                    left: 50,
                    top: 50,
                    color: '#85B7E8'
                }
            },
            "Library": {
                name: "Library",
                tagName: "library",
                draggable: true,
                style: {
                    height: 500,
                    width: 40,
                    additionalClasses: 'bg-white',
                    left: 60,
                    top: 60,
                    color: '#B6E684'
                }
            },
            "Contact": {
                name: "Contact",
                tagName: "contact",
                draggable: true,
                style: {
                    height: 500,
                    width: 50,
                    additionalClasses: 'bg-white',
                    left: 70,
                    top: 70,
                    color: '#FFF'
                }
            },
            "Favorites": {
                name: "Favorites",
                tagName: "favorites",
                draggable: true,
                style: {
                    height: 500,
                    width: 25,
                    additionalClasses: 'bg-white',
                    left: 80,
                    top: 80,
                    color: '#EC4A57'
                }
            },
            "Writing": {
                name: "Writing",
                tagName: "writing",
                draggable: true,
                style: {
                    height: 500,
                    width: 40,
                    additionalClasses: 'bg-white',
                    left: 90,
                    top: 90,
                    color: '#EC4A57'
                }
            },
            "Tools": {
                name: "Tools",
                tagName: "tools",
                draggable: true,
                style: {
                    height: 400,
                    width: 40,
                    additionalClasses: 'bg-white',
                    left: 100,
                    top: 100,
                    color: '#EC4A57'
                }
            },
            "Help": {
                name: "Help",
                tagName: "help",
                draggable: true,
                icon: false,
                style: {
                    height: 275,
                    width: "third",
                    additionalClasses: 'bg-white',
                    left: 30,
                    top: 30,
                    color: '#EC4A57'
                }
            },
            "Memories": {
                name: "Memories",
                tagName: "memories",
                draggable: true,
                style: {
                    height: 600,
                    width: 'third',
                    additionalClasses: 'bg-white',
                    left: 110,
                    top: 110,
                    color: '#EC4A57'
                }
            },
            "Documents": {
                name: "Document Viewer",
                tagName: "documents",
                icon: false,
                draggable: false,
                style: {
                    width: '40',
                    right: 0,
                    top: 0,
                    additionalClasses: 'bg-white',
                }
            }
        }
});