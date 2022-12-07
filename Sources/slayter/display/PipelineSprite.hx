package slayter.display;

import kha.math.FastMatrix3;
import kha.graphics4.PipelineState;
import kha.Image;
import kha.graphics2.Graphics;

class PipelineSprite extends Sprite {
	public var pipeline(default, null):PipelineState;
	public var pipelineChildren(default, null):Array<Sprite>;

	public function new(pipeline:PipelineState):Void {
		super();
		this.pipeline = pipeline;
		this.pipelineChildren = [];
		_identity = FastMatrix3.identity();
	}

	override function draw(renderimage:Image) {
		/**
		 * Create backbuffers if they are null
		 */
		if(_backbuffer1 == null) {
			_backbuffer1 = Image.createRenderTarget(renderimage.width, renderimage.height);
			_backbuffer2 = Image.createRenderTarget(renderimage.width, renderimage.height);
		}
		/**
		 * End renderimage g2
		 */
		renderimage.g2.end();


		/**
		 * Draw renderimage to _backbuffer1
		 */
		_backbuffer1.g2.begin();
		_backbuffer1.g2.drawImage(renderimage, 0, 0);
		_backbuffer1.g2.end();

		/**
		 * Draw children that have pipe to renderimage
		 */
		renderimage.g2.begin(true, 0);
		for (c in this.pipelineChildren) {
			Slayter.renderSprite(c, renderimage);
		}
		renderimage.g2.end();


		/**
		 * Draw _backbuffer1 and then start pipeline and draw renderimage
		 * then remove pipeline
		 */
		_backbuffer2.g2.begin();
		_backbuffer2.g2.drawImage(_backbuffer1, 0, 0);
		var p = _backbuffer2.g2.pipeline;
		_backbuffer2.g2.pipeline = this.pipeline;
		_backbuffer2.g2.drawImage(renderimage, 0, 0);
		_backbuffer2.g2.pipeline = p;
		_backbuffer2.g2.end();

		/**
		 * Draw _backbuffer2 to renderimage
		 */
		renderimage.g2.begin();
		var t = renderimage.g2.transformation;
		renderimage.g2.transformation = _identity;
		renderimage.g2.drawImage(_backbuffer2, 0, 0);
		renderimage.g2.transformation = t;
	}

	override public function update(dt:Float) {
		for (c in this.pipelineChildren) {
			Slayter.updateSprite(c, dt);
		}
	}

	override public function addChild(c:Sprite):Sprite {
		if (c.parent != null) {
			c.parent.removeChild(c);
		}
		c.parent = this;
		this.pipelineChildren.push(c);
		c.onAdded();
		return this;
	}

	override public function removeChild(c:Sprite):Sprite {
		var wasRemoved = this.pipelineChildren.remove(c);
		if (wasRemoved) {
			c.onRemoved();
			if (c._hasCalledOnStart) {
				c.onEnd();
				c._hasCalledOnStart = false;
			}
			c.parent = null;
		}
		return this;
	}

	override public function removeChildren():Void {
		while (this.pipelineChildren.length > 0) {
			this.pipelineChildren[this.pipelineChildren.length - 1].removeSelf();
		}
	}

	private static var _backbuffer1:Image = null;
	private static var _backbuffer2:Image = null;
	private var _identity:FastMatrix3;
}
