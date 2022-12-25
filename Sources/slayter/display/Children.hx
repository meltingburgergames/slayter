package slayter.display;

/**
 * An abstract class representing an array of sprites.
 *
 * @abstract
 * @class slayter.display.Children
 * @extends {Array<Sprite>}
 */
@:forward(length, sort, iterator)
abstract Children(Array<Sprite>) {
	/**
	 * Creates a new instance of the Children class.
	 *
	 * @constructor
	 */
	public function new():Void {
		this = [];
	}

	/**
	 * Returns the sprite at the specified index.
	 *
	 * @param {number} index - The index of the sprite to return.
	 * @return {Sprite|null} The sprite at the specified index, or null if the index is out of bounds.
	 */
	public inline function get(index:Int):Null<Sprite> {
		return this[index];
	}

	/**
	 * Returns the last sprite in the array.
	 *
	 * @return {Sprite|null} The last sprite in the array, or null if the array is empty.
	 */
	public inline function last():Null<Sprite> {
		return this[this.length - 1];
	}

	/**
	 * Adds a sprite to the end of the array.
	 *
	 * @param {slayter.display.Sprite} c - The sprite to add.
	 * @private
	 */
	@:allow(slayter.display.Sprite)
	private inline function push(c:Sprite):Void {
		this.push(c);
	}

	/**
	 * Removes a sprite from the array.
	 *
	 * @param {slayter.display.Sprite} c - The sprite to remove.
	 * @return {boolean} True if the sprite was found and removed, false otherwise.
	 * @private
	 */
	@:allow(slayter.display.Sprite)
	private inline function remove(c:Sprite):Bool {
		return this.remove(c);
	}
}
