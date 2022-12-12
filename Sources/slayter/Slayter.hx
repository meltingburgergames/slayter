package slayter;

import kha.math.FastMatrix3;
import kha.graphics2.Graphics;
import kha.Scheduler;
import kha.System;
import kha.Scaler;
import kha.Image;
import kha.Framebuffer;
import slayter.display.Sprite;

using slayter.display.BlendMode.BlendModeUtil;

class Slayter {
	public var screenWidth:Int;
	public var screenHeight:Int;
	public var root(default, null):Sprite;

	public function new(title:String, screenWidth:Int, screenHeight:Int, onStart:Slayter->Void):Void {
		this.screenWidth = screenWidth;
		this.screenHeight = screenHeight;
		_identity = FastMatrix3.identity();

		System.start({
			title: title,
			width: screenWidth,
			height: screenHeight,
			framebuffer: {samplesPerPixel: 4}
		}, function(_) {
			var lastTime:Float = -1;
			this._backbuffer = Image.createRenderTarget(screenWidth, screenHeight);
			this._shaderBuffer1 = Image.createRenderTarget(screenWidth, screenHeight);
			this._shaderBuffer2 = Image.createRenderTarget(screenWidth, screenHeight);
			this.root = new Sprite();

			Scheduler.addTimeTask(function() {
				var curTime = Scheduler.time();
				if (lastTime < 0) {
					lastTime = curTime;
				} else {
					var dt = curTime - lastTime;
					update(dt);
					lastTime = curTime;
				}
			}, 0, 1 / 60);
			System.notifyOnFrames(function(frames) {
				render(frames[0]);
			});
			onStart(this);
		});
	}

	public inline function update(dt:Float):Void {
		updateSprite(root, dt);
	}

	public function render(buffer:Framebuffer):Void {
		var g = _backbuffer.g2;

		g.begin(true, 0xffcccccc);
		renderSprite(root, g);
		g.end();

		buffer.g2.begin();
		Scaler.scale(_backbuffer, buffer, System.screenRotation);
		buffer.g2.end();
	}

	public function renderSprite(sprite:Sprite, g:Graphics) {
		if (!sprite.visible || sprite.alpha <= 0) {
			return;
		}

		g.pushOpacity(g.opacity * sprite.alpha);
		sprite.updateMatrix();
		g.pushTransformation(g.transformation.multmat(sprite._matrix));

		if (sprite.pipeline != null) {
			g.end();
			_shaderBuffer1.g2.begin();
			_shaderBuffer1.g2.drawImage(_backbuffer, 0, 0);
			_shaderBuffer1.g2.end();
			g.begin(true, 0);
		}
		sprite.draw(g);
		for (c in sprite.children) {
			renderSprite(c, g);
		}
		if (sprite.pipeline != null) {
			g.end();
		}

		g.popTransformation();
		g.popOpacity();

		if (sprite.pipeline != null) {
			/**
			 * Draw _buffer1 and then start pipeline and draw renderimage
			 * then remove pipeline
			 */
			_shaderBuffer2.g2.begin();

			_shaderBuffer2.g2.drawImage(_shaderBuffer1, 0, 0);
			var p = _shaderBuffer2.g2.pipeline;
			_shaderBuffer2.g2.pipeline = sprite.pipeline;

			sprite.pipeline.setBlendMode(sprite.blendmode);
			_shaderBuffer2.g2.drawImage(_backbuffer, 0, 0);
			_shaderBuffer2.g2.pipeline = p;
			_shaderBuffer2.g2.end();

			/**
			 * Draw _buffer2 to renderimage
			 */
			g.begin();

			var t = g.transformation;
			g.transformation = _identity;
			g.drawImage(_shaderBuffer2, 0, 0);
			g.transformation = t;
		}
	}

	public static function updateSprite(sprite:Sprite, dt:Float):Void {
		sprite.update(dt);
		if (!sprite.active) {
			return;
		}
		if (!sprite._hasCalledOnStart) {
			sprite.onStart();
			sprite._hasCalledOnStart = true;
		}
		for (c in sprite.children) {
			updateSprite(c, dt);
		}
	}

	private var _backbuffer:Image;
	private var _shaderBuffer1:Image;
	private var _shaderBuffer2:Image;
	private var _identity:FastMatrix3;
}
