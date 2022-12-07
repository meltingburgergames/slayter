package slayter.map;

import slayter.map.Tile.AutoTile;

enum LayerType {
    IntGrid(tilesetIndex:Int, autoLayerTiles:Array<AutoTile>);
    Entities(entityInstances :Array<Entity>);
}

typedef Layer = {
	identifier:String,
	iid:String,
	levelId:Int,
	layerDefUid:Int,
	visible:Bool,
	type: LayerType,
}
