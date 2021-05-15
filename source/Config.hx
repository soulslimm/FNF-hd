package;

import flixel.FlxG;
using StringTools;

class Config
{
	
	public static var offset:Float;
	public static var accuracy:String;
	public static var healthMultiplier:Float;
	public static var healthDrainMultiplier:Float;
	public static var betterIcons:Bool;
	public static var downscroll:Bool;
	public static var newInput:Bool;
	public static var noteGlow:Bool;

	public static function resetSettings():Void{

		FlxG.save.data.offset = 0.0;
		FlxG.save.data.accuracy = "simple";
		FlxG.save.data.healthMultiplier = 1.0;
		FlxG.save.data.healthDrainMultiplier = 1.0;
		FlxG.save.data.betterIcons = true;
		FlxG.save.data.downscroll = false;
		FlxG.save.data.newInput = true;
		FlxG.save.data.noteGlow = false;

	}
	
	public static function reload():Void
	{
		offset = FlxG.save.data.offset;
		accuracy = FlxG.save.data.accuracy;
		healthMultiplier = FlxG.save.data.healthMultiplier;
		healthDrainMultiplier = FlxG.save.data.healthDrainMultiplier;
		betterIcons = FlxG.save.data.betterIcons;
		downscroll = FlxG.save.data.downscroll;
		newInput = FlxG.save.data.newInput;
		noteGlow = FlxG.save.data.noteGlow;
	}
	
	public static function write(
								offsetW:Float, 
								accuracyW:String, 
								healthMultiplierW:Float, 
								healthDrainMultiplierW:Float, 
								betterIconsW:Bool, 
								downscrollW:Bool, 
								newInputW:Bool,
								noteGlowW:Bool
								):Void
	{

		FlxG.save.data.offset = offsetW;
		FlxG.save.data.accuracy = accuracyW;
		FlxG.save.data.healthMultiplier = healthMultiplierW;
		FlxG.save.data.healthDrainMultiplier = healthDrainMultiplierW;
		FlxG.save.data.betterIcons = betterIconsW;
		FlxG.save.data.downscroll = downscrollW;
		FlxG.save.data.newInput = newInputW;
		FlxG.save.data.noteGlow = noteGlowW;
		
		reload();

	}
	
	public static function configCheck():Void
	{
		if(FlxG.save.data.offset == null)
			FlxG.save.data.offset = 0.0;
		if(FlxG.save.data.accuracy == null)
			FlxG.save.data.accuracy = "simple";
		if(FlxG.save.data.healthMultiplier == null)
			FlxG.save.data.healthMultiplier = 1.0;
		if(FlxG.save.data.healthDrainMultiplier == null)
			FlxG.save.data.healthDrainMultiplier = 1.0;
		if(FlxG.save.data.betterIcons == null)
			FlxG.save.data.betterIcons = true;
		if(FlxG.save.data.downscroll == null)
			FlxG.save.data.downscroll = false;
		if(FlxG.save.data.newInput == null)
			FlxG.save.data.newInput = true;
		if(FlxG.save.data.noteGlow == null)
			FlxG.save.data.noteGlow = false;


		if(FlxG.save.data.ee1 == null)
			FlxG.save.data.ee1 = false;
	}
	
}