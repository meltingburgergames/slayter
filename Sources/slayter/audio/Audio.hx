package slayter.audio;

import slayter.assets.Assets;
import kha.audio1.AudioChannel;
import slayter.util.Disposable;

class Audio implements Disposable {
	public function new(path:String, loop:Bool = false):Void {
		_channel = kha.audio1.Audio.play(Assets.getSound(path), loop);
		_channel.stop();
	}

	public function play():Void {
		_channel.play();
	}

	public function pause():Void {
		_channel.pause();
	}

	public function stop():Void {
		_channel.stop();
	}

	public function dispose() {
        _channel.stop();
    }

	private var _channel:AudioChannel;
}
