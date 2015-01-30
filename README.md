README
===========

### Getting Startd

1. `npm install -g gulp`
2. `npm install`
3. `bower install`
4. `gulp` (or [this one cool trick](#errors))

Open your browser to http://0.0.0.0:8000

### Icons

We are using [Grunticon](https://github.com/filamentgroup/grunticon) to generate SVG stylesheets and appropriate fallbacks for all icons. To install grunt on your system simply re-run `npm install`.

Grunticon accepts source `.svg` files in the `src/grunticon/source` directory. Add new icon files to that directory and re-run `gulp` to generate new stylesheets with the new icons.

Grunticon can also generate different color versions of the same icon. To create a color variation:

- define a color in the `Gruntfile.coffee` like so:

```coffeescript
options:
  colors:
    orange: "#ff7c00"
```
- rename the icon file you want to change to include the color variation, e.g. `thing.colors-orange.svg`.

### Errors

By default, plugin errors (such as errors with Sass compilation) will cause
Gulp to halt. Errors and warnings are fatal. If you want to keep Gulp running,
use the `--fatal=off` flag. This is useful if you are watching files and you
don't want to have to manually start gulp again.

```
gulp              # Errors will stop the build
gulp --fatal=off  # Errors will not stop the build
```

If you run into an error that includes:

`Error: watch EMFILE`

run the following command in your terminal:

`ulimit -S -n 2048`

This allows your OS to allow Gulp to watch up to 2048 files instead of whatever
limitation the OS currently has. The error is documented in
[Gulp's bugs.](https://github.com/sindresorhus/gulp-imagemin/issues/10)

```
 ____________________________
/          Protip:           \
| alias g='gulp --fatal=off' |
| for udderly effortless     |
\ development.               /
 ----------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```
