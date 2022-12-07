package slayter.differ.shapes;

import kha.graphics2.Graphics;
import slayter.differ.math.*;
import slayter.differ.shapes.*;
import slayter.differ.data.*;
import slayter.differ.sat.*;

using kha.graphics2.GraphicsExtension;

/** A circle collision shape */
class Circle extends Shape {
	/** The radius of this circle. Set on construction */
	public var radius(get, never):Float;

	/** The transformed radius of this circle, based on the scale/rotation */
	public var transformedRadius(get, never):Float;

	var _radius:Float;

	public function new(radius:Float, ?manager :Null<CollisionManager>) {
		super(manager);
		_radius = radius;
	}

	/** Test for collision against a shape. */
	override public function test(shape:Shape, ?into:ShapeCollision):ShapeCollision {
		return shape.testCircle(this, into, true);
	}

	/** Test for collision against a circle. */
	override public function testCircle(circle:Circle, ?into:ShapeCollision, flip:Bool = false):ShapeCollision {
		return SAT2D.testCircleVsCircle(this, circle, into, flip);
	}

	/** Test for collision against a polygon. */
	override public function testPolygon(polygon:Polygon, ?into:ShapeCollision, flip:Bool = false):ShapeCollision {
		return SAT2D.testCircleVsPolygon(this, polygon, into, flip);
	}

	/** Test for collision against a ray. */
	override public function testRay(ray:Ray, ?into:RayCollision):RayCollision {
		return SAT2D.testRayVsCircle(ray, this, into);
	}

	override public function draw(g:Graphics):Void {
		var oldColor = g.color;
		g.color = color;
		g.drawCircle(0, 0, _radius);
		g.fillCircle(anchorX, anchorY, 2);
		g.color = oldColor;
	}

	function get_radius():Float {
		return _radius;
	}

	function get_transformedRadius():Float {
		return _radius * scaleX;
	}
}
