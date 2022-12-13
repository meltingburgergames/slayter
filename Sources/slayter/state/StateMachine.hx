package slayter.state;

import slayter.util.Disposable;

class StateMachine implements Disposable {
	public function new():Void {
		_active = {name: null, state: null};
		_states = new Map();
	}

	public function addState(name:String, state:State):Void {
		_states.set(name, state);
		if (_active.name == name) {
			_active.state = state;
		}
	}

	public function removeState(name:String):Void {
		_states.remove(name);
		if (_active.name == name) {
			_active.name = null;
			_active.state = null;
		}
	}

    public function setState(name :String): Void {
        if(_active.name != name && _active.state != null) {
            _active.state.onEnded();
        }
        var state = _states.get(name);
        if(state != null) {
            _active.name = name;
            _active.state = state;
            state.onStarted();
        }
        else {
            _active.name = null;
            _active.state = null;
        }
    }

    public function update(dt :Float) : Void {
        if(_active.state != null) {
            _active.state.update(dt);
        }
    }

	public function dispose():Void {
		_active.name = null;
		_active.state = null;
		_states.clear();
	}

	private var _active:{name:String, state:State};
	private var _states:Map<String, State>;
}
