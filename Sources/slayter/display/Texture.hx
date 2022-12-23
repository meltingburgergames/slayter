package slayter.display;

import kha.Image;
import kha.FastFloat;
import kha.graphics2.Graphics;

/**
 * The `Texture` interface represents a graphical image that can be drawn to a `Graphics` object.
 * 
 * It has properties for the width and height of the texture, as well as the root X and Y coordinates. It also has an `image` property that returns the underlying `Image` object.
 * 
 * The `Texture` interface has several methods for drawing the texture to a `Graphics` object:
 * 
 * - `draw` draws the entire texture at the specified coordinates.
 * - `drawSubImage` draws a portion of the texture at the specified coordinates.
 * - `drawScaledSubImage` draws a portion of the texture, scaled to the specified dimensions, at the specified coordinates.
 * - `createSubTexture` creates a new `Texture` object that represents a portion of the original texture.
 */
interface Texture {
	/** The width of the texture, in pixels. */
	var width(get, null):Int;

	/** The height of the texture, in pixels. */
	var height(get, null):Int;

	/** The root X coordinate of the texture. */
	var rootX(default, null):Int;

	/** The root Y coordinate of the texture. */
	var rootY(default, null):Int;

	/** The underlying `Image` object. */
	var image(get, null):Image;

	/**
	 * Draws the entire texture at the specified coordinates.
	 * 
	 * @param g - The `Graphics` object to draw to.
	 * @param x - The X coordinate to draw at.
	 * @param y - The Y coordinate to draw at.
	 */
	function draw(g:Graphics, x:FastFloat, y:FastFloat):Void;

	/**
	 * Draws a portion of the texture at the specified coordinates.
	 * 
	 * @param g - The `Graphics` object to draw to.
	 * @param x - The X coordinate to draw at.
	 * @param y - The Y coordinate to draw at.
	 * @param sx - The X coordinate of the top-left corner of the portion of the texture to draw.
	 * @param sy - The Y coordinate of the top-left corner of the portion of the texture to draw.
	 * @param sw - The width of the portion of the texture to draw.
	 * @param sh - The height of the portion of the texture to draw.
	 */
	function drawSubImage(g:Graphics, x:FastFloat, y:FastFloat, sx:FastFloat, sy:FastFloat, sw:FastFloat, sh:FastFloat):Void;

	/**
	 * Draws a portion of the texture at the specified coordinates, scaled to the specified dimensions.
	 * 
	 * @param g - The `Graphics` object to draw to.
	 * @param sx - The X coordinate of the top-left corner of the portion of the texture to draw.
	 * @param sy - The Y coordinate of the top-left corner of the portion of the texture to draw.
	 * @param sw - The width of the portion of the texture to draw.
	 * @param sh - The height of the portion of the texture to draw.
	 * @param dx - The X coordinate to draw at.
	 * @param dy - The Y coordinate to draw at.
	 * @param dw - The width to draw the portion of the texture at.
	 * @param dh - The height to draw the portion of the texture at.
	 */
	function drawScaledSubImage(g:Graphics, sx:FastFloat, sy:FastFloat, sw:FastFloat, sh:FastFloat, dx:FastFloat, dy:FastFloat, dw:FastFloat,
		dh:FastFloat):Void;

	/**
	 * Creates a new `Texture` object that represents a portion of the current texture.
	 * 
	 * @param x - The X coordinate of the top-left corner of the portion of the texture to create a new `Texture` for.
	 * @param y - The Y coordinate of the top-left corner of the portion of the texture to create a new `Texture` for.
	 * @param width - The width of the portion of the texture to create a new `Texture` for.
	 * @param height - The height of the portion of the texture to create a new `Texture` for.
	 * @return a new `Texture` object that represents the specified portion of the current texture.
	 */
	function createSubTexture(x:Int, y:Int, width:Int, height:Int):Texture;
}
