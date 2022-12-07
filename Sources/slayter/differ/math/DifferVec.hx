package slayter.differ.math;

import kha.math.FastMatrix3;

// NOTE : Only implements the basics required for the collision code.
// The goal is to make this library as simple and unencumbered as possible, making it easier to integrate
// into an existing codebase. This means that using abstracts or similar you can add a function like "toMyEngineVectorFormat()"
// or simple an adapter pattern to convert to your preferred format. It simplifies usage and handles internals, nothing else.
// This also means that ALL of these functions are used and are needed.

/** 2D vector class */
class DifferVec {
	/** The x component */
	public var x:Float = 0;

	/** The y component */
	public var y:Float = 0;

	/** The length of the vector */
	public var length(get, set):Float;

	/** The length, squared, of the vector */
	public var lengthsq(get, never):Float;

	public function new(_x:Float = 0, _y:Float = 0) {
		x = _x;
		y = _y;
	}

	/** Copy, returns a new vector instance from this vector. */
	public inline function clone():DifferVec {
		return new DifferVec(x, y);
	}

	/** Transforms Vector based on the given Matrix. Returns this vector, modified. */
	public function transform(matrix:FastMatrix3):DifferVec {
		var v:DifferVec = clone();
		v.x = x * matrix._00 + y * matrix._10 + matrix._20;
		v.y = x * matrix._01 + y * matrix._11 + matrix._21;

		return v;
	}

	/** Sets the vector's length to 1. Returns this vector, modified. */
	public function normalize():DifferVec {
		if (length == 0) {
			x = 1;
			return this;
		}

		var len:Float = length;

		x /= len;
		y /= len;

		return this;
	} // normalize

	/** Sets the length to fit under the given maximum value.
		Nothing is done if the vector is already shorter.
		Returns this vector, modified. */
	public function truncate(max:Float):DifferVec {
		length = Math.min(max, length);

		return this;
	}

	/** Invert this vector. Returns this vector, modified. */
	public function invert():DifferVec {
		x = -x;
		y = -y;

		return this;
	}

	/** Return the dot product of this vector and another vector. */
	public function dot(other:DifferVec):Float {
		return x * other.x + y * other.y;
	}

	/** Return the cross product of this vector and another vector. */
	public function cross(other:DifferVec):Float {
		return x * other.y - y * other.x;
	}

	/** Add a vector to this vector. Returns this vector, modified. */
	public function add(other:DifferVec):DifferVec {
		x += other.x;
		y += other.y;

		return this;
	}

	/** Subtract a vector from this one. Returns this vector, modified. */
	public function subtract(other:DifferVec):DifferVec {
		x -= other.x;
		y -= other.y;

		return this;
	}

	/** Return a string representation of this vector. */
	public function toString():String
		return "Vector x:" + x + ", y:" + y;

	inline function set_length(value:Float):Float {
		var ep:Float = 0.00000001;
		var _angle:Float = Math.atan2(y, x);

		x = Math.cos(_angle) * value;
		y = Math.sin(_angle) * value;

		if (Math.abs(x) < ep)
			x = 0;
		if (Math.abs(y) < ep)
			y = 0;

		return value;
	}

	inline function get_length():Float
		return Math.sqrt(lengthsq);

	inline function get_lengthsq():Float
		return x * x + y * y;
}
