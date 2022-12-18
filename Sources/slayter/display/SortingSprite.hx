package slayter.display;

import kha.graphics2.Graphics;

class SortingSprite extends Sprite {

	override function draw(g:Graphics) {
		this.children.sort((a, b) -> {
			return (a.y + a.anchorY) < (b.y + b.anchorY) ? -1 : 1;
		});
	}
}
