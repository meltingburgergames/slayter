package slayter.assets;

import kha.Image;
import kha.Assets as KhaAssets;

class Assets {
    public static function getImage(name :String) : Image {
        if(!_hasInitialized) {
            init();
        }
        return _images.get(name);
    }

    private static function init() : Void {
        if(!_hasInitialized) {
            _images = new Map();
            for(key in Reflect.fields(KhaAssets.images)) {
                var field = Reflect.getProperty(KhaAssets.images, key);
                if(field.files != null) {
                    var imageName = field.name;
                    var image = Reflect.getProperty(KhaAssets.images, imageName);
                    var fileName :String = field.files[0];
                    fileName = fileName.substring(0, fileName.lastIndexOf("."));
                    _images.set(fileName, image);
                }
            }
            _hasInitialized = true;
        }
    }

    private static var _hasInitialized = false;
    private static var _images :Map<String, Image>;
}