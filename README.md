# StateFace

A font you can use in your web apps when you want tiny state shapes as a design element. 

## How to Use




If you just want the OpenType font you can [download it here](tk).



## Projection Info

Each state is projected using State Plane, and the U.S. (lowercase z) is projected using [Texas Centric Albers Equal Area](http://spatialreference.org/ref/epsg/3083/). The outlines are from [Natural Earth data](http://www.naturalearthdata.com/). See Natural Earth data's [terms of use](http://www.naturalearthdata.com/about/terms-of-use/) for details.

## How We Did It

We projected `.eps` files for each state and for the U.S. using TK. The script that generates the files is in the tools directory. Run `make blah` will re-make the EPS files if you need to do that for some reason.

We used [Glyphs Mini](http://itunes.apple.com/us/app/glyphs-mini/id469036911?mt=12) to assemble the font and FontSquirrel's [FontFace Generator](http://www.fontsquirrel.com/fontface/generator) to auto-hint and generate EOT and WOFF files.

The raw `.glyphs` file is included in the repo if any hinting experts want to try their hand at tuning it.
