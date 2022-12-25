package slayter.display;

import kha.graphics2.Graphics;

/**
 * A sprite that is filled with a single color.
 *
 * @class slayter.display.FillSprite
 * @extends {Sprite}
 */
class FillSprite extends Sprite {
	/**
	 * The color of the sprite.
	 *
	 * @type {number}
	 */
	public var color:Int;

	/**
	 * The width of the sprite, in pixels.
	 *
	 * @type {number}
	 */
	public var width(default, null):Float;

	/**
	 * The height of the sprite, in pixels.
	 *
	 * @type {number}
	 */
	public var height(default, null):Float;

	/**
	 * Creates a new fill sprite with the specified color, width, and height.
	 *
	 * @param {number} color - The color of the sprite.
	 * @param {number} width - The width of the sprite.
	 * @param {number} height - The height of the sprite.
	 */
	public function new(color:Int, width:Float, height:Float):Void {
		super();
		this.color = color;
		this.width = width;
		this.height = height;
	}

	/**
	 * @inheritDoc
	 */
	override function draw(g:Graphics) {
		var lastColor = g.color;
		g.color = this.color;
		g.fillRect(0, 0, width, height);
		g.color = lastColor;
	}
}
