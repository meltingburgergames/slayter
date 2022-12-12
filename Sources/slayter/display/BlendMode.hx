package slayter.display;

import kha.graphics4.BlendingOperation;
import kha.graphics4.BlendingFactor;
import kha.graphics4.PipelineState;

// <option selected>normal</option>
// <option>multiply</option>
// <option>screen</option>
// <option>overlay</option>
// <option>darken</option>
// <option>lighten</option>
// <option>color-dodge</option>
// <option>color-burn</option>
// <option>hard-light</option>
// <option>soft-light</option>
// <option>difference</option>
// <option>exclusion</option>
// <option>hue</option>
// <option>saturation</option>
// <option>color</option>
// <option>luminosity</option>

enum BlendMode {
	None;
	Add;
	Multiply;
	Screen;
	Erase;
	Default;
}

extern class BlendModeUtil {
	inline public static function setBlendMode(pipeline:PipelineState, mode:BlendMode):PipelineState {
		switch mode {
			case None:
				applyBlendMode(pipeline, BlendOne, BlendZero);
			case Default:
				applyBlendMode(pipeline, SourceAlpha, InverseSourceAlpha);
			case Add:
				applyBlendMode(pipeline, BlendOne, BlendOne);
			case Multiply:
				applyBlendMode(pipeline, DestinationColor, InverseSourceAlpha);
			case Screen:
				applyBlendMode(pipeline, BlendOne, InverseSourceColor);
			case Erase:
				applyBlendMode(pipeline, BlendZero, InverseSourceColor);
		}
		return pipeline;
	}

	inline public static function applyBlendMode(pipeline:PipelineState, src:BlendingFactor, dst:BlendingFactor, ?op:BlendingOperation):PipelineState {
		if (op == null) {
			op = BlendingOperation.Add;
		}

		pipeline.blendSource = src;
		pipeline.alphaBlendSource = src;
		pipeline.blendDestination = dst;
		pipeline.alphaBlendDestination = dst;
		pipeline.blendOperation = op;
		pipeline.alphaBlendOperation = op;

		return pipeline;
	}
}
