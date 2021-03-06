# Three Hub

Three Hub is a Chrome Extension that shows the 3D models from model files when browsing GitHub. You can install it [directly from Chrome Store](http://bit.ly/three-hub).

This extends the native support GitHub launched for STL: https://github.com/blog/1465-stl-file-viewing

Currently only OBJ format is supported, which is one of most popular 3D formats on GitHub.

![](https://raw.github.com/danielribeiro/three-hub/master/docs/spider.png)

## Building

Run compile.sh to build the [CoffeeScript](http://coffeescript.org/) assets.

To see a demo working locally, you can serve the project folder with (for example):

    $ python -m SimpleHTTPServer

And then open [http://localhost:8000/test](http://localhost:8000/test) in your local browser. You should see the following:

[![](https://raw.github.com/danielribeiro/three-hub/master/docs/test.png)](http://danielribeiro.github.io/three-hub/)

The page you will see running be like this [this](http://danielribeiro.github.io/three-hub/)


## Acknowledgements

Thanks [Mr.doob](https://github.com/mrdoob) for the amazing work done in [three.js](https://github.com/mrdoob/three.js), which is the cornerstone of this project.

Thanks to [Lee Stemkoski](https://github.com/stemkoski) for the [great demos](http://stemkoski.github.io/Three.js/) on lightning and shading.

## Meta

Created by [Daniel Ribeiro](http://metaphysicaldeveloper.wordpress.com/about-me).

Released under the MIT License: http://www.opensource.org/licenses/mit-license.php

http://github.com/danielribeiro/three-hub

