package slayter.display;

import kha.Image;
import kha.graphics2.Graphics;

class SubImageSprite extends Sprite {
	public var image:Image;
	public var sx(default, null):Float;
	public var sy(default, null):Float;
	public var sw(default, null):Float;
	public var sh(default, null):Float;

	public function new(image:Image, sx:Float, sy:Float, sw:Float, sh:Float):Void {
		super();
		this.image = image;
		this.sx = sx;
		this.sy = sy;
		this.sw = sw;
		this.sh = sh;
	}

	override function draw(g:Graphics) {
		g.drawSubImage(image, 0, 0, sx, sy, sw, sh);
	}
}
