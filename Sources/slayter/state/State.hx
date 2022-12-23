package slayter.state;

/**
 * The `State` class represents a state that can be managed by a `StateMachine`.
 * 
 * A `State` has three methods that can be overridden to provide custom behavior:
 *  - `update(dt:Float)`: Called by the `StateMachine` on each update cycle with the delta time in seconds. This can be used to update the state's internal logic.
 *  - `onStarted()`: Called by the `StateMachine` when the state is set as the active state. This can be used to perform any initialization or setup for the state.
 *  - `onEnded()`: Called by the `StateMachine` when the state is no longer the active state. This can be used to perform any cleanup or teardown for the state.
 * 
 * These methods are optional and do not need to be implemented if they are not needed for the specific use case.
 */
class State {
	/**
	 * Called by the `StateMachine` on each update cycle.
	 * 
	 * @param dt - The delta time in seconds.
	 */
	public function update(dt:Float):Void {}

	/**
	 * Called by the `StateMachine` when the state is set as the active state.
	 */
	public function onStarted():Void {}

	/**
	 * Called by the `StateMachine` when the state is no longer the active state.
	 */
	public function onEnded():Void {}
}
