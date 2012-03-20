# StateFace

A font you can use in your web apps when you want tiny state shapes as a design element. 

## How to Use

We use FontSquirrel's technique to serve StateFace in a reliably cross-platform way. Here's how:

1. In the `font/webfont` directory in the repo, find the following files and upload them to your webserver:

* stateface-regular-webfont.eot
* stateface-regular-webfont.woff
* stateface-regular-webfont.ttf
* stateface-regular-webfont.svg

Note: Firefox gets a bit testy about cross-origin assets so it's really best to serve them from your actual webserver.

2. Include this chunk of CSS in a stylesheet that's called from your web page.

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
    
3. Now, any text that has or inherits the font-family 'StateFaceRegular' style will appear as a state shape. See the character reference below to know which letter will draw which state, or download the handy json file for programmatic access.

If you just want the OpenType font you can [download it here](tk).



## Projection Info

Each state is projected using State Plane, and the U.S. (lowercase z) is projected using [Texas Centric Albers Equal Area](http://spatialreference.org/ref/epsg/3083/). The outlines are from [Natural Earth data](http://www.naturalearthdata.com/). See Natural Earth data's [terms of use](http://www.naturalearthdata.com/about/terms-of-use/) for details.

## How We Did It

We projected `.eps` files for each state and for the U.S. using TK. The script that generates the files is in the tools directory. Run `make blah` will re-make the EPS files if you need to do that for some reason.

We used [Glyphs Mini](http://itunes.apple.com/us/app/glyphs-mini/id469036911?mt=12) to assemble the font and FontSquirrel's [FontFace Generator](http://www.fontsquirrel.com/fontface/generator) to auto-hint and generate EOT and WOFF files.

The raw `.glyphs` file is included in the repo if any hinting experts want to try their hand at tuning it.
