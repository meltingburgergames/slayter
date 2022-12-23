package slayter.scene;

import kha.input.KeyCode;
import kha.input.Keyboard;
import slayter.display.Sprite;

/**
 * The `Director` class is a manager for `Scene` objects.
 * 
 * It maintains a stack of scenes and allows for adding or removing scenes from the stack. The topmost scene on the stack is considered the active scene and will receive keyboard input events.
 * 
 * The `Director` class extends the `Sprite` class and registers itself as a keyboard listener when it is added to the display list. It unregisters itself as a keyboard listener when it is removed from the display list.
 * 
 * @extends Sprite
 */
class Director extends Sprite {
	/**
	 * The active `Scene` managed by the `Director`.
	 * 
	 * This field is read-only and returns the topmost scene on the stack. It is `null` if the stack is empty.
	 */
	public var current(get, null):Scene;

	/**
	 * The list of `Scene` objects managed by the `Director`.
	 * 
	 * This field is read-only and returns the `Scene` objects in the order they are on the stack. It is an empty array if the stack is empty.
	 */
	public var scenes(get, null):Array<Scene>;

	/**
	 * Removes the active `Scene` from the `Director`.
	 * 
	 * If the active `Scene` is not `null`, its `dispose` method is called and it is removed from the display list. The next `Scene` on the stack (if any) becomes the active `Scene` and its `onShown` method is called.
	 */
	public function popScene():Void {
		// remove current scene
		if (this.current != null) {
			this.current.active = true;
			this.current.director = null;
			this.current.dispose();
		}
		// set new current scene timescale to 1
		if (this.current != null) {
			this.current.active = true;
			this.current.onShown();
		}
	}

	/**
	 * Adds a new `Scene` to the top of the `Director`'s stack.
	 * 
	 * If the active `Scene` is not `null`, its `onHidden` method is called and it is set to inactive. The specified `Scene` is added to the top of the stack and its `onShown` method is called.
	 * 
	 * @param scene - The `Scene` to add to the stack.
	 */
	public function pushScene(scene:Scene):Void {
		if (this.current != null) {
			this.current.active = false;
			this.current.onHidden();
		}
		scene.active = true;
		scene.director = this;
		this.addChild(scene);
		this.current.onShown();
	}

	/**
	 * Registers the `Director` as a keyboard listener when it is added to the display list.
	 */
	override function onAdded() {
		Keyboard.get().notify(onDown, onUp, onPress);
	}

	/**
	 * Unregisters the `Director` as a keyboard listener when it is removed from the display list.
	 */
	override function onRemoved() {
		Keyboard.get().remove(onDown, onUp, onPress);
	}

	private function onDown(key:KeyCode) {
		if (this.current != null) {
			this.current.keydown.emit(key);
		}
	}

	/**
	 * Handles a keydown event by emitting the `keydown` signal of the active `Scene`.
	 * 
	 * @param key - The `KeyCode` of the pressed key.
	 */
	private function onUp(key:KeyCode) {
		if (this.current != null) {
			this.current.keyup.emit(key);
		}
	}

	/**
	 * Handles a keypress event by emitting the `keypress` signal of the active `Scene`.
	 * 
	 * @param key - The character of the pressed key as a string.
	 */
	private function onPress(key:String) {
		if (this.current != null) {
			this.current.keypress.emit(key);
		}
	}

	/**
	 * Gets the active `Scene` managed by the `Director`.
	 * 
	 * This function returns the topmost `Scene` on the stack. It is `null` if the stack is empty.
	 * 
	 * @return The active `Scene`.
	 */
	private function get_current():Scene {
		return this.scenes[this.scenes.length - 1];
	}

	/**
	 * Gets the list of `Scene` objects managed by the `Director`.
	 * 
	 * This function returns the `Scene` objects in the order they are on the stack. It is an empty array if the stack is empty.
	 * 
	 * @return The list of `Scene` objects.
	 */
	private inline function get_scenes():Array<Scene> {
		return cast this.children;
	}
}
