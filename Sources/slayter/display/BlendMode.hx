package slayter.display;

import kha.graphics4.BlendingOperation;
import kha.Shaders;
import kha.graphics5_.VertexData;
import kha.graphics5_.VertexStructure;
import kha.graphics4.PipelineState;

class BlendMode {
	public static var Normal(get, null):PipelineState;
	public static var Add(get, null):PipelineState;
	public static var Multiply(get, null):PipelineState;
	public static var Screen(get, null):PipelineState;
	public static var Subtract(get, null):PipelineState;
	public static var Erase(get, null):PipelineState;
	public static var Mask(get, null):PipelineState;
	public static var Below(get, null):PipelineState;
	public static var Darken(get, null):PipelineState;
	public static var Lighten(get, null):PipelineState;

	private static function init() {
		if (!_hasInitialized) {
			_structure = new VertexStructure();
			_structure.add("vertexPosition", VertexData.Float32_3X);
			_structure.add("vertexUV", VertexData.Float32_2X);
			_structure.add("vertexColor", VertexData.UInt8_4X_Normalized);
			_hasInitialized = true;
		}
	}

	private static function createPipe():PipelineState {
		var pipe = new PipelineState();
		pipe.inputLayout = [_structure];
		pipe.vertexShader = Shaders.painter_image_vert;
		pipe.fragmentShader = Shaders.painter_image_frag;
		return pipe;
	}

	private static function get_Normal():PipelineState {
		if (_normal == null) {
			init();
			_normal = createPipe();
			_normal.blendSource = BlendOne;
			_normal.blendDestination = InverseSourceAlpha;
			_normal.alphaBlendSource = BlendOne;
			_normal.alphaBlendDestination = InverseSourceAlpha;
			_normal.alphaBlendOperation = BlendingOperation.Add;
			_normal.compile();
		}
		return _normal;
	}

	private static function get_Add():PipelineState {
		if (_add == null) {
			init();
			_add = createPipe();
			_add.blendSource = BlendOne;
			_add.blendDestination = BlendOne;
			_add.alphaBlendSource = BlendOne;
			_add.alphaBlendDestination = BlendOne;
			_add.alphaBlendOperation = BlendingOperation.Add;
			_add.compile();
		}
		return _add;
	}

	private static function get_Multiply():PipelineState {
		if (_multiply == null) {
			init();
			_multiply = createPipe();
			_multiply.blendSource = DestinationColor;
			_multiply.blendDestination = InverseSourceAlpha;
			_multiply.alphaBlendSource = DestinationColor;
			_multiply.alphaBlendDestination = InverseSourceAlpha;
			_multiply.alphaBlendOperation = BlendingOperation.Add;
			_multiply.compile();
		}
		return _multiply;
	}

	private static function get_Screen():PipelineState {
		if (_screen == null) {
			init();
			_screen = createPipe();
			_screen.blendSource = BlendOne;
			_screen.blendDestination = InverseSourceColor;
			_screen.alphaBlendSource = BlendOne;
			_screen.alphaBlendDestination = InverseSourceColor;
			_screen.alphaBlendOperation = BlendingOperation.Add;
			_screen.compile();
		}
		return _screen;
	}

	private static function get_Subtract():PipelineState {
		if (_subtract == null) {
			init();
			_subtract = createPipe();
			_subtract.blendSource = BlendOne;
			_subtract.blendDestination = BlendOne;
			_subtract.alphaBlendSource = BlendOne;
			_subtract.alphaBlendDestination = BlendOne;
			_subtract.alphaBlendOperation = BlendingOperation.ReverseSubtract;
			_subtract.compile();
		}
		return _subtract;
	}

	private static function get_Erase():PipelineState {
		if (_erase == null) {
			init();
			_erase = createPipe();
			_erase.blendSource = BlendZero;
			_erase.blendDestination = InverseSourceAlpha;
			_erase.alphaBlendSource = BlendZero;
			_erase.alphaBlendDestination = InverseSourceAlpha;
			_erase.alphaBlendOperation = BlendingOperation.Add;
			_erase.compile();
		}
		return _erase;
	}

	private static function get_Mask():PipelineState {
		if (_mask == null) {
			init();
			_mask = createPipe();
			_mask.blendSource = BlendZero;
			_mask.blendDestination = SourceAlpha;
			_mask.alphaBlendSource = BlendZero;
			_mask.alphaBlendDestination = SourceAlpha;
			_mask.alphaBlendOperation = BlendingOperation.Add;
			_mask.compile();
		}
		return _mask;
	}

	private static function get_Below():PipelineState {
		if (_below == null) {
			init();
			_below = createPipe();
			_below.blendSource = InverseDestinationAlpha;
			_below.blendDestination = DestinationAlpha;
			_below.alphaBlendSource = InverseDestinationAlpha;
			_below.alphaBlendDestination = DestinationAlpha;
			_below.alphaBlendOperation = BlendingOperation.Add;
			_below.compile();
		}
		return _below;
	}

	private static function get_Darken():PipelineState {
		if (_darken == null) {
			init();
			_darken = createPipe();
			_darken.blendSource = BlendOne;
			_darken.blendDestination = BlendOne;
			_darken.alphaBlendSource = BlendOne;
			_darken.alphaBlendDestination = BlendOne;
			_darken.alphaBlendOperation = BlendingOperation.Min;
			_darken.compile();
		}
		return _darken;
	}

	private static function get_Lighten():PipelineState {
		if (_lighten == null) {
			init();
			_lighten = createPipe();
			_lighten.blendSource = BlendOne;
			_lighten.blendDestination = BlendOne;
			_lighten.alphaBlendSource = BlendOne;
			_lighten.alphaBlendDestination = BlendOne;
			_lighten.alphaBlendOperation = BlendingOperation.Max;
			_lighten.compile();
		}
		return _lighten;
	}

	private static var _hasInitialized = false;
	private static var _structure:VertexStructure;
	private static var _normal:PipelineState = null;
	private static var _add:PipelineState = null;
	private static var _multiply:PipelineState = null;
	private static var _screen:PipelineState = null;
	private static var _subtract:PipelineState = null;
	private static var _erase:PipelineState = null;
	private static var _mask:PipelineState = null;
	private static var _below:PipelineState = null;
	private static var _darken:PipelineState = null;
	private static var _lighten:PipelineState = null;
}
