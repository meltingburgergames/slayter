package slayter.util;

import kha.input.KeyCode;

interface Keyboardable {
    public var keydown (default, null):Signal1<KeyCode>;
    public var keyup (default, null):Signal1<KeyCode>;
    public var keypress (default, null):Signal1<String>;
}