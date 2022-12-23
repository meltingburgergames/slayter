package slayter.util;

import kha.input.KeyCode;

/**
 * An interface for objects that can receive keyboard input events.
 *
 * Objects implementing this interface can listen for keydown, keyup, and keypress events and respond to them appropriately.
 */
interface Keyboardable {
	/**
	 * A signal that is dispatched when a key is pressed down.
	 *
	 * The signal is passed a `KeyCode` object representing the key that was pressed.
	 */
	public var keydown(default, null):Signal1<KeyCode>;

	/**
	 * A signal that is dispatched when a key is released.
	 *
	 * The signal is passed a `KeyCode` object representing the key that was released.
	 */
	public var keyup(default, null):Signal1<KeyCode>;

	/**
	 * A signal that is dispatched when a key is pressed and released, resulting in a character being typed.
	 *
	 * The signal is passed a string representing the character that was typed.
	 */
	public var keypress(default, null):Signal1<String>;
}
