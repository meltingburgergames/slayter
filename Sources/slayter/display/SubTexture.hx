package slayter.display;

import kha.Image;
import kha.graphics2.Graphics;
import kha.FastFloat;

@:allow(slayter.display)
class SubTexture implements Texture {
	public var parent:Texture;
	public var image(get, null):Image;
	public var width(get, null):Int;
	public var height(get, null):Int;
	public var rootX(default, null):Int = 0;
	public var rootY(default, null):Int = 0;

	public function new(parent:Texture, width:Int, height:Int):Void {
		this.parent = parent;
		this._width = width;
		this._height = height;
	}

	public function draw(g:Graphics, x:FastFloat, y:FastFloat):Void {
		g.drawSubImage(parent.image, x, y, rootX, rootY, _width, _height);
	}

	public function drawSubImage(g:Graphics, x:FastFloat, y:FastFloat, sx:FastFloat, sy:FastFloat, sw:FastFloat, sh:FastFloat):Void {
		g.drawSubImage(parent.image, x, y, rootX + sx, rootY + sy, sw, sh);
	}

	public function drawScaledSubImage(g:Graphics, sx:FastFloat, sy:FastFloat, sw:FastFloat, sh:FastFloat, dx:FastFloat, dy:FastFloat, dw:FastFloat,
			dh:FastFloat):Void {
		g.drawScaledSubImage(parent.image, rootX + sx, rootY + sy, sw, sh, dx, dy, dw, dh);
	}

	public function createSubTexture(x:Int, y:Int, width:Int, height:Int):Texture {
		var tex = new SubTexture(this, width, height);
        tex.rootX = rootX + x;
        tex.rootY = rootY + y;
        return tex;
	}

	private function get_width():Int {
		return _width;
	}

	private function get_height():Int {
		return _height;
	}

	private function get_image():Image {
		return parent.image;
	}

	private var _width:Int;
	private var _height:Int;
}
