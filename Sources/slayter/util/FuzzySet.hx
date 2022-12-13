package slayter.util;

import slayter.math.FMath;

// http://www.yaldex.com/games-programming/0672323699_ch12lev1sec11.html
class FuzzySet<T:EnumValue> {
	public function new():Void {
		_items = [];
	}

	public function add(value:T, min:Float, max:Float):Void {
		_items.push({value: value, min: min, max: max});
	}

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
