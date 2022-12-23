package slayter.assets;

import haxe.ds.Map;
import kha.Font;
import slayter.display.BaseTexture;
import slayter.display.Texture;
import kha.Assets as KhaAssets;

/**
 * The `Assets` class is a utility for managing and accessing image and font assets in a Kha project.
 * 
 * It has a static `init` method that populates its internal maps of images and fonts using the `KhaAssets` object. It also has `getImage` and `getFont` methods that allow you to retrieve a specific image or font by name.
 * 
 * The `Assets` class should be initialized before use, either manually by calling the `init` method or automatically when the first image or font is accessed.
 */
class Assets {
	/**
	 * Retrieves an image asset by name.
	 * 
	 * The `Assets` class must be initialized before calling this method.
	 * 
	 * @param name - The name of the image asset to retrieve.
	 * @return The image asset with the specified name, or `null` if it does not exist.
	 */
	public static function getImage(name:String):Texture {
		if (!_hasInitialized) {
			init();
		}
		return _images.get(name);
	}

	/**
	 * Retrieves a font asset by name.
	 * 
	 * The `Assets` class must be initialized before calling this method.
	 * 
	 * @param name - The name of the font asset to retrieve.
	 * @return The font asset with the specified name, or `null` if it does not exist.
	 */
	public static function getFont(name:String):Font {
		if (!_hasInitialized) {
			init();
		}
		return _fonts.get(name);
	}

	/**
	 * Initializes the `Assets` class by populating its internal maps of images and fonts.
	 * 
	 * This method should be called before accessing any images or fonts through the `getImage` or `getFont` methods. It only needs to be called once.
	 */
	private static function init():Void {
		if (!_hasInitialized) {
			_images = new Map();
			for (key in Reflect.fields(KhaAssets.images)) {
				var field = Reflect.getProperty(KhaAssets.images, key);
				if (field.files != null) {
					var imageName = field.name;
					var image = Reflect.getProperty(KhaAssets.images, imageName);
					var fileName:String = field.files[0];
					fileName = fileName.substring(0, fileName.lastIndexOf("."));
					_images.set(fileName, new BaseTexture(image));
				}
			}

			_fonts = new Map();
			for (key in Reflect.fields(KhaAssets.fonts)) {
				var field = Reflect.getProperty(KhaAssets.fonts, key);
				if (field.files != null) {
					var fontName = field.name;
					var font = Reflect.getProperty(KhaAssets.fonts, fontName);
					var fileName:String = field.files[0];
					fileName = fileName.substring(0, fileName.lastIndexOf("."));
					_fonts.set(fileName, font);
				}
			}

			_hasInitialized = true;
		}
	}

	private static var _hasInitialized = false;
	private static var _images:Map<String, Texture>;
	private static var _fonts:Map<String, Font>;
}
