package slayter.differ;

import slayter.differ.shapes.Shape;
import slayter.differ.data.ShapeCollision;

class CollisionManager {
    public static var defaultManager (get, null) : CollisionManager;

    public function new() : Void {
        this._shapes = [];
    }

    public function addShape(shape :Shape) {
        this._shapes.push(shape);
    }

    public function removeShape(shape :Shape) {
        this._shapes.remove(shape);
    }

    private var _scratch = new ShapeCollision();
    public function update() : Void {
        for(shape1 in _shapes) {
            for(shape2 in _shapes) {
                if(shape1 != shape2) {
                    var info = shape1.test(shape2, _scratch);
                    if(info != null) {
                        shape1.onShapeCollide(info);
                    }
                }
            }
        }
    }

    private var _shapes :Array<Shape>;

    private static function get_defaultManager() :CollisionManager {
        if(_defaultManager == null) {
            _defaultManager = new CollisionManager();
        }
        return _defaultManager;
    }

    private static var _defaultManager : CollisionManager = null;
}