'use strict';

var React, {NativeModules} = require('react-native');
var NativeSaveAssetLibrary = NativeModules.SaveAssetLibrary;

var SaveAssetLibrary = {
    SaveImage: function(obj, successCallBack, errorCallback) {
        var defaults = {
            imageType: 'jpg',
            width: 2048,
            height: 2048,
        }
        var parameters = {...defaults, ...obj};
        NativeSaveAssetLibrary.saveImage(parameters, successCallBack, errorCallback);
    },
};

module.exports = SaveAssetLibrary;
