'use strict';

var React, {NativeModules} = require('react-native');
var NativeSaveAssetLibrary = NativeModules.SaveAssetLibrary;

var SaveAssetLibrary = {
    SaveImage: function(obj) {
        NativeSaveAssetLibrary.saveImage(obj);
    },
};

module.exports = SaveAssetLibrary;