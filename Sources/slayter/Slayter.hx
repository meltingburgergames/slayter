package slayter;

import kha.graphics4.PipelineState;
import kha.graphics2.Graphics;
import kha.Scheduler;
import kha.System;
import kha.Scaler;
import kha.Image;
import kha.Framebuffer;
import kha.Canvas;
import kha.graphics4.Graphics2;
import slayter.display.Sprite;

class Slayter {
	public var screenWidth:Int;
	public var screenHeight:Int;
	public var root(default, null):Sprite;

	public function new(title:String, screenWidth:Int, screenHeight:Int, onStart:Slayter->Void):Void {
		this.screenWidth = screenWidth;
		this.screenHeight = screenHeight;

		System.start({
			title: title,
			width: screenWidth,
			height: screenHeight,
			framebuffer: {samplesPerPixel: 4}
		}, function(_) {
			var lastTime:Float = -1;
			this._backbuffer = Image.createRenderTarget(screenWidth, screenHeight);
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

	private function renderSprite(sprite:Sprite, g:Graphics) {
		if (!sprite.visible || sprite.alpha <= 0) {
			return;
		}

		g.pushOpacity(g.opacity * sprite.alpha);
		sprite.updateMatrix();
		g.pushTransformation(g.transformation.multmat(sprite._matrix));

		sprite.draw(g);
		for (c in sprite.children) {
			renderSprite(c, g);
		}

		g.popTransformation();
		g.popOpacity();
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
}
