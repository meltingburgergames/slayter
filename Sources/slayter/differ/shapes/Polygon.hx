package slayter.differ.shapes;

import slayter.display.Sprite;
import kha.graphics2.Graphics;
import slayter.differ.math.*;
import slayter.differ.shapes.*;
import slayter.differ.data.*;
import slayter.differ.sat.*;

using kha.graphics2.GraphicsExtension;

/** A polygonal collision shape */
class Polygon extends Shape {
	/** The transformed (rotated/scale) vertices cache */
	public var transformedVertices(get, never):Array<DifferVec>;

	/** The vertices of this shape */
	public var vertices(get, never):Array<DifferVec>;

	var _transformedVertices:Array<DifferVec>;
	var _vertices:Array<DifferVec>;

	/** Create a new polygon with a given set of vertices at position x,y. */
	public function new(vertices:Array<DifferVec>, ?manager :CollisionManager) {
		super(manager);
		_transformedVertices = new Array<DifferVec>();
		_vertices = vertices;
	}

	/** Test for a collision with a shape. */
	override public function test(shape:Shape, ?into:ShapeCollision):ShapeCollision {
		return shape.testPolygon(this, into, true);
	}

	/** Test for a collision with a circle. */
	override public function testCircle(circle:Circle, ?into:ShapeCollision, flip:Bool = false):ShapeCollision {
		return SAT2D.testCircleVsPolygon(circle, this, into, !flip);
	}

	/** Test for a collision with a polygon. */
	override public function testPolygon(polygon:Polygon, ?into:ShapeCollision, flip:Bool = false):ShapeCollision {
		return SAT2D.testPolygonVsPolygon(this, polygon, into, flip);
	}

	/** Test for a collision with a ray. */
	override public function testRay(ray:Ray, ?into:RayCollision):RayCollision {
		return SAT2D.testRayVsPolygon(ray, this, into);
	}

	override public function draw(g:Graphics):Void {
		if(this.color == 0) {
			return;
		}
		var oldColor = g.color;
		g.color = color;
		for (i in 0..._vertices.length) {
			var v1 = _vertices[i];
			var v2 = _vertices[(i + 1) % _vertices.length];
			g.drawLine(v1.x, v1.y, v2.x, v2.y);
		}
		g.fillCircle(anchorX, anchorY, 1);
		g.color = oldColor;
	}

	// Public static API

	/** Helper to create an Ngon at x,y with given number of sides, and radius.
		A default radius of 100 if unspecified. Returns a ready made `Polygon` collision `Shape` */
	public static function create(sides:Int, radius:Float = 100):Polygon {
		if (sides < 3) {
			throw 'Polygon - Needs at least 3 sides';
		}

		var rotation:Float = (Math.PI * 2) / sides;
		var angle:Float;
		var vector:DifferVec;
		var vertices:Array<DifferVec> = new Array<DifferVec>();

		for (i in 0...sides) {
			angle = (i * rotation) + ((Math.PI - rotation) * 0.5);
			vector = new DifferVec();
			vector.x = Math.cos(angle) * radius;
			vector.y = Math.sin(angle) * radius;
			vertices.push(vector);
		}

		return new Polygon(vertices);
	}

	/** Helper generate a rectangle at x,y with a given width/height and centered state.
		Centered by default. Returns a ready made `Polygon` collision `Shape` */
	public static function rectangle(width:Float, height:Float):Polygon {
		var vertices:Array<DifferVec> = new Array<DifferVec>();

		vertices.push(new DifferVec(0, 0));
		vertices.push(new DifferVec(width, 0));
		vertices.push(new DifferVec(width, height));
		vertices.push(new DifferVec(0, height));

		return new Polygon(vertices);
	}

	/** Helper generate a square at x,y with a given width/height with given centered state.
		Centered by default. Returns a ready made `Polygon` collision `Shape` */
	public static inline function square(width:Float):Polygon {
		return rectangle(width, width);
	}

	/** Helper generate a triangle at x,y with a given radius.
		Returns a ready made `Polygon` collision `Shape` */
	public static function triangle(radius:Float):Polygon {
		return create(3, radius);
	}

	override function updateMatrix():Void {
		var isDirty = _isDirty;
		super.updateMatrix();
		if (isDirty) {
			_transformedVertices = new Array<DifferVec>();
			var _count:Int = _vertices.length;
			for (i in 0..._count) {
				_transformedVertices.push(_vertices[i].clone().transform(_matrix));
			}
		}
	}

	function get_transformedVertices():Array<DifferVec> {
		updateMatrix();
		return _transformedVertices;
	}

	function get_vertices():Array<DifferVec> {
		return _vertices;
	}
}
