package slayter.display;

import kha.graphics2.Graphics;

/**
 * A class for sorting sprites based on their y-coordinate and anchor point.
 *
 * @extends {Sprite}
 */
class SortingSprite extends Sprite {
	/**
	 * Sorts the children of this sprite based on their y-coordinate and anchor point.
	 *
	 * @param {Graphics} g - The graphics context to use for drawing.
	 */
	override function draw(g:Graphics) {
		this.children.sort((a, b) -> {
			return (a.y + a.anchorY) < (b.y + b.anchorY) ? -1 : 1;
		});
	}
}
