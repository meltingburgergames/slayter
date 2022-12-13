package slayter.differ;

import slayter.differ.shapes.Shape;
import slayter.differ.data.ShapeCollision;

class CollisionManager {
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
}