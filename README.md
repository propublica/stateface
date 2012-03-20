# StateFace <span id="us">z</span>

A font you can use in your web apps when you want tiny state shapes as a design element.

It's designed to be used at small sizes, and the shapes have been highly simplified to make for a really small font. All 50 states plus D.C. and a wee continental U.S. map fit in about 22k, and they look great on Retina displays.

At ProPublica we're using it in our [super PAC tracker](http://projects.propublica.org/pactrack).

Download: [ZIP](http://propublica.github.com/stateface/pkg/stateface.zip) [tar.gz](http://propublica.github.com/stateface/pkg/stateface.tar.gz) [Source Repo](http://github.com/propublica/stateface)

## How to Use

The easiest way to us StateFace on the web is to use FontSquirrel's technique to serve StateFace in a reliably cross-platform way:

1. In the `font/webfont` directory, find the following files and upload them to your webserver.

        stateface-regular-webfont.eot
        stateface-regular-webfont.woff
        stateface-regular-webfont.ttf
        stateface-regular-webfont.svg

    Note: Firefox gets a bit testy about cross-domain-origin assets so it's really best to serve them from your actual webserver.

2. Include this chunk of CSS in a stylesheet that's called from your web page. Use the correct paths, of course.

        @font-face {
            font-family: 'StateFaceRegular';
            src: url('stateface-regular-webfont.eot');
            src: url('stateface-regular-webfont.eot?#iefix') format('embedded-opentype'),
                 url('stateface-regular-webfont.woff') format('woff'),
                 url('stateface-regular-webfont.ttf') format('truetype'),
                 url('stateface-regular-webfont.svg#StateFaceRegular') format('svg');
            font-weight: normal;
            font-style: normal;
        }

3. Now, any text that has or inherits the font-family 'StateFaceRegular' style will appear as a state shape. See the character reference below to know which letter will draw which state, or [download the handy json file](http://propublica.github.com/stateface/reference/stateface.json) for programmatic access.

If you just want the OpenType font to use in a print layout you can [download it here](http://propublica.github.com/stateface/font/StateFace-Regular.otf).

## StateFace Keyboard Map

<%= table %>

## Projection Info

Each state is projected using a relevant state plane projection, and the U.S. (lowercase z) is projected using [Texas Centric Albers Equal Area](http://spatialreference.org/ref/epsg/3083/). The source [shapefiles](https://github.com/propublica/stateface/tree/master/tools/us-states) are adapted from [Natural Earth data](http://www.naturalearthdata.com/).

## Forking and Contributing

The [Glyphs Mini](http://itunes.apple.com/us/app/glyphs-mini/id469036911?mt=12) `.glyphs` file is [included in the repo](http://propublica.github.com/stateface/font/stateface.glyphs) if any type (especially hinting) experts want to try their hand at tuning it.

FontSquirrel's [FontFace Generator](http://www.fontsquirrel.com/fontface/generator) generated the files in `font/webfont`.

If you want to re-make the `.eps` files the `tools` directory includes a program to do so. You'll need to have [GDAL](http://www.gdal.org/) installed.
Running `make state-plane` or `make albers` will make a fresh copy.

## License

    Copyright (c) 2012, ProPublica

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is furnished
    to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
    IN THE SOFTWARE.

_StateFace is a project of ProPublica._
