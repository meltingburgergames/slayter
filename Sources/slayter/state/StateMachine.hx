package slayter.state;

import slayter.util.Disposable;

/**
 * The `StateMachine` class is a manager for state objects.
 * 
 * It stores a list of states and allows for switching between them. The active state can be updated and ended, and new states can be added or removed.
 * 
 * The `StateMachine` class implements the `Disposable` interface, so it can be cleaned up when no longer needed.
 * 
 * @extends Disposable
 */
class StateMachine implements Disposable {
	/**
	 * Creates a new `StateMachine` instance.
	 * 
	 * This initializes the internal storage for the states and sets the active state to `null`.
	 */
	public function new():Void {
		_active = {name: null, state: null};
		_states = new Map();
	}

	/**
	 * Adds a new state to the `StateMachine`.
	 * 
	 * @param name - The name of the state.
	 * @param state - The state object.
	 */
	public function addState(name:String, state:State):Void {
		_states.set(name, state);
		if (_active.name == name) {
			_active.state = state;
		}
	}

	/**
	 * Removes a state from the `StateMachine`.
	 * 
	 * If the removed state is the active state, the active state will be set to `null`.
	 * 
	 * @param name - The name of the state to remove.
	 */
	public function removeState(name:String):Void {
		_states.remove(name);
		if (_active.name == name) {
			_active.name = null;
			_active.state = null;
		}
	}

	/**
	 * Sets the active state of the `StateMachine`.
	 * 
	 * If the specified state exists, it will be set as the active state and its `onStarted` method will be called. If the specified state does not exist, the active state will be set to `null`.
	 * 
	 * If a different state was already active, its `onEnded` method will be called before the new state is activated.
	 * 
	 * @param name - The name of the state to set as active.
	 */
	public function setState(name:String):Void {
		if (_active.name != name && _active.state != null) {
			_active.state.onEnded();
		}
		var state = _states.get(name);
		if (state != null) {
			_active.name = name;
			_active.state = state;
			state.onStarted();
		} else {
			_active.name = null;
			_active.state = null;
		}
	}

	/**
	 * Updates the active state.
	 * 
	 * If there is an active state, its `update` method will be called with the specified delta time.
	 * 
	 * @param dt - The delta time in seconds.
	 */
	public function update(dt:Float):Void {
		if (_active.state != null) {
			_active.state.update(dt);
		}
	}

	/**
	 * Cleans up the `StateMachine` instance.
	 * 
	 * This method sets the active state to `null` and clears the internal list of states. It is important to call this method when the `StateMachine` is no longer needed to free up memory.
	 */
	public function dispose():Void {
		_active.name = null;
		_active.state = null;
		_states.clear();
	}

	private var _active:{name:String, state:State};
	private var _states:Map<String, State>;
}
