package slayter.map;

typedef Entity = {
	var identifier:String;

	/** 
		Unique instance identifier 
	**/
	var iid:String;

	/** 
		Grid-based X coordinate 
	**/
	var cx:Int;

	/** 
		Grid-based Y coordinate
	**/
	var cy:Int;

	/** 
		Pixel-based X coordinate 
	**/
	var pixelX:Int;

	/** 
		Pixel-based Y coordinate 
	**/
	var pixelY:Int;

	/**
		Pivot X coord (0-1) 
	**/
	var pivotX:Float;

	/**
		Pivot Y coord (0-1)
	**/
	var pivotY:Float;

	/**
		Width in pixels
	**/
	var width:Int;

	/** 
		Height in pixels
	**/
	var height:Int;
}
