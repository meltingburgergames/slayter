package slayter.util;

import slayter.math.FMath;

// http://www.yaldex.com/games-programming/0672323699_ch12lev1sec11.html

/**
 * The `FuzzySet` class is a utility for working with fuzzy sets, which are sets 
 * of values with overlapping ranges.
 *
 * @param T The type of the values being stored in the fuzzy set. This type must 
 * be an enumeration value.
 *
 * @property items An array of objects representing the values and ranges in the 
 * fuzzy set.
 */
class FuzzySet<T:EnumValue> {
	public var items(default, null):ImmutableArray<{value:T, min:Float, max:Float}>;

	/**
	 * Constructs a new `FuzzySet` instance.
	 *
	 * @return Void
	 */
	public function new():Void {
		items = new ImmutableArray();
	}

	/**
	 * Sorts the elements in the fuzzy set by the minimum bound of their ranges, 
	 * in ascending order.
	 *
	 * @param val The input value to use as the reference for sorting. The 
	 * membership (degree of membership) of each element in the fuzzy set is 
	 * calculated for this value, and the elements are sorted based on their 
	 * membership.
	 *
	 * @return Void
	 */
	public function sortByMin(val:Float) {
		items.sort((a, b) -> {
			return dom(val, a) < dom(val, b) ? 0 : 1;
		});
	}

	/**
	 * Sorts the elements in the fuzzy set by the maximum bound of their ranges, 
	 * in descending order.
	 *
	 * @param val The input value to use as the reference for sorting. The 
	 * membership (degree of membership) of each element in the fuzzy set is 
	 * calculated for this value, and the elements are sorted based on their 
	 * membership.
	 *
	 * @return Void
	 */
	public function sortByMax(val:Float) {
		items.sort((a, b) -> {
			return dom(val, a) < dom(val, b) ? 1 : 0;
		});
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
		items.push({value: value, min: min, max: max});
	}

	/**
	 * Finds the value in the fuzzy set with the minimum membership 
	 * (degree of membership) for the given input value.
	 *
	 * @param val The input value to compare against the ranges in the fuzzy set.
	 * @param ret An object to store the resulting value and its membership in 
	 * the fuzzy set.
	 *
	 * @return The `ret` object, or `null` if the fuzzy set is empty.
	 */
	public function min(val:Float, ret:{value:T, dom:Float}):Null<{value:T, dom:Float}> {
		ret.value = null;
		ret.dom = FMath.FLOAT_MAX;
		for (item in items) {
			var dom_ = dom(val, item);
			if (dom_ < ret.dom) {
				ret.value = item.value;
				ret.dom = dom_;
			}
		}
		return ret;
	}

	/**
	 * Finds the value in the fuzzy set with the maximum membership 
	 * (degree of membership) for the given input value.
	 *
	 * @param val The input value to compare against the ranges in the fuzzy set.
	 * @param ret An object to store the resulting value and its membership in 
	 * the fuzzy set.
	 *
	 * @return The `ret` object, or `null` if the fuzzy set is empty.
	 */
	public function max(val, ret:{value:T, dom:Float}):Null<{value:T, dom:Float}> {
		ret.value = null;
		ret.dom = FMath.FLOAT_MIN;
		for (item in items) {
			var dom_ = dom(val, item);
			if (dom_ > ret.dom) {
				ret.value = item.value;
				ret.dom = dom_;
			}
		}
		return ret;
	}

	/**
	 * Calculates the membership (degree of membership) of the given input value 
	 * in the given range of the fuzzy set.
	 *
	 * @param val The input value to compare against the range.
	 * @param item An object representing a value and range in the fuzzy set.
	 *
	 * @return The membership of the input value in the given range, as a float 
	 * value between 0 (not a member) and 1 (full membership).
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
}

@:forward(iterator, sort)
abstract ImmutableArray<T>(Array<T>) {
	/**
	 * Constructs a new `ImmutableArray` instance.
	 *
	 * @return Void
	 */
	public function new() {
		this = [];
	}

	/**
	 * Gets the element at the specified index in the array.
	 *
	 * @param index The index of the element to get.
	 *
	 * @return The element at the specified index.
	 */
	@:arrayAccess
	public inline function get(index:Int):T {
		return this[index];
	}

	/**
	 * Adds an element to the end of the array. This method is marked as private 
	 * and can only be accessed by classes within the `slayter.util` package.
	 *
	 * @param item The element to add to the array.
	 *
	 * @return The new length of the array.
	 */
	@:allow(slayter.util.FuzzySet)
	private inline function push(item:T):Int {
		return this.push(item);
	}
}
