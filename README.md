# Love2d hot reloading server & client.

Hot. Love. Yes, I went there. I'm not even sorry.

This is pretty hacky at the moment. Expect it to break a little and need some lovin'.

## To use

1. Install nodejs. `brew install node` on macos.
2. Git clone. Go into directory. `npm install`
3. Make a `payload` subdirectory. Put your game in there.
4. If you're deploying to a device, edit `client/net.lua`. Put your computer's IP address into `baseURL`.

Once thats all done, run `node server.js` to launch the local server. Deploy
the client/ directory to your device (or run it with lua locally). The device
will download and run game when love starts.

To reload the game, press Shift+R or do a 5 finger salute on a device.


## License

```
ISC License
Copyright (c) 2016 Joseph Gentle
Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted, provided that the above copyright notice and this permission notice appear in all copies.
THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```
