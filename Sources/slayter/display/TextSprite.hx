package slayter.display;

import kha.Color;
import kha.Font;
import kha.graphics2.Graphics;

class TextSprite extends Sprite {
	public var text(default, set):String;
	public var size(default, set):Int;
	public var font(default, set):Font;
	public var color:Int;
	public var wrapWidth(default, set):Float;

	public var width(get, null):Float;
	public var height(get, null):Float;

	public function new(text:String, size:Int, font:Font):Void {
		super();
		this.text = text;
		this.size = size;
		this.font = font;
		this.color = Color.Black;
		this.wrapWidth = -1;
		_hasInitialized = true;
		setDims();
	}

	override function draw(g:Graphics) {
		var oldColor = g.color;
		g.fontSize = size;
		g.font = font;
		g.color = color;
		if (wrapWidth > 0) {
			var y = 0.0;
			var height = font.height(size);
			for (line in _textSplit) {
				g.drawString(line, 0, y);
				y += height;
			}
		} else {
			g.drawString(text, 0, 0);
		}
		g.color = oldColor;
	}

	public function getWidth():Float {
		return font.width(size, text);
	}

	public function getHeight():Float {
		return font.height(size);
	}

	private function set_text(text:String):String {
		this.text = text;
		wrapText();
		return this.text;
	}

	private function set_wrapWidth(wrapWidth:Float):Float {
		this.wrapWidth = wrapWidth;
		wrapText();
		return this.wrapWidth;
	}

	private function set_size(size:Int):Int {
		this.size = size;
		wrapText();
		return this.size;
	}

	private function set_font(font:Font):Font {
		this.font = font;
		wrapText();
		return this.font;
	}

	private function wrapText():Void {
		if (wrapWidth > 0 && _hasInitialized) {
			var textSplit = this.text.split(" ");
			var cur = textSplit[0];
			var next = "";
			var renderedLast = true;
			_textSplit.resize(0);
			for (i in 1...textSplit.length) {
				var word = textSplit[i];
				next = cur + " " + word;
				if (font.width(size, next) > wrapWidth) {
					_textSplit.push(cur);
					cur = word;
					renderedLast = false;
				} else {
					cur = next;
					renderedLast = i != textSplit.length - 1;
				}
			}
			if (!renderedLast) {
				_textSplit.push(cur);
			}
		}
		setDims();
	}

	private function setDims() : Void {
		if(wrapWidth > 0) {
			_height = font.height(size) * _textSplit.length;
			var w = 0.0;
			for(line in _textSplit) {
				var w_ = font.width(size, line);
				if(w_ > w) {
					w = w_;
				}
			}
			_width = w;
		}
		else {

		}
	}

	private function get_width() : Float {
		return _width;
	}

	private function get_height() : Float {
		return _height;
	}

	private var _textSplit:Array<String> = [];
	private var _hasInitialized:Bool = false;
	private var _width :Float = 0;
	private var _height :Float = 0;
}
