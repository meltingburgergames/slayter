package slayter.display;

/**
 * Children ensures that children are only added and removed through
 * sprite method calls.
 */
@:forward(length, sort, iterator)
abstract Children(Array<Sprite>) {
    public function new() : Void {
        this = [];
    }

    public inline function get(index :Int) : Null<Sprite> {
        return this[index];
    }

    public inline function last() : Null<Sprite> {
        return this[this.length - 1];
    }

    @:allow(slayter.display.Sprite)
    private inline function push(c:Sprite) : Void {
        this.push(c);
    }

    @:allow(slayter.display.Sprite)
    private inline function remove(c:Sprite) : Bool {
        return this.remove(c);
    }
}