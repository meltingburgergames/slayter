package slayter.util;

import slayter.math.FMath;

// http://www.yaldex.com/games-programming/0672323699_ch12lev1sec11.html

/**
 * The `FuzzySet` class is a utility for working with fuzzy sets, which are sets of values with overlapping ranges.
 *
 * @param T The type of the values being stored in the fuzzy set. This type must be an enumeration value.
 *
 * @property _items An array of objects representing the values and ranges in the fuzzy set.
 * @property _scratch An object used for temporary storage during certain operations.
 */
class FuzzySet<T:EnumValue> {
	/**
	 * Constructs a new `FuzzySet` instance.
	 *
	 * @return Void
	 */
	public function new():Void {
		_items = [];
	}

	/**
	 * Adds a value and range to the fuzzy set.
	 *
	 * @param value The value to add to the fuzzy set.
	 * @param min The minimum bound of the range for the value.
	 * @param max The maximum bound of the range for the value.
	 *
	 * @return Void
	 */
	public function add(value:T, min:Float, max:Float):Void {
		_items.push({value: value, min: min, max: max});
	}

	/**
	 * Returns the minimum value in the fuzzy set that has the highest membership (degree of membership) for the given input value.
	 *
	 * @param val The input value to compare against the fuzzy set.
	 *
	 * @return The minimum value in the fuzzy set with the highest membership for the input value, or `null` if the fuzzy set is empty.
	 */
	public function min(val:Float):Null<T> {
		_scratch.value = null;
		_scratch.dom = FMath.FLOAT_MAX;
		for (item in _items) {
			var dom_ = dom(val, item);
			if (dom_ < _scratch.dom) {
				_scratch.value = item.value;
				_scratch.dom = dom_;
			}
		}
		return _scratch.value;
	}

	/**
	 * Returns the maximum value in the fuzzy set that has the highest membership (degree of membership) for the given input value.
	 *
	 * @param val The input value to compare against the fuzzy set.
	 *
	 * @return The maximum value in the fuzzy set with the highest membership for the input value, or `null` if the fuzzy set is empty.
	 */
	public function max(val):Null<T> {
		_scratch.value = null;
		_scratch.dom = FMath.FLOAT_MIN;
		for (item in _items) {
			var dom_ = dom(val, item);
			if (dom_ > _scratch.dom) {
				_scratch.value = item.value;
				_scratch.dom = dom_;
			}
		}
		return _scratch.value;
	}

	/**
	 * Calculates the membership (degree of membership) of the given input value in the given range of the fuzzy set.
	 *
	 * @param val The input value to compare against the range.
	 * @param item An object representing a value and range in the fuzzy set.
	 *
	 * @return The membership of the input value in the given range, as a float value between 0 (not a member) and 1 (full membership).
	 */
	private function dom(val:Float, item:{value:T, min:Float, max:Float}):Float {
		// in range
		if (val >= item.min && val <= item.max) {
			// compute intersection with left edge or right
			// always assume height of triangle is 1.0

			var centerPoint = (item.max + item.min) / 2;

			// compare val to center
			if (val <= centerPoint) {
				// compute intersection on left edge
				// dy/dx = 1.0/(center – left)
				var slope = 1.0 / (centerPoint - item.min);

				return (val - item.min) * slope;
			} else {
				// compute intersection on right edge
				// dy/dx = 1.0/(center - right)
				var slope = 1.0 / (centerPoint - item.max);

				return (val - item.max) * slope;
			}
		}
		// not in range
		else {
			return 0;
		}
	}

	private var _items:Array<{value:T, min:Float, max:Float}>;
	private var _scratch:{value:T, dom:Float} = {value: null, dom: FMath.FLOAT_MAX};
}
