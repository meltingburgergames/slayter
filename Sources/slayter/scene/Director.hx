package slayter.scene;

import kha.input.KeyCode;
import kha.input.Keyboard;
import slayter.display.Sprite;

class Director extends Sprite {
	public var current(get, null):Scene;
	public var scenes(get, null):Array<Scene>;

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

	override function onAdded() {
		Keyboard.get().notify(onDown, onUp, onPress);
	}

	override function onRemoved() {
		Keyboard.get().remove(onDown, onUp, onPress);
	}

	private function onDown(key:KeyCode) {
		if (this.current != null) {
			this.current.keydown.emit(key);
		}
	}

	private function onUp(key:KeyCode) {
		if (this.current != null) {
			this.current.keyup.emit(key);
		}
	}

	private function onPress(key:String) {
		if (this.current != null) {
			this.current.keypress.emit(key);
		}
	}

	private function get_current():Scene {
		return this.scenes[this.scenes.length - 1];
	}

	private inline function get_scenes():Array<Scene> {
		return cast this.children;
	}
}
