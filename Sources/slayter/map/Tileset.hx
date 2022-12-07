package slayter.map;

typedef Tileset = {
	identifier:String,
	relPath:String,
	pxWid:Int,
	pxHei:Int,
	tileGridSize:Int,
	spacing:Int,
	padding:Int,
}

class TilesetTools {
	public static inline function cWid(tileset:Tileset):Int {
		return Math.ceil(tileset.pxWid / tileset.tileGridSize);
	}

	public static inline function getAtlasX(tileset:Tileset, tileId:Int) {
		return (tileId - Std.int(tileId / cWid(tileset)) * cWid(tileset)) * tileset.tileGridSize;
	}

	/**
		Get Y pixel coordinate (in atlas image) from a specified tile ID
	**/
	public static inline function getAtlasY(tileset:Tileset, tileId:Int) {
		return Std.int(tileId / cWid(tileset)) * tileset.tileGridSize;
	}
}
