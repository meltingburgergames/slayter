package slayter.display;

import kha.Image;
import kha.graphics2.Graphics;

class ImageSprite extends Sprite {
	public var image(default, null):Image;

	public function new(image:Image):Void {
		super();
		this.image = image;
	}

	override function draw(g:Graphics) {
		g.drawImage(image, 0, 0);
	}
}
