package slayter.display;

import kha.Image;
import kha.graphics2.Graphics;
import kha.FastFloat;

/**
 * A class that represents a sub-region of a larger texture.
 *
 * @package slayter.display
 * @implements {Texture}
 */
@:allow(slayter.display)
class SubTexture implements Texture {
	/**
	 * The parent texture that this sub-texture is a part of.
	 *
	 * @type {Texture}
	 */
	public var parent:Texture;

	/**
	 * The image data for this sub-texture.
	 *
	 * @type {Image}
	 */
	public var image(get, null):Image;

	/**
	 * The width of this sub-texture in pixels.
	 *
	 * @type {Int}
	 */
	public var width(get, null):Int;

	/**
	 * The height of this sub-texture in pixels.
	 *
	 * @type {Int}
	 */
	public var height(get, null):Int;

	/**
	 * The x-coordinate of the top-left corner of this sub-texture within the parent texture.
	 *
	 * @type {Int}
	 * @default 0
	 */
	public var rootX(default, null):Int = 0;

	/**
	 * The y-coordinate of the top-left corner of this sub-texture within the parent texture.
	 *
	 * @type {Int}
	 * @default 0
	 */
	public var rootY(default, null):Int = 0;

	/**
	 * Constructs a new `SubTexture` instance.
	 *
	 * @param {Texture} parent - The parent texture that this sub-texture is a part of.
	 * @param {Int} width - The width of this sub-texture in pixels.
	 * @param {Int} height - The height of this sub-texture in pixels.
	 */
	public function new(parent:Texture, width:Int, height:Int):Void {
		this.parent = parent;
		this._width = width;
		this._height = height;
	}

	/**
	 * Draws this sub-texture onto the specified graphics object at the specified position.
	 *
	 * @param {Graphics} g - The graphics object to draw onto.
	 * @param {FastFloat} x - The x-coordinate to draw at.
	 * @param {FastFloat} y - The y-coordinate to draw at.
	 */
	public function draw(g:Graphics, x:FastFloat, y:FastFloat):Void {
		g.drawSubImage(parent.image, x, y, rootX, rootY, _width, _height);
	}

	/**
	 * Draws a sub-region of this sub-texture onto the specified graphics object at the specified position.
	 *
	 * @param {Graphics} g - The graphics object to draw onto.
	 * @param {FastFloat} x - The x-coordinate to draw at.
	 * @param {FastFloat} y - The y-coordinate to draw at.
	 * @param {FastFloat} sx - The x-coordinate of the top-left corner of the sub-region within this sub-texture.
	 * @param {FastFloat} sy - The y-coordinate of the top-left corner of the sub-region within this sub-texture.
	 * @param {FastFloat} sw - The width of the sub-region in pixels.
	 * @param {FastFloat} sh - The height of the sub-region in pixels.
	 */
	public function drawSubImage(g:Graphics, x:FastFloat, y:FastFloat, sx:FastFloat, sy:FastFloat, sw:FastFloat, sh:FastFloat):Void {
		g.drawSubImage(parent.image, x, y, rootX + sx, rootY + sy, sw, sh);
	}

	/**
	 * Draws a scaled version of a sub-region of this sub-texture onto the specified graphics object at the specified position.
	 *
	 * @param {Graphics} g - The graphics object to draw onto.
	 * @param {FastFloat} sx - The x-coordinate of the top-left corner of the sub-region within this sub-texture.
	 * @param {FastFloat} sy - The y-coordinate of the top-left corner of the sub-region within this sub-texture.
	 * @param {FastFloat} sw - The width of the sub-region in pixels.
	 * @param {FastFloat} sh - The height of the sub-region in pixels.
	 * @param {FastFloat} dx - The x-coordinate to draw the scaled image at.
	 * @param {FastFloat} dy - The y-coordinate to draw the scaled image at.
	 * @param {FastFloat} dw - The width to draw the scaled image at.
	 * @param {FastFloat} dh - The height to draw the scaled image at.
	 */
	public function drawScaledSubImage(g:Graphics, sx:FastFloat, sy:FastFloat, sw:FastFloat, sh:FastFloat, dx:FastFloat, dy:FastFloat, dw:FastFloat,
			dh:FastFloat):Void {
		g.drawScaledSubImage(parent.image, rootX + sx, rootY + sy, sw, sh, dx, dy, dw, dh);
	}

	/**
	 * Creates a new sub-texture from a sub-region of this sub-texture.
	 *
	 * @param {Int} x - The x-coordinate of the top-left corner of the sub-region within this sub-texture.
	 * @param {Int} y - The y-coordinate of the top-left corner of the sub-region within this sub-texture.
	 * @param {Int} width - The width of the sub-region in pixels.
	 * @param {Int} height - The height of the sub-region in pixels.
	 *
	 * @returns {Texture} A new `Texture` instance representing the specified sub-region of this sub-texture.
	 */
	public function createSubTexture(x:Int, y:Int, width:Int, height:Int):Texture {
		var tex = new SubTexture(this, width, height);
		tex.rootX = rootX + x;
		tex.rootY = rootY + y;
		return tex;
	}

	private function get_width():Int {
		return _width;
	}

	private function get_height():Int {
		return _height;
	}

	private function get_image():Image {
		return parent.image;
	}

	private var _width:Int;
	private var _height:Int;
}
