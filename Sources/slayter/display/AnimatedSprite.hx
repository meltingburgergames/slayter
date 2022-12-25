package slayter.display;

import kha.graphics2.Graphics;

/**
 * A sprite for displaying an animated texture.
 * @param {Texture} texture - The texture to animate.
 * @param {number} width - The width of a single frame in the animation.
 * @param {number} height - The height of a single frame in the animation.
 */
class AnimatedSprite extends Sprite {
	/**
	 * The texture to animate.
	 * @type {Texture}
	 */
	public var texture:Texture;

	/**
	 * The width of the sprite.
	 * @type {number}
	 */
	public var width(default, null):Int;

	/**
	 * The height of the sprite.
	 * @type {number}
	 */
	public var height(default, null):Int;

	/**
	 * Creates a new AnimatedSprite instance.
	 * @param {Texture} texture - The texture to animate.
	 * @param {number} width - The width of a single frame in the animation.
	 * @param {number} height - The height of a single frame in the animation.
	 */
	public function new(texture:Texture, width:Int, height:Int):Void {
		super();
		this.texture = texture;
		this.width = width;
		this.height = height;
		this._framerate = 0;
		_index = 0;
		_elapsed = 0;
		_wLength = Math.floor(texture.width / width);
		_hLength = Math.floor(texture.height / height);
		_start = _loopStart = 0;
		_end = _loopEnd = _wLength * _hLength;
		_animations = new Map();
	}

	/**
	 * Adds an animation to the sprite.
	 * @param {string} name - The name of the animation.
	 * @param {number} start - The index of the first frame of the animation.
	 * @param {number} end - The index of the last frame of the animation.
	 * @param {number} framerate - The framerate of the animation, in frames per second.
	 * @param {function} [cb] - A callback function to be called when the animation finishes playing.
	 * @return {AnimatedSprite} The AnimatedSprite instance.
	 */
	public function addAnimation(name:String, start:Int, end:Int, framerate:Float, ?cb:Void->Void):AnimatedSprite {
		_animations.set(name, {
			start: start,
			end: end,
			cb: cb,
			framerate: framerate
		});
		return this;
	}

	/**
	 * Updates the callback function for an animation.
	 * @param {string} name - The name of the animation.
	 * @param {function} [cb] - The new callback function for the animation.
	 * @return {AnimatedSprite} The AnimatedSprite instance.
	 */
	public function updateCB(name:String, ?cb:Void->Void):AnimatedSprite {
		_animations.get(name).cb = cb;
		return this;
	}

	/**
	 * Sets the sprite to loop an animation.
	 * @param {string} name - The name of the animation to loop.
	 * @param {boolean} [restart=false] - Whether to restart the animation from the beginning if it is already playing.
	 * @return {AnimatedSprite} The AnimatedSprite instance.
	 */
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

	/**
	 * Plays an animation once.
	 * @param {string} name - The name of the animation to play.
	 * @return {AnimatedSprite} The AnimatedSprite instance.
	 */
	public function play(name:String):AnimatedSprite {
		var anim = _animations.get(name);
		_index = _start = anim.start;
		_framerate = anim.framerate;
		_end = anim.end;
		_cb = anim.cb;
		_elapsed = 0;
		return this;
	}

	/**
	 * Updates the sprite's animation.
	 * @param {float} dt - The elapsed time since the last update, in seconds.
	 */
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

	/**
	 * Draws the sprite on the given graphics object.
	 * @param {Graphics} g - The graphics object to draw on.
	 */
	override function draw(g:Graphics) {
		var sx = (_index % _wLength) * width;
		var sy = Math.floor(_index / _wLength) * height;
		texture.drawSubImage(g, 0, 0, sx, sy, width, height);
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
