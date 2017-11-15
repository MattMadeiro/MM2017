# MM2017
![The pseudo-desktop design of MattMadeiro.com.](/mm2017.jpg?raw=true)

I cut my teeth on Geocities. Early websites were weird, loud, and dense, shocks of color so dang *sincere* that I still feel charmed long after they ceased to exist. My own page meddled in the world of Pokémon cheat codes. (That probably says all you need to know about me.) The 2016-2017 edition of [mattmadeiro.com](http://mattmadeiro.com) is a throwback to those days of wonder, when the World Wide Web felt very personal, very intimate, and still small enough to understand.

## Goals

- Finally see what this React thing was all about
- Experiment with modular CSS, as espoused by Tachyons
- Create a rich and fully responsive website that loads in less than a second for most connections

Design-wise, I wanted to capture the strongest and most nostalgic visual language I know: early operating systems. My first computer was a Windows 95 machine that creaked enormously as it booted up. The design of MM2017 features strong borders, simple icons, and a familiar header bar for each of the 'apps' that you can interact with, all overlaid with more modern flourishes. The entire site functions like the operating systems you know: clicking an icon will open up a new program in a small window on the 'desktop', which can then be dragged freely around the screen. Novelty is a remarkable thing.

## Challenges

I built the first version of the site between August and September of 2017, with final release in early October. It's not inaccurate to say my brain broke a few times along the way. Having fiddled with React and then Riot.js for the site's framework, I set myself the task of designing the entire experience to be responsive. This is a breeze (I know now) with frameworks like Tachyons, but the bigger obstacle was mental. I wanted the site's individual 'apps' to be sprawling, intricate things, with a wide variety of interfaces, but I realized early on that my own ambition wouldn't produce a site that still worked perfectly on the narrow viewport of a mobile phone.

When I realized this, my focus shifted. Instead of stuffing each app like a junk drawer, I stripped each one down to the core of its purpose. I still needed a few design revisions to land there, but each app now conveys its own message in a simple, fluid way, and I'm positive they're better for it. Old operating systems were notoriously tricky to navigate, but I'm pleased to say that madeirOS is the opposite.

## Technologies Used

- [Riot.js](http://riotjs.com)
- [Tachyons](http://tachyons.io)
- [Lodash](http://lodash.com)
- [Random Color](https://github.com/davidmerfield/randomColor/)