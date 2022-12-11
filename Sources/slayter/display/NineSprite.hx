package slayter.display;

import kha.graphics2.Graphics;

class NineSprite extends Sprite {
	public var texture(default, null):Texture;
	public var width:Float;
	public var height:Float;
	public var borderWidth:Float;

	public function new(texture:Texture, width:Float, height:Float, borderWidth:Float):Void {
		super();
		this.texture = texture;
		this.width = width;
		this.height = height;
		this.borderWidth = borderWidth;
	}

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
