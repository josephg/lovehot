# Love2d hot reloading server & client.

Hot. Love. Yes, I went there. I'm not even sorry.

This is a hot reloader for love2d projects, so you don't have to re-deploy your love game to your device during development.

Its made up of

- A simple nodejs web server hosting the game content itself (server.js)
- A launcher (client/) which downloads the game content from the web server when the app starts up.

It'll also download a fresh copy & restart your game when you press shift+R or touch your mobile screen with 5 fingers.

This is pretty hacky at the moment. Expect it to break a little and need some lovin'. I wrote this whole thing in 1 night, and its <200 lines of code.


## To use

1. Install nodejs. `brew install node` on macos.
2. Git clone. Go into directory. `npm install`
3. Make a `payload` subdirectory. Put your game in there.
4. If you're deploying to a device, edit `client/net.lua`. Put your computer's IP address into `baseURL`.

Once thats all done, run `node server.js` to launch the local server. Deploy
the client/ directory to your device (or run it with lua locally). The device
will download and run game when love starts.

To reload the game, press Shift+R or do a 5 finger salute on a device.


# Caveats

This was done in a single evening.

It doesn't reload automatically when the source files change
When you reload the game it re-downloads all your assets. That could all be fixed pretty easily by looking at timestamps.
It doesn't recover automatically when you lua throws errors
It won't terminate secondary threads. (Easily fixable by adding an optional love.unload() function that could get called when reloading the game)
It doesn't support custom love.run function
If it can't contact the server the client should just run the last good copy of your game. (Its sitting *right there* in the save directory). That'd be great for demos and stuff. Right now it just hangs.

You also need to reference your assets from `_bundle/images/sprite.png` instead of just `images/sprite.png`. I don't think there's a way to add file search paths to love from lua, and I'm hesitant to dump the whole game raw in the save directory. I guess I could hotpatch all the love functions which load files to look in `_bundle/`, but that seems error prone.


[Love2d forum thread about the launcher here](https://love2d.org/forums/viewtopic.php?f=5&t=82973&sid=5b267dd77881f7a947f610ee745bb3ec)


## License

```
ISC License
Copyright (c) 2016 Joseph Gentle
Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.
THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
```
