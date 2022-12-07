package slayter.display;

import kha.Image;
import kha.graphics2.Graphics;

class AnimatedSprite extends Sprite {
	public var image:Image;
	public var width(default, null):Int;
	public var height(default, null):Int;

	public function new(image:Image, width:Int, height:Int):Void {
		super();
		this.image = image;
		this.width = width;
		this.height = height;
		this._framerate = 0;
		_index = 0;
		_elapsed = 0;
		_wLength = Math.floor(image.width / width);
		_hLength = Math.floor(image.height / height);
		_start = _loopStart = 0;
		_end = _loopEnd = _wLength * _hLength;
		_animations = new Map();
	}

	public function addAnimation(name:String, start:Int, end:Int, framerate:Float, ?cb:Void->Void):AnimatedSprite {
		_animations.set(name, {
			start: start,
			end: end,
			cb: cb,
			framerate: framerate
		});
		return this;
	}

	public function updateCB(name:String, ?cb:Void->Void):AnimatedSprite {
		_animations.get(name).cb = cb;
		return this;
	}

	public function loop(name:String, restart:Bool = false):AnimatedSprite {
		if (_loopName == name && !restart) {
			return this;
		}
		_loopName = name;
		var anim = _animations.get(name);
		_index = _start = _loopStart = anim.start;
		_end = _loopEnd = anim.end;
		_framerate = _loopFramerate = anim.framerate;
		_cb = anim.cb;
		_elapsed = 0;
		return this;
	}

	public function play(name:String):AnimatedSprite {
		var anim = _animations.get(name);
		_index = _start = anim.start;
		_framerate = anim.framerate;
		_end = anim.end;
		_cb = anim.cb;
		_elapsed = 0;
		return this;
	}

	override function update(dt:Float) {
		if (_framerate == 0) {
			return;
		}
		_index = Math.floor(_elapsed / _framerate) + _start;
		if (_index > _end) {
			_elapsed = 0;
			_index = _start = _loopStart;
			_end = _loopEnd;
			_framerate = _loopFramerate;
			if (_cb != null) {
				_cb();
			}
		}
		_elapsed += dt;
	}

	override function draw(g:Graphics) {
		var sx = (_index % _wLength) * width;
		var sy = Math.floor(_index / _wLength) * height;
		g.drawSubImage(image, 0, 0, sx, sy, width, height);
	}

	private var _elapsed:Float;
	private var _framerate:Float;
	private var _loopFramerate:Float;
	private var _index:Int;
	private var _wLength:Int;
	private var _hLength:Int;
	private var _start:Int;
	private var _end:Int;
	private var _loopName:String = "";
	private var _cb:Null<Void->Void>;
	private var _loopStart:Int;
	private var _loopEnd:Int;
	private var _animations:Map<String, {
		start:Int,
		end:Int,
		framerate:Float,
		?cb:Void->Void
	}>;
}
