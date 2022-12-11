package slayter.display;

import kha.FastFloat;
import kha.graphics2.Graphics;
import kha.Image;

class BaseTexture implements Texture {
	public var image(get, null):Image;
	public var width(get, null):Int;
	public var height(get, null):Int;
    public var rootX (default, null) :Int = 0;
    public var rootY (default, null) :Int = 0;

	public function new(image:Image):Void {
		_image = image;
	}

	public function draw(g:Graphics, x:FastFloat, y:FastFloat):Void {
		g.drawImage(_image, x, y);
	}

	public function drawSubImage(g:Graphics, x:FastFloat, y:FastFloat, sx:FastFloat, sy:FastFloat, sw:FastFloat, sh:FastFloat):Void {
		g.drawSubImage(_image, x, y, sx, sy, sw, sh);
	}

	public function drawScaledSubImage(g:Graphics, sx:FastFloat, sy:FastFloat, sw:FastFloat, sh:FastFloat, dx:FastFloat, dy:FastFloat, dw:FastFloat,
			dh:FastFloat):Void {
		g.drawScaledSubImage(_image, sx, sy, sw, sh, dx, dy, dw, dh);
	}

	public function createSubTexture(x :Int, y :Int, width :Int, height :Int) : Texture {
		var tex = new SubTexture(this, width, height);
        tex.rootX = rootX + x;
        tex.rootY = rootY + y;
        return tex;
	}

	private function get_width():Int {
		return _image.width;
	}

	private function get_height():Int {
		return _image.height;
	}

    private function get_image() : Image {
        return _image;
    }

    private var _image :Image;
}
