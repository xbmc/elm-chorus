# elm-chorus

![demo](https://github.com/ionif/elm-chorus/blob/master/demo.gif)

a web interface for Kodi written in Elm for GSoC 2020\
based on chorus2 by jez500

# Code layout

Inside the `src` directory you'll find:

> `src`
>
> > `Colors.elm` - palette for user interface \
> > `Components` - all ui elements
> >
> > > - DialogBox
> > > - Frame
> > > - Header
> > > - LeftSidebar
> > > - RightSidebar
> > > - PlayerRow
> > > - VerticalNav
> > > - Video

> > `Helper.elm` \
> > `Main.elm` \
> > `Method.elm` \
> > `Pages` - holds all elm-spa pages \
> > `Request.elm` - partial wrapper, unused for now because it's incomplete \
> > `Shared.elm` - Shared model, this is where all the action handling happens \
> > `Spa` - holds all elm-spa generated stuff \
> > `WSDecoder.elm` - all decoders and custom types

# Developing elm chorus

To develop elm-chorus, you must have the following:

### For MacOS, Windows, Linux

- Kodi application
- Chrome/Chromium, Firefox
- Elm
- NPM

To run it:

1. start Kodi
2. `git clone https://github.com/xbmc/elm-chorus.git`
3. `cd elm-chorus/`
4. `npm start`

and point your browser to http://localhost:1234 by default or whatever port Node tells you
