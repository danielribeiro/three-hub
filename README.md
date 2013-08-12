# Three Hub

Three Hub is a Chrome Extension that shows the 3D models from the model files when browsing GitHub.

This extends the native support GitHub launched for stl format a few months ago: https://github.com/blog/1465-stl-file-viewing

Currently only obj formats are supported, however this is by far the most popular 3D format on github, with over [195 thousand files listed](https://github.com/search?q=extension%3Aobj&type=Code&ref=searchresults) against [22 thousand](https://github.com/search?q=extension%3Astl&type=Code&s=indexed) stl files.

![](https://raw.github.com/danielribeiro/three-hub/master/docs/spider.png)

[COLLADA](http://collada.org/), [glTF](https://github.com/KhronosGroup/glTF) and other formats support will be added in the future.

# Building

Run compile.sh to build the [CoffeeScript](http://coffeescript.org/) assets.

To see a demo working locally, you can serve the project folder with (for example):

    $ python -m SimpleHTTPServer

And then open http://localhost:8000/test in your local browser. You should see the following:

![](https://raw.github.com/danielribeiro/three-hub/master/docs/test.png)


# Acknowledgements

Thanks [Mr.doob](https://github.com/mrdoob) for the amazing work done in [three.js](https://github.com/mrdoob/three.js), which is the cornerstone of this project.

Thanks to [Lee Stemkoski](https://github.com/stemkoski) for some [great demos](http://stemkoski.github.io/Three.js/) on lightning and shading.

## Meta

Created by [Daniel Ribeiro](http://metaphysicaldeveloper.wordpress.com/about-me).

Released under the MIT License: http://www.opensource.org/licenses/mit-license.php

http://github.com/danielribeiro/three-hub

