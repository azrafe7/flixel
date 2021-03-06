package flixel.input;

import flixel.FlxG;
import flixel.system.debug.FlxDebugger;
import flixel.system.FlxAssets;
import flixel.system.frontEnds.PluginFrontEnd;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxStringUtil;

@:allow(flixel.input.mouse.FlxMouseButton)
@:allow(flixel.input.touch.FlxTouch)
class FlxSwipe
{
	/**
	 * Either LEFT_MOUSE, MIDDLE_MOUSE or RIGHT_MOUSE, 
	 * or the touchPointID of a FlxTouch.
	 */
	public var ID(default, null):Int;
	
	public var startPosition(default, null):FlxPoint;
	public var endPosition(default, null):FlxPoint;
	
	public var distance(get, never):Float;
	public var angle(get, never):Float;
	public var duration(get, never):Float;
	
	private var _startTimeInTicks:Float;
	private var _endTimeInTicks:Float;
	
	private function new(ID:Int, StartPosition:FlxPoint, EndPosition:FlxPoint, StartTimeInTicks:Float)
	{
		this.ID = ID;
		startPosition = StartPosition;
		endPosition = EndPosition;
		_startTimeInTicks = StartTimeInTicks;
		_endTimeInTicks = FlxG.game.ticks;
	}
	
	private inline function toString():String
	{
		return FlxStringUtil.getDebugString([
			LabelValuePair.weak("ID", ID), 
			LabelValuePair.weak("start", startPosition),
			LabelValuePair.weak("end", endPosition),
			LabelValuePair.weak("distance", distance),
			LabelValuePair.weak("angle", angle),
			LabelValuePair.weak("duration", (duration / 1000))]);
	}
	
	private inline function get_distance():Float
	{
		return FlxMath.vectorLength(startPosition.x - endPosition.x, startPosition.y - endPosition.y);
	}
	
	private inline function get_angle():Float
	{
		return FlxAngle.getAngle(startPosition, endPosition); 
	}
	
	private inline function get_duration():Float
	{
		return (_endTimeInTicks - _startTimeInTicks);
	}
}