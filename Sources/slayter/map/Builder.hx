package slayter.map;

#if macro
import haxe.macro.Expr.Field;
import haxe.Json;
import haxe.macro.Context;
import sys.io.File;
import slayter.map.Tile.AutoTile;
import slayter.map.Layer;

class Builder {
	public static function makeLayer(data:Dynamic, tilesetIndexes:Map<Int, Int>):Layer {
		var layer = {};
		var autoLayerTiles:Array<AutoTile> = [];
		var entityInstances:Array<Entity> = [];
		var tilesetIndex = -1;
		for (field in Reflect.fields(data)) {
			switch field {
				case "iid", "levelId", "layerDefUid", "visible":
					Reflect.setField(layer, field, Reflect.getProperty(data, field));
				case "__tilesetDefUid":
					var __tilesetDefUid = Reflect.getProperty(data, field);
					tilesetIndex = __tilesetDefUid != null ? tilesetIndexes.get(__tilesetDefUid) : null;
				case "__identifier":
					Reflect.setField(layer, "identifier", Reflect.getProperty(data, field));
				case "__cWid":
					Reflect.setField(layer, "width", Reflect.getProperty(data, field));
				case "__cHei":
					Reflect.setField(layer, "height", Reflect.getProperty(data, field));
				case "autoLayerTiles":
					var tiles:Array<Dynamic> = Reflect.getProperty(data, "autoLayerTiles");
					for (tile in tiles) {
						var cx:Int = Math.floor(tile.px[0] / 16);
						var cy:Int = Math.floor(tile.px[1] / 16);
						var cWid:Int = data.__cWid;
						var index = cx + cy * cWid;
						autoLayerTiles.push({
							tileId: tile.t,
							tileInt: data.intGridCsv[index],
							flips: tile.f,
							renderX: tile.px[0],
							renderY: tile.px[1],
						});
					}
				case "entityInstances":
					var entities:Array<Dynamic> = Reflect.getProperty(data, "entityInstances");
					for (entity in entities) {
						entityInstances.push({
							identifier: entity.__identifier,
							iid: entity.iid,
							cx: entity.__grid[0],
							cy: entity.__grid[1],
							pixelX: entity.px[0],
							pixelY: entity.px[1],
							pivotX: entity.__pivot != null ? entity.__pivot[0] : null,
							pivotY: entity.__pivot != null ? entity.__pivot[1] : null,
							width: entity.width,
							height: entity.height,
						});
					}
			};
		}
		switch data.__type {
			case "Entities":
				Reflect.setField(layer, "type", Entities(entityInstances));
			case "IntGrid":
				Reflect.setField(layer, "type", IntGrid(tilesetIndex, autoLayerTiles));
		}
		return cast layer;
	}

	public static function makeLevel(data:Dynamic, tilesetIndexes:Map<Int, Int>):Level {
		var level = {layers: []};
		for (field in Reflect.fields(data)) {
			switch field {
				case "identifier", "iid", "uid", "worldX", "worldY", "worldDepth", "pxWid", "pxHei":
					Reflect.setField(level, field, Reflect.getProperty(data, field));
				case "layerInstances":
					var layerInstances:Array<Dynamic> = Reflect.getProperty(data, "layerInstances");
					var i = layerInstances.length - 1;
					for (layer in layerInstances) {
						level.layers[i--] = makeLayer(layer, tilesetIndexes);
					}
			};
		}
		return cast level;
	}

	public static function makeTileset(data:Dynamic, tilesetIndexes:Map<Int, Int>, index:Int):Tileset {
		var tileset = {};
		tilesetIndexes.set(Reflect.getProperty(data, "uid"), index);
		for (field in Reflect.fields(data)) {
			switch field {
				case "identifier", "pxWid", "pxHei", "tileGridSize", "spacing", "padding":
					Reflect.setField(tileset, field, Reflect.getProperty(data, field));
				case "relPath":
					var relPath:String = Reflect.getProperty(data, field);
					relPath = relPath.substring(0, relPath.lastIndexOf("."));
					Reflect.setField(tileset, field, relPath);
			};
		}
		return cast tileset;
	}

	public static function build(path:String) {
		var fields = Context.getBuildFields();
		var content = Json.parse(File.getContent(path));
		var project:slayter.map.Project = {appBuildId: 0, levels: [], tilesets: []};

		var tilesets:Array<Dynamic> = content.defs.tilesets;
		var tilesetIndexes = new Map<Int, Int>();
		var tilesetIndex = 0;
		for (tileset in tilesets) {
			project.tilesets.push(makeTileset(tileset, tilesetIndexes, tilesetIndex++));
		}

		var levels:Array<Dynamic> = content.levels;
		for (level in levels) {
			project.levels.push(makeLevel(level, tilesetIndexes));
		}

		var defLayers:Array<Dynamic> = content.defs.layers;
		var defLayersMap = new Map<Int, Dynamic>();
		for (defLayer in defLayers) {
			defLayersMap.set(defLayer.uid, defLayer.intGridValues);
		}

		fields.push({
			name: "project",
			doc: null,
			meta: [],
			access: [AStatic, APublic],
			kind: FVar(macro:slayter.map.Project, macro $v{project}),
			pos: Context.currentPos()
		});

		for (i in 0...project.levels.length) {
			var level = project.levels[i];
			fields.push({
				name: level.identifier,
				doc: null,
				meta: [],
				access: [AStatic, APublic],
				kind: FVar(macro:slayter.map.Level, Context.parse('project.levels[${i}]', Context.currentPos())),
				pos: Context.currentPos()
			});

			var levelData = {layers: {}};
			for (layer in level.layers) {
				var layerInfo = {id: layer.identifier, tileInts: {}};
				var defLayer:Array<Dynamic> = defLayersMap.get(layer.layerDefUid);
				for (item in defLayer) {
					Reflect.setField(layerInfo.tileInts, item.identifier, item.value);
				}
				Reflect.setField(levelData.layers, layer.identifier, layerInfo);
			}

			fields.push({
				name: level.identifier + "Info",
				doc: null,
				meta: [],
				access: [AStatic, APublic],
				kind: FVar(null, macro $v{levelData}),
				pos: Context.currentPos()
			});
		}

		return fields;
	}
}
#end
