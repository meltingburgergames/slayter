package slayter.assets;

import kha.Image;
import kha.Assets;

class SlayterAssets {
    public static function getImage(name :String) : Image {
        if(!_hasInitialized) {
            init();
        }
        return _images.get(name);
    }

    private static function init() : Void {
        if(!_hasInitialized) {
            _images = new Map();
            for(key in Reflect.fields(Assets.images)) {
                var field = Reflect.getProperty(Assets.images, key);
                if(field.files != null) {
                    var imageName = field.name;
                    var image = Reflect.getProperty(Assets.images, imageName);
                    var fileName = field.files[0];
                    _images.set(fileName, image);
                }
            }
            _hasInitialized = true;
        }
    }

    private static var _hasInitialized = false;
    private static var _images :Map<String, Image>;
}