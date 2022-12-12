package slayter.display;

import slayter.util.Disposable;
import kha.graphics4.PipelineState;
import kha.graphics2.Graphics;
import kha.math.FastMatrix3;

@:allow(slayter.Slayter)
class Sprite implements Disposable {
	public var active:Bool;
	public var x(default, set):Float;
	public var y(default, set):Float;
	public var yz:Float;
	public var anchorX(default, set):Float;
	public var anchorY(default, set):Float;
	public var scaleX(default, set):Float;
	public var scaleY(default, set):Float;
	public var rotation(default, set):Float;
	public var alpha:Float;
	public var visible:Bool;
	public var children(default, null):Array<Sprite>;
	public var parent(default, null):Sprite;
	public var pipeline:PipelineState = null;
	/**
	 * Set pipeline to use the blendmode.
	 */
	public var blendmode:BlendMode = BlendMode.Default;

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
		this.children = [];
	}

	public function setXY(x:Float, y:Float):Sprite {
		this.x = x;
		this.y = y;
		return this;
	}

	public function setAnchor(x:Float, y:Float):Sprite {
		this.anchorX = x;
		this.anchorY = y;
		return this;
	}

	public function setScale(x:Float, y:Float):Sprite {
		this.scaleX = x;
		this.scaleY = y;
		return this;
	}

	public function setRotation(r:Float):Sprite {
		this.rotation = r;
		return this;
	}

	public function setAlpha(a:Float):Sprite {
		this.alpha = a;
		return this;
	}

	public function addChild(c:Sprite):Sprite {
		if (c.parent != null) {
			c.parent.removeChild(c);
		}
		c.parent = this;
		this.children.push(c);
		c.onAdded();
		return this;
	}

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

	public function update(dt:Float):Void {}

	public function draw(g:Graphics):Void {}

	public function onAdded():Void {}

	public function onRemoved():Void {}

	public function onStart():Void {}

	public function onEnd():Void {}

	public function removeSelf():Void {
		if (this.parent != null) {
			this.parent.removeChild(this);
		}
	}

	public function removeChildren():Void {
		while (this.children.length > 0) {
			this.children[this.children.length - 1].removeSelf();
		}
	}

	public function dispose() {}

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
