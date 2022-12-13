package slayter.state;

interface State {
	function update(dt:Float):Void;
	function onStarted():Void;
	function onEnded():Void;
}
