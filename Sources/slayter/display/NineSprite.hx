package slayter.display;

import kha.graphics2.Graphics;

/**
 * A sprite that displays a texture using 9-slice scaling.
 *
 * @class slayter.display.NineSprite
 * @extends {Sprite}
 */
class NineSprite extends Sprite {
	/**
	 * The texture to display.
	 *
	 * @type {Texture}
	 */
	public var texture(default, null):Texture;

	/**
	 * The width of the sprite, in pixels.
	 *
	 * @type {number}
	 */
	public var width:Float;

	/**
	 * The height of the sprite, in pixels.
	 *
	 * @type {number}
	 */
	public var height:Float;

	/**
	 * The width of the border around the center of the texture, in pixels.
	 *
	 * @type {number}
	 */
	public var borderWidth:Float;

	/**
	 * Creates a new nine sprite with the specified texture, width, height, and border width.
	 *
	 * @param {Texture} texture - The texture to display.
	 * @param {number} width - The width of the sprite.
	 * @param {number} height - The height of the sprite.
	 * @param {number} borderWidth - The width of the border around the center of the texture.
	 */
	public function new(texture:Texture, width:Float, height:Float, borderWidth:Float):Void {
		super();
		this.texture = texture;
		this.width = width;
		this.height = height;
		this.borderWidth = borderWidth;
	}

	/**
	 * @inheritDoc
	 */
	override function draw(g:Graphics) {
		var iw = texture.width;
		var ih = texture.height;
		var bw = borderWidth;
		texture.drawScaledSubImage(g, bw, bw, iw - bw * 2, ih - bw * 2, bw, bw, width - bw * 2, height - bw * 2); // center
		texture.drawSubImage(g, 0, 0, 0, 0, bw, bw); // tl
		texture.drawSubImage(g, width - bw, 0, iw - bw, 0, bw, bw); // tr
		texture.drawSubImage(g, 0, height - bw, 0, ih - bw, bw, bw); // bl
		texture.drawSubImage(g, width - bw, height - bw, iw - bw, ih - bw, bw, bw); // br
		texture.drawScaledSubImage(g, bw, 0, iw - bw * 2, bw, bw, 0, width - bw * 2, bw); // top
		texture.drawScaledSubImage(g, bw, ih - bw, iw - bw * 2, bw, bw, height - bw, width - bw * 2, bw); // bottom
		texture.drawScaledSubImage(g, 0, bw, bw, ih - bw * 2, 0, bw, bw, height - bw * 2); // left
		texture.drawScaledSubImage(g, iw - bw, bw, bw, ih - bw * 2, width - bw, bw, bw, height - bw * 2); // right
	}
}
