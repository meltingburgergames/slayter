package slayter.util;

import kha.Storage;

class State<T> {
	public var data:T;

	public function new():Void {}

    public function clear(fresh :T):Void {
        Storage.defaultFile().writeObject(fresh);
    }

	public function save():Void {
        Storage.defaultFile().writeObject(data);
    }

	public function restore(default_ :T):Void {
        var obj = Storage.defaultFile().readObject();
        this.data = obj != null ? obj : default_;
    }
}
