package slayter.differ.shapes;

import slayter.display.Sprite;
import slayter.differ.math.*;
import slayter.differ.shapes.*;
import slayter.differ.data.*;

/** A base collision shape */
class Shape extends Sprite {
	public var color:Int = 0xffffffff;
	public var manager(default, null):Null<CollisionManager>;

	public function new(?manager:Null<CollisionManager>):Void {
		super();
		this.manager = manager;
	}

	override function onAdded() {
		if (manager != null) {
			manager.addShape(this);
		}
	}

	override function onRemoved() {
		if (manager != null) {
			manager.removeShape(this);
		}
	}

	public function onShapeCollide(info:ShapeCollision):Void {}

	// Implemented in subclasses

	/** Test this shape against another shape. */
	public function test(shape:Shape, ?into:ShapeCollision):ShapeCollision
		return null;

	/** Test this shape against a circle. */
	public function testCircle(circle:Circle, ?into:ShapeCollision, flip:Bool = false):ShapeCollision
		return null;

	/** Test this shape against a polygon. */
	public function testPolygon(polygon:Polygon, ?into:ShapeCollision, flip:Bool = false):ShapeCollision
		return null;

	/** Test this shape against a ray. */
	public function testRay(ray:Ray, ?into:RayCollision):RayCollision
		return null;
}
