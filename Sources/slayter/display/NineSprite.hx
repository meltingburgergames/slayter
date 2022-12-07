package slayter.display;

import kha.Image;
import kha.graphics2.Graphics;

class NineSprite extends Sprite {
	public var image(default, null):Image;
	public var width:Float;
	public var height:Float;
	public var borderWidth:Float;

	public function new(image:Image, width:Float, height:Float, borderWidth:Float):Void {
		super();
		this.image = image;
		this.width = width;
		this.height = height;
		this.borderWidth = borderWidth;
	}

	override function draw(renderimage:Image) {
		var g = renderimage.g2;
		var iw = this.image.width;
		var ih = this.image.height;
		var bw = borderWidth;
		g.drawScaledSubImage(image, bw, bw, iw - bw * 2, ih - bw * 2, bw, bw, width - bw * 2, height - bw * 2); // center
		g.drawSubImage(image, 0, 0, 0, 0, bw, bw); // tl
		g.drawSubImage(image, width - bw, 0, iw - bw, 0, bw, bw); // tr
		g.drawSubImage(image, 0, height - bw, 0, ih - bw, bw, bw); // bl
		g.drawSubImage(image, width - bw, height - bw, iw - bw, ih - bw, bw, bw); // br
		g.drawScaledSubImage(image, bw, 0, iw - bw * 2, bw, bw, 0, width - bw * 2, bw); // top
		g.drawScaledSubImage(image, bw, ih - bw, iw - bw * 2, bw, bw, height - bw, width - bw * 2, bw); // bottom
		g.drawScaledSubImage(image, 0, bw, bw, ih - bw * 2, 0, bw, bw, height - bw * 2); // left
		g.drawScaledSubImage(image, iw - bw, bw, bw, ih - bw * 2, width - bw, bw, bw, height - bw * 2); // right
	}
}
