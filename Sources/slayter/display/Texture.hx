package slayter.display;

import kha.Image;
import kha.FastFloat;
import kha.graphics2.Graphics;

interface Texture {
	var width(get, null):Int;
	var height(get, null):Int;
	var rootX(default, null):Int;
	var rootY(default, null):Int;
	var image(get, null):Image;

	function draw(g:Graphics, x:FastFloat, y:FastFloat):Void;

	function drawSubImage(g:Graphics, x:FastFloat, y:FastFloat, sx:FastFloat, sy:FastFloat, sw:FastFloat, sh:FastFloat):Void;

	function drawScaledSubImage(g:Graphics, sx:FastFloat, sy:FastFloat, sw:FastFloat, sh:FastFloat, dx:FastFloat, dy:FastFloat, dw:FastFloat,
		dh:FastFloat):Void;

	function createSubTexture(x :Int, y :Int, width :Int, height :Int):Texture;
}
