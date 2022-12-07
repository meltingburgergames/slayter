package slayter.scene;

import kha.input.KeyCode;
import slayter.util.Signal1;
import slayter.display.Sprite;

class Scene extends Sprite {
    @:allow(slayter.scene)
    public var director (default, null):Director;
    public var keydown (default, null):Signal1<KeyCode> = new Signal1();
    public var keyup (default, null):Signal1<KeyCode> = new Signal1();
    public var keypress (default, null):Signal1<String> = new Signal1();
}