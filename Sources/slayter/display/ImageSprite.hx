package slayter.display;

import kha.Image;
import kha.graphics2.Graphics;

class ImageSprite extends Sprite {
	public var texture(default, null):Texture;

	public function new(texture:Texture):Void {
		super();
		this.texture = texture;
	}

	override function draw(g:Graphics) {
		texture.draw(g, 0, 0);
	}
}
