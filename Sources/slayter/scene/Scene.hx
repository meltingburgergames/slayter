package slayter.scene;

import slayter.util.Keyboardable;
import kha.input.KeyCode;
import slayter.util.Signal1;
import slayter.display.Sprite;

/**
 * The `Scene` class represents a displayable element that can be managed by a `Director`.
 * 
 * It extends the `Sprite` class and implements the `Keyboardable` interface, allowing it to receive keyboard input events. It also has three signals for handling keydown, keyup, and keypress events.
 * 
 * The `Scene` class has two methods for handling its visibility: `onShown` and `onHidden`. These methods can be overridden to provide custom behavior when the scene is shown or hidden by the `Director`.
 * 
 * @extends Sprite
 * @implements Keyboardable
 */
class Scene extends Sprite implements Keyboardable {
	/**
	 * The `Director` instance that is managing this `Scene`.
	 * 
	 * This field can be set by the `Director` to allow the `Scene` to communicate with it. It is set to `null` by default.
	 */
	@:allow(slayter.scene)
	public var director(default, null):Director;

	/**
	 * A signal that is emitted when a key is pressed down.
	 * 
	 * The signal is passed the `KeyCode` of the pressed key.
	 */
	public var keydown(default, null):Signal1<KeyCode> = new Signal1();

	/**
	 * A signal that is emitted when a key is released.
	 * 
	 * The signal is passed the `KeyCode` of the released key.
	 */
	public var keyup(default, null):Signal1<KeyCode> = new Signal1();

	/**
	 * A signal that is emitted when a character key is pressed.
	 * 
	 * The signal is passed the character as a string.
	 */
	public var keypress(default, null):Signal1<String> = new Signal1();

	/**
	 * Called by the `Director` when the `Scene` is made visible.
	 * 
	 * This method can be overridden to provide custom behavior when the `Scene` is shown.
	 */
	public function onShown():Void {}

	/**
	 * Called by the `Director` when the `Scene` is hidden.
	 * 
	 * This method can be overridden to provide custom behavior when the `Scene` is hidden.
	 */
	public function onHidden():Void {}
}
