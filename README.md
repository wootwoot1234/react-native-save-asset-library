# react-native-save-asset-library  [![NPM version](https://img.shields.io/npm/v/react-native-save-asset-library.svg?style=flat-square)](https://www.npmjs.com/package/react-native-save-asset-library)

A React Native module for saving asset-library:// paths to the documents folder

## Getting started

1. `npm install react-native-save-asset-library --save`
2. In XCode, in the project navigator, right click `your project` ➜ `Add Files to [your project's name]`
3. Go to `node_modules` ➜ `react-native-save-asset-library` and add `SaveAssetLibrary.m`
4. Run your project (`Cmd+R`)

## Usage

```javascript
var SaveAssetLibrary = require('react-native-save-asset-library');

var obj = {
    imagePath: "asset-library://", // (required) Path to asset-library:// for example from CameraRoll
    imageName: "imageName", // (required) This is what you want the image to be named
    imageType: "jpg", // (optional) "png" or "jpg".  Default it jpg.  More image types could be supported send me a pull request
    width: 2048, // (optional) Size of the image to be saved. Default is 2048
    height: 2048, // (optional) Size of the image to be saved. Default is 2048
};
var successCallBack = ()=>{
    // image has been saved.
};
var errorCallback = (error)=>{
    console.log('error: ', error);
};
SaveAssetLibrary.SaveImage(obj, successCallack, errorCallback);
```

## Road Map, Feature Requests & Bug Fixes

I will add to this module as I need more features and I hope you will too, pull requests are always welcome.  I will not add features on request because I'm busy with other projects.  I want this to be a community written module so if there is a feature that's missing or bug, add it or fix it and send me a pull request.  If you don't know Objective C you can learn it.  We all were where you are now at some point.  [StackOverflow.com](http://stackoverflow.com/) is your friend.  :)

### Features that could be added:

* Support for other folders.  RIght now it only saves files to the `Documents` folder
* Support more image types
* Better image size support.  It would be nice if you would just get the largest possible image
* Support for PHImageContentModeAspectFill, it currently defaults to (PHImageContentModeAspectFit)[https://developer.apple.com/library/prerelease/ios/documentation/Photos/Reference/PHImageManager_Class/index.html#//apple_ref/c/econst/PHImageContentModeAspectFit]

## License

The MIT License (MIT)

Copyright (c) 2015 Tom Krones

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.