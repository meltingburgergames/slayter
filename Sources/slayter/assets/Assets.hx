package slayter.assets;

import haxe.ds.Map;
import kha.Font;
import slayter.display.BaseTexture;
import slayter.display.Texture;
import kha.Assets as KhaAssets;

class Assets {
    public static function getImage(name :String) : Texture {
        if(!_hasInitialized) {
            init();
        }
        return _images.get(name);
    }

    public static function getFont(name :String) : Font {
        if(!_hasInitialized) {
            init();
        }
        return _fonts.get(name);
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
                    _images.set(fileName, new BaseTexture(image));
                }
            }
            
            _fonts = new Map();
            for(key in Reflect.fields(KhaAssets.fonts)) {
                var field = Reflect.getProperty(KhaAssets.fonts, key);
                if(field.files != null) {
                    var fontName = field.name;
                    var font = Reflect.getProperty(KhaAssets.fonts, fontName);
                    var fileName :String = field.files[0];
                    fileName = fileName.substring(0, fileName.lastIndexOf("."));
                    _fonts.set(fileName, font);
                }
            }

            _hasInitialized = true;
        }
    }

    private static var _hasInitialized = false;
    private static var _images :Map<String, Texture>;
    private static var _fonts :Map<String, Font>;
}