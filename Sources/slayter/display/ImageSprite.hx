package slayter.display;

import kha.graphics2.Graphics;

/**
 * A sprite that displays an image.
 *
 * @class slayter.display.ImageSprite
 * @extends {Sprite}
 */
class ImageSprite extends Sprite {
	/**
	 * The texture to display.
	 *
	 * @type {Texture}
	 */
	public var texture(default, null):Texture;

	/**
	 * Creates a new image sprite with the specified texture.
	 *
	 * @param {Texture} texture - The texture to display.
	 */
	public function new(texture:Texture):Void {
		super();
		this.texture = texture;
	}

	/**
	 * @inheritDoc
	 */
	override function draw(g:Graphics) {
		texture.draw(g, 0, 0);
	}
}
