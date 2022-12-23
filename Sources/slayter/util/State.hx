package slayter.util;

import kha.Storage;

/**
 * The `State` class provides a simple utility for saving and restoring state data to and from storage.
 *
 * @param T The type of the state data being saved and restored.
 *
 * @property data The state data being saved and restored.
 */
class State<T> {
	public var data:T;

	/**
	 * Constructs a new `State` instance.
	 *
	 * @return Void
	 */
	public function new():Void {}

	/**
	 * Clears the saved state data and replaces it with the provided fresh data.
	 *
	 * @param fresh The new state data to save.
	 *
	 * @return Void
	 */
	public function clear(fresh:T):Void {
		Storage.defaultFile().writeObject(fresh);
	}

	/**
	 * Saves the current state data to storage.
	 *
	 * @return Void
	 */
	public function save():Void {
		Storage.defaultFile().writeObject(data);
	}

	/**
	 * Restores the saved state data from storage, or the provided default data if no saved data is found.
	 *
	 * @param default_ The default state data to use if no saved data is found.
	 *
	 * @return Void
	 */
	public function restore(default_:T):Void {
		var obj = Storage.defaultFile().readObject();
		this.data = obj != null ? obj : default_;
	}
}
