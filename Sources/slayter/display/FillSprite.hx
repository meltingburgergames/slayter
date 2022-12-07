package slayter.display;

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

	override function draw(g:Graphics) {
		var lastColor = g.color;
		g.color = this.color;
		g.fillRect(0, 0, width, height);
		g.color = lastColor;
	}
}
