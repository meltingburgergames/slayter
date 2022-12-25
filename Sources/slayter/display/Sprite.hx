package slayter.display;

import slayter.util.Disposable;
import kha.graphics4.PipelineState;
import kha.graphics2.Graphics;
import kha.math.FastMatrix3;

/**
 * A class representing a 2D image or container of images that can be drawn to the screen and transformed.
 *
 * @implements {Disposable}
 */
@:allow(slayter.Slayter)
class Sprite implements Disposable {
	/**
	 * A flag indicating whether this sprite is currently active and should be updated and drawn.
	 *
	 * @type {boolean}
	 */
	public var active:Bool;

	/**
	 * The x position of this sprite in pixels.
	 *
	 * @type {number}
	 */
	public var x(default, set):Float;

	/**
	 * The y position of this sprite in pixels.
	 *
	 * @type {number}
	 */
	public var y(default, set):Float;

	/**
	 * The z position of this sprite in pixels.
	 *
	 * @type {number}
	 */
	public var yz:Float;

	/**
	 * The x anchor point of this sprite, relative to the sprite's dimensions.
	 *
	 * @type {number}
	 */
	public var anchorX(default, set):Float;

	/**
	 * The y anchor point of this sprite, relative to the sprite's dimensions.
	 *
	 * @type {number}
	 */
	public var anchorY(default, set):Float;

	/**
	 * The x scale of this sprite.
	 *
	 * @type {number}
	 */
	public var scaleX(default, set):Float;

	/**
	 * The y scale of this sprite.
	 *
	 * @type {number}
	 */
	public var scaleY(default, set):Float;

	/**
	 * The rotation of this sprite in radians.
	 *
	 * @type {number}
	 */
	public var rotation(default, set):Float;

	/**
	 * The alpha value of this sprite, where 0 is fully transparent and 1 is fully opaque.
	 *
	 * @type {number}
	 */
	public var alpha:Float;

	/**
	 * A flag indicating whether this sprite should be drawn to the screen.
	 *
	 * @type {boolean}
	 */
	public var visible:Bool;

	/**
	 * The list of child sprites contained within this sprite.
	 *
	 * @type {Children}
	 */
	public var children(default, null):Children;

	/**
	 * The parent sprite that contains this sprite.
	 *
	 * @type {Sprite}
	 */
	public var parent(default, null):Sprite;

	/**
	 * The pipeline state to use when drawing this sprite.
	 *
	 * @type {PipelineState}
	 */
	public var pipeline:PipelineState = null;

	/**
	 * The pipeline state to use as a filter when drawing this sprite.
	 *
	 * @type {PipelineState}
	 */
	public var filter:PipelineState = null;

	/**
	 * Constructs a new `Sprite` instance.
	 */
	public function new():Void {
		this.active = true;
		this.x = 0;
		this.y = 0;
		this.yz = 0;
		this.anchorX = 0;
		this.anchorY = 0;
		this.scaleX = 1;
		this.scaleY = 1;
		this.rotation = 0;
		this.alpha = 1;
		this.visible = true;
		this.children = new Children();
	}

	/**
	 * Sets the x and y position of the sprite.
	 *
	 * @param {number} x - The x position of the sprite.
	 * @param {number} y - The y position of the sprite.
	 * @return {Sprite} The sprite instance.
	 */
	public function setXY(x:Float, y:Float):Sprite {
		this.x = x;
		this.y = y;
		return this;
	}

	/**
	 * Sets the anchor point for the sprite.
	 *
	 * @param {number} x - The x anchor point for the sprite.
	 * @param {number} y - The y anchor point for the sprite.
	 * @return {Sprite} The sprite instance.
	 */
	public function setAnchor(x:Float, y:Float):Sprite {
		this.anchorX = x;
		this.anchorY = y;
		return this;
	}

	/**
	 * Sets the scale of the sprite on the x and y axes.
	 * @param x The scale on the x axis.
	 * @param y The scale on the y axis.
	 * @return {Sprite} The sprite instance.
	 */
	public function setScale(x:Float, y:Float):Sprite {
		this.scaleX = x;
		this.scaleY = y;
		return this;
	}

	/**
	 * Sets the rotation of the sprite in degrees.
	 * @param r The rotation in degrees.
	 * @return {Sprite} The sprite instance.
	 */
	public function setRotation(r:Float):Sprite {
		this.rotation = r;
		return this;
	}

	/**
	 * Sets the alpha (transparency) of the sprite.
	 * @param a The alpha value, between 0 (fully transparent) and 1 (fully opaque).
	 * @return {Sprite} The sprite instance.
	 */
	public function setAlpha(a:Float):Sprite {
		this.alpha = a;
		return this;
	}

	/**
	 * Adds a child sprite to this sprite. If the child is already a child of another sprite, it will be removed from that sprite first.
	 * @param c The child sprite to add.
	 * @return {Sprite} The sprite instance.
	 */
	public function addChild(c:Sprite):Sprite {
		if (c.parent != null) {
			c.parent.removeChild(c);
		}
		c.parent = this;
		this.children.push(c);
		c.onAdded();
		return this;
	}

	/**
	 * Removes a child sprite from this sprite.
	 * @param c The child sprite to remove.
	 * @return {Sprite} The sprite instance.
	 */
	public function removeChild(c:Sprite):Sprite {
		var wasRemoved = this.children.remove(c);
		if (wasRemoved) {
			c.onRemoved();
			if (c._hasCalledOnStart) {
				c.onEnd();
				c._hasCalledOnStart = false;
			}
			c.parent = null;
		}
		return this;
	}

	/**
	 * Updates the sprite. This method should be called once per frame.
	 * @param dt The time elapsed since the last frame, in seconds.
	 */
	public function update(dt:Float):Void {}

	/**
	 * Draws the sprite. This method should be called once per frame.
	 * @param g The graphics object to draw with.
	 */
	public function draw(g:Graphics):Void {}

	/**
	 * Called when the sprite is added to a parent sprite.
	 */
	public function onAdded():Void {}

	/**
	 * Called when the sprite is removed from a parent sprite.
	 */
	public function onRemoved():Void {}

	/**
	 * Called when the sprite is added to the stage (i.e., the root sprite) and is about to start running.
	 */
	public function onStart():Void {}

	/**
	 * Called when the sprite is removed from the stage (i.e., the root sprite) and is about to stop running.
	 */
	public function onEnd():Void {}

	/**
	 * Disposes of all children of this sprite.
	 */
	public function disposeChildren() {
		while (children.length != 0) {
			children.last().dispose();
		}
	}

	/**
	 * Disposes of this sprite and all of its children.
	 */
	public function dispose() {
		if (parent != null) {
			parent.removeChild(this);
		}
		disposeChildren();
	}

	private function set_x(x:Float):Float {
		if (this.x != x) {
			_isDirty = true;
		}
		return this.x = x;
	}

	private function set_y(y:Float):Float {
		if (this.y != y) {
			_isDirty = true;
		}
		return this.y = y;
	}

	private function set_anchorX(anchorX:Float):Float {
		if (this.anchorX != anchorX) {
			_isDirty = true;
		}
		return this.anchorX = anchorX;
	}

	private function set_anchorY(anchorY:Float):Float {
		if (this.anchorY != anchorY) {
			_isDirty = true;
		}
		return this.anchorY = anchorY;
	}

	private function set_scaleX(scaleX:Float):Float {
		if (this.scaleX != scaleX) {
			_isDirty = true;
		}
		return this.scaleX = scaleX;
	}

	private function set_scaleY(scaleY:Float):Float {
		if (this.scaleY != scaleY) {
			_isDirty = true;
		}
		return this.scaleY = scaleY;
	}

	private function set_rotation(rotation:Float):Float {
		if (this.rotation != rotation) {
			_isDirty = true;
		}
		return this.rotation = rotation;
	}

	private function updateMatrix():Void {
		if (_isDirty) {
			_matrix = FastMatrix3.translation(x, y)
				.multmat(FastMatrix3.rotation(rotation))
				.multmat(FastMatrix3.scale(scaleX, scaleY))
				.multmat(FastMatrix3.translation(-anchorX, -anchorY));
			_isDirty = false;
		}
	}

	private var _isDirty:Bool = false;
	private var _matrix:FastMatrix3 = FastMatrix3.identity();
	private var _hasCalledOnStart = false;
}
