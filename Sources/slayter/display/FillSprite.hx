package slayter.display;

import kha.Image;
import kha.graphics2.Graphics;

class FillSprite extends Sprite {
	public var color:Int;
	public var width(default, null):Float;
	public var height(default, null):Float;

	public function new(color:Int, width:Float, height:Float):Void {
		super();
		this.color = color;
		this.width = width;
		this.height = height;
	}

	override function draw(renderimage:Image) {
		var g = renderimage.g2;
		var lastColor = g.color;
		g.color = this.color;
		g.fillRect(0, 0, width, height);
		g.color = lastColor;
	}
}
