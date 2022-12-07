package slayter.scene;

import slayter.util.Keyboardable;
import kha.input.KeyCode;
import slayter.util.Signal1;
import slayter.display.Sprite;

class Scene extends Sprite implements Keyboardable {
    @:allow(slayter.scene)
    public var director (default, null):Director;
    public var keydown (default, null):Signal1<KeyCode> = new Signal1();
    public var keyup (default, null):Signal1<KeyCode> = new Signal1();
    public var keypress (default, null):Signal1<String> = new Signal1();

    public function onShown() : Void {}
    public function onHidden() : Void {}
}