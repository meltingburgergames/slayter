package slayter.differ;

import slayter.display.Sprite;
import slayter.differ.shapes.Shape;
import slayter.differ.data.ShapeCollision;

/**
 * The `CollisionManager` class is a utility for detecting and handling collisions between `Shape` objects.
 * 
 * It maintains a list of `Shape` objects and checks for collisions between them on each update. If a collision is detected, the `onShapeCollide` method of the colliding `Shape` objects is called with a `ShapeCollision` object that provides information about the collision.
 * 
 * The `CollisionManager` extends the `Sprite` class and overrides its `update` method to perform collision detection.
 */
class CollisionManager extends Sprite {
	/**
	 * Creates a new `CollisionManager` instance.
	 */
	public function new():Void {
		super();
		this._shapes = [];
	}

	/**
	 * Adds a `Shape` object to the `CollisionManager`'s list of shapes to check for collisions.
	 * 
	 * @param shape - The `Shape` to add.
	 */
	public function addShape(shape:Shape) {
		this._shapes.push(shape);
	}

	/**
	 * Removes a `Shape` object from the `CollisionManager`'s list of shapes to check for collisions.
	 * 
	 * @param shape - The `Shape` to remove.
	 */
	public function removeShape(shape:Shape) {
		this._shapes.remove(shape);
	}

	/**
	 * A temporary object used for storing collision information during detection.
	 */
	private var _scratch = new ShapeCollision();

	/**
	 * Performs collision detection between all pairs of `Shape` objects in the `CollisionManager`'s list.
	 * 
	 * It calls the `test` method of each `Shape` with the other `Shape` as an argument, and if the `test` method returns a non-null value, the `onShapeCollide` method of the colliding `Shape` objects is called with the returned value as an argument.
	 * 
	 * @param dt - The time elapsed since the last update.
	 */
	override public function update(dt:Float):Void {
		for (shape1 in _shapes) {
			for (shape2 in _shapes) {
				if (shape1 != shape2) {
					var info = shape1.test(shape2, _scratch);
					if (info != null) {
						shape1.onShapeCollide(info);
					}
				}
			}
		}
	}

	private var _shapes:Array<Shape>;
}
