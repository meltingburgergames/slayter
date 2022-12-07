package slayter.differ.data;

import slayter.differ.math.*;
import slayter.differ.shapes.*;
import slayter.differ.data.*;

/** Ray intersection data obtained by testing two rays for intersection. */
@:publicFields
class RayIntersection {
	/** The first ray in the test */
	var ray1:Ray;

	/** The second ray in the test */
	var ray2:Ray;

	/** u value for ray1. */
	var u1:Float = 0.0;

	/** u value for ray2. */
	var u2:Float = 0.0;

	@:noCompletion
	inline function new() {}

	inline function reset() {
		ray1 = null;
		ray2 = null;
		u1 = 0.0;
		u2 = 0.0;

		return this;
	}

	inline function copy_from(other:RayIntersection) {
		ray1 = other.ray1;
		ray2 = other.ray2;
		u1 = other.u1;
		u2 = other.u2;
	}

	inline function clone() {
		var _clone = new RayIntersection();

		_clone.copy_from(this);

		return _clone;
	}
}
