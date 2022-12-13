package slayter.display;

import kha.graphics4.PipelineState;


enum BlendMode {
	Normal;
	Add;
	Multiply;
	Screen;
	Subtract;
	Erase;
	Mask;
	Below;
	Darken;
	Lighten;
}

extern class BlendModeUtil {
	inline public static function setBlendMode(pipeline:PipelineState, mode:BlendMode):PipelineState {
		switch mode {
			case Normal:
				pipeline.blendSource = BlendOne;
				pipeline.blendDestination = InverseSourceAlpha;
				pipeline.alphaBlendSource = BlendOne;
				pipeline.alphaBlendDestination = InverseSourceAlpha;
                pipeline.alphaBlendOperation = Add;
            case Add:
				pipeline.blendSource = BlendOne;
				pipeline.blendDestination = BlendOne;
				pipeline.alphaBlendSource = BlendOne;
				pipeline.alphaBlendDestination = BlendOne;
                pipeline.alphaBlendOperation = Add;
            case Multiply:
				pipeline.blendSource = DestinationColor;
				pipeline.blendDestination = InverseSourceAlpha;
				pipeline.alphaBlendSource = DestinationColor;
				pipeline.alphaBlendDestination = InverseSourceAlpha;
                pipeline.alphaBlendOperation = Add;
            case Screen:
				pipeline.blendSource = BlendOne;
				pipeline.blendDestination = InverseSourceColor;
				pipeline.alphaBlendSource = BlendOne;
				pipeline.alphaBlendDestination = InverseSourceColor;
                pipeline.alphaBlendOperation = Add;
            case Subtract:
				pipeline.blendSource = BlendOne;
				pipeline.blendDestination = BlendOne;
				pipeline.alphaBlendSource = BlendOne;
				pipeline.alphaBlendDestination = BlendOne;
                pipeline.alphaBlendOperation = ReverseSubtract;
            case Erase:
				pipeline.blendSource = BlendZero;
				pipeline.blendDestination = InverseSourceAlpha;
				pipeline.alphaBlendSource = BlendZero;
				pipeline.alphaBlendDestination = InverseSourceAlpha;
                pipeline.alphaBlendOperation = Add;
            case Mask:
				pipeline.blendSource = BlendZero;
				pipeline.blendDestination = SourceAlpha;
				pipeline.alphaBlendSource = BlendZero;
				pipeline.alphaBlendDestination = SourceAlpha;
                pipeline.alphaBlendOperation = Add;
            case Below:
				pipeline.blendSource = InverseDestinationAlpha;
				pipeline.blendDestination = DestinationAlpha;
				pipeline.alphaBlendSource = InverseDestinationAlpha;
				pipeline.alphaBlendDestination = DestinationAlpha;
                pipeline.alphaBlendOperation = Add;
            case Darken:
				pipeline.blendSource = BlendOne;
				pipeline.blendDestination = BlendOne;
				pipeline.alphaBlendSource = BlendOne;
				pipeline.alphaBlendDestination = BlendOne;
                pipeline.alphaBlendOperation = Min;
            case Lighten:
				pipeline.blendSource = BlendOne;
				pipeline.blendDestination = BlendOne;
				pipeline.alphaBlendSource = BlendOne;
				pipeline.alphaBlendDestination = BlendOne;
                pipeline.alphaBlendOperation = Max;
		}
		return pipeline;
	}
}
