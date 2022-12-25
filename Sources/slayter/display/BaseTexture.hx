package slayter.display;

import kha.FastFloat;
import kha.graphics2.Graphics;
import kha.Image;

/**
 * A texture represents a graphical image. It can be drawn to the screen using a Graphics object.
 *
 * @class slayter.display.BaseTexture
 * @implements {Texture}
 */
class BaseTexture implements Texture {
	/**
	 * The image that this texture represents.
	 *
	 * @type {kha.Image}
	 * @readonly
	 */
	public var image(get, null):Image;

	/**
	 * The width of the image, in pixels.
	 *
	 * @type {number}
	 * @readonly
	 */
	public var width(get, null):Int;

	/**
	 * The height of the image, in pixels.
	 *
	 * @type {number}
	 * @readonly
	 */
	public var height(get, null):Int;

	/**
	 * The x coordinate of the top left corner of the image, relative to the root image.
	 *
	 * @type {number}
	 * @default 0
	 */
	public var rootX(default, null):Int = 0;

	/**
	 * The y coordinate of the top left corner of the image, relative to the root image.
	 *
	 * @type {number}
	 * @default 0
	 */
	public var rootY(default, null):Int = 0;

	/**
	 * Creates a new texture with the specified image.
	 *
	 * @param {kha.Image} image - The image for the texture.
	 */
	public function new(image:Image):Void {
		_image = image;
	}

	/**
	 * Draws the texture to the screen using the specified graphics object.
	 *
	 * @param {kha.graphics2.Graphics} g - The graphics object to use for drawing.
	 * @param {kha.FastFloat} x - The x coordinate to draw the texture at.
	 * @param {kha.FastFloat} y - The y coordinate to draw the texture at.
	 */
	public function draw(g:Graphics, x:FastFloat, y:FastFloat):Void {
		g.drawImage(_image, x, y);
	}

	/**
	 * Draws a portion of the texture to the screen using the specified graphics object.
	 *
	 * @param {kha.graphics2.Graphics} g - The graphics object to use for drawing.
	 * @param {kha.FastFloat} x - The x coordinate to draw the texture at.
	 * @param {kha.FastFloat} y - The y coordinate to draw the texture at.
	 * @param {kha.FastFloat} sx - The x coordinate of the top left corner of the portion of the texture to draw.
	 * @param {kha.FastFloat} sy - The y coordinate of the top left corner of the portion of the texture to draw.
	 * @param {kha.FastFloat} sw - The width of the portion of the texture to draw.
	 * @param {kha.FastFloat} sh - The height of the portion of the texture to draw.
	 */
	public function drawSubImage(g:Graphics, x:FastFloat, y:FastFloat, sx:FastFloat, sy:FastFloat, sw:FastFloat, sh:FastFloat):Void {
		g.drawSubImage(_image, x, y, sx, sy, sw, sh);
	}

	/**
	 * Draws a portion of the texture to the screen using the specified graphics object, scaled to the specified size.
	 *
	 * @param {kha.graphics2.Graphics} g - The graphics object to use for drawing.
	 * @param {kha.FastFloat} sx - The x coordinate of the top left corner of the portion of the texture to draw.
	 * @param {kha.FastFloat} sy - The y coordinate of the top left corner of the portion of the texture to draw.
	 * @param {kha.FastFloat} sw - The width of the portion of the texture to draw.
	 * @param {kha.FastFloat} sh - The height of the portion of the texture to draw.
	 * @param {kha.FastFloat} dx - The x coordinate to draw the texture at.
	 * @param {kha.FastFloat} dy - The y coordinate to draw the texture at.
	 * @param {kha.FastFloat} dw - The width to scale the drawn texture to.
	 * @param {kha.FastFloat} dh - The height to scale the drawn texture to.
	 */
	public function drawScaledSubImage(g:Graphics, sx:FastFloat, sy:FastFloat, sw:FastFloat, sh:FastFloat, dx:FastFloat, dy:FastFloat, dw:FastFloat,
			dh:FastFloat):Void {
		g.drawScaledSubImage(_image, sx, sy, sw, sh, dx, dy, dw, dh);
	}

	/**
	 * Creates a new texture that represents a portion of the current texture.
	 *
	 * @param {number} x - The x coordinate of the top left corner of the portion of the texture to create a new texture from.
	 * @param {number} y - The y coordinate of the top left corner of the portion of the texture to create a new texture from.
	 * @param {number} width - The width of the portion of the texture to create a new texture from.
	 * @param {number} height - The height of the portion of the texture to create a new texture from.
	 * @return {Texture} The new texture representing the specified portion of the current texture.
	 */
	public function createSubTexture(x:Int, y:Int, width:Int, height:Int):Texture {
		var tex = new SubTexture(this, width, height);
		tex.rootX = rootX + x;
		tex.rootY = rootY + y;
		return tex;
	}

	private function get_width():Int {
		return _image.width;
	}

	private function get_height():Int {
		return _image.height;
	}

	private function get_image():Image {
		return _image;
	}

	private var _image:Image;
}
