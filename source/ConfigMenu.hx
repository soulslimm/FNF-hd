package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import io.newgrounds.NG;
import lime.app.Application;
import lime.utils.Assets;
import flixel.math.FlxMath;
import flixel.text.FlxText;

using StringTools;

class ConfigMenu extends MusicBeatState
{

	var configText:FlxText;
	var descText:FlxText;
	var configSelected:Int = 0;
	
	var offsetValue:Float;
	var accuracyType:String;
	var accuracyTypeInt:Int;
	var accuracyTypes:Array<String> = ["none", "simple", "complex"];
	var healthValue:Int;
	var healthDrainValue:Int;
	var iconValue:Bool;
	var downValue:Bool;
	var inputValue:Bool;
	var glowValue:Bool;
	
	var canChangeItems:Bool = true;

	var leftRightCount:Int = 0;
	
	var settingDesc:Array<String> = [
									"Adjust note timings.\nPress \"ENTER\" to start the offset calibration." + (FlxG.save.data.ee1?"\nHold \"SHIFT\" to force the pixel calibration.\nHold \"CTRL\" to force the normal calibration.":""), 
									"What type of accuracy calculation you want to use. Simple is just notes hit / total notes. Complex also factors in how early or late a note was.", 
									"Modifies how much Health you gain when hitting a note.",
									"Modifies how much Health you lose when missing a note.",
									"Adds low health icons for characters missing them and adds winning icons.\n[This disables modded health icons unless there is a version of the files included in the mod.]",
									"Makes notes appear from the top instead the bottom.",
									"Disables miss stun and plays miss animations for missed notes.",
									"Makes note arrows glow if they are able to be hit.\n[This disables modded note arrows unless there is a version of the files included in the mod.]"
									];


	override function create()
	{	
	
		FlxG.sound.playMusic('configurator');

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic('menuDesat.png');
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0;
		bg.setGraphicSize(Std.int(bg.width * 1.18));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		bg.color = 0xFF5C6CA5;
		add(bg);
	
		// var magenta = new FlxSprite(-80).loadGraphic('assets/images/menuBGMagenta.png');
		// magenta.scrollFactor.x = 0;
		// magenta.scrollFactor.y = 0;
		// magenta.setGraphicSize(Std.int(magenta.width * 1.18));
		// magenta.updateHitbox();
		// magenta.screenCenter();
		// magenta.visible = false;
		// magenta.antialiasing = true;
		// add(magenta);
		// magenta.scrollFactor.set();
		
		Config.reload();
		
		offsetValue = Config.offset;
		accuracyType = Config.accuracy;
		accuracyTypeInt = accuracyTypes.indexOf(Config.accuracy);
		healthValue = Std.int(Config.healthMultiplier * 10);
		healthDrainValue = Std.int(Config.healthDrainMultiplier * 10);
		iconValue = Config.betterIcons;
		downValue = Config.downscroll;
		inputValue = Config.newInput;
		glowValue = Config.noteGlow;
		
		var tex = Paths.getSparrowAtlas('FNF_main_menu_assets.png');
		var optionTitle:FlxSprite = new FlxSprite(0, 55);
		optionTitle.frames = tex;
		optionTitle.animation.addByPrefix('selected', "options white", 24);
		optionTitle.animation.play('selected');
		optionTitle.scrollFactor.set();
		optionTitle.antialiasing = true;
		optionTitle.updateHitbox();
		optionTitle.screenCenter(X);
			
		add(optionTitle);
			
		
		configText = new FlxText(0, 230, 1280, "", 58);
		configText.scrollFactor.set(0, 0);
		configText.setFormat("assets/fonts/Funkin-Bold.otf", 58, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		configText.borderSize = 3;
		configText.borderQuality = 1;
		
		descText = new FlxText(320, 620, 640, "", 20);
		descText.scrollFactor.set(0, 0);
		descText.setFormat("assets/fonts/vcr.ttf", 20, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		//descText.borderSize = 3;
		descText.borderQuality = 1;

		add(configText);
		add(descText);

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		switch(configSelected){
			case 0:
				configText.text = 
				"> NOTE OFFSET: " + offsetValue + "ms" +
				"\nACCURACY DISPLAY: " + accuracyType + 
				"\nHP GAIN MULTIPLIER: " + healthValue / 10.0 + 
				"\nHP DRAIN MULTIPLIER: " + (healthDrainValue / 10.0) + 
				"\nIMPROVED HEALTH HEADS: " + iconValue +
				"\nDOWNSCROLL: " + downValue +
				"\nNEW INPUT: " + inputValue +
				"\nNOTE GLOW: " + glowValue + "\n ";
			case 1:
				configText.text = 
				"NOTE OFFSET: " + offsetValue + "ms" +
				"\n> ACCURACY DISPLAY: " + accuracyType + 
				"\nHP GAIN MULTIPLIER: " + healthValue / 10.0 + 
				"\nHP DRAIN MULTIPLIER: " + (healthDrainValue / 10.0) + 
				"\nIMPROVED HEALTH HEADS: " + iconValue +
				"\nDOWNSCROLL: " + downValue +
				"\nNEW INPUT: " + inputValue +
				"\nNOTE GLOW: " + glowValue + "\n ";
			case 2:
				configText.text = 
				"NOTE OFFSET: " + offsetValue + "ms" +
				"\nACCURACY DISPLAY: " + accuracyType + 
				"\n> HP GAIN MULTIPLIER: " + healthValue / 10.0 + 
				"\nHP DRAIN MULTIPLIER: " + (healthDrainValue / 10.0) + 
				"\nIMPROVED HEALTH HEADS: " + iconValue +
				"\nDOWNSCROLL: " + downValue +
				"\nNEW INPUT: " + inputValue +
				"\nNOTE GLOW: " + glowValue + "\n ";
			case 3:
				configText.text = 
				"NOTE OFFSET: " + offsetValue + "ms" +
				"\nACCURACY DISPLAY: " + accuracyType + 
				"\nHP GAIN MULTIPLIER: " + healthValue / 10.0 + 
				"\n> HP DRAIN MULTIPLIER: " + (healthDrainValue / 10.0) + 
				"\nIMPROVED HEALTH HEADS: " + iconValue +
				"\nDOWNSCROLL: " + downValue +
				"\nNEW INPUT: " + inputValue +
				"\nNOTE GLOW: " + glowValue + "\n ";
			case 4:
				configText.text = 
				"NOTE OFFSET: " + offsetValue + "ms" +
				"\nACCURACY DISPLAY: " + accuracyType + 
				"\nHP GAIN MULTIPLIER: " + healthValue / 10.0 + 
				"\nHP DRAIN MULTIPLIER: " + (healthDrainValue / 10.0) + 
				"\n> IMPROVED HEALTH HEADS: " + iconValue +
				"\nDOWNSCROLL: " + downValue +
				"\nNEW INPUT: " + inputValue +
				"\nNOTE GLOW: " + glowValue + "\n ";
			case 5:
				configText.text = 
				"NOTE OFFSET: " + offsetValue + "ms" +
				"\nACCURACY DISPLAY: " + accuracyType + 
				"\nHP GAIN MULTIPLIER: " + healthValue / 10.0 + 
				"\nHP DRAIN MULTIPLIER: " + (healthDrainValue / 10.0) + 
				"\nIMPROVED HEALTH HEADS: " + iconValue +
				"\n> DOWNSCROLL: " + downValue +
				"\nNEW INPUT: " + inputValue +
				"\nNOTE GLOW: " + glowValue + "\n ";
			case 6:
				configText.text = 
				"NOTE OFFSET: " + offsetValue + "ms" +
				"\nACCURACY DISPLAY: " + accuracyType + 
				"\nHP GAIN MULTIPLIER: " + healthValue / 10.0 + 
				"\nHP DRAIN MULTIPLIER: " + (healthDrainValue / 10.0) + 
				"\nIMPROVED HEALTH HEADS: " + iconValue +
				"\nDOWNSCROLL: " + downValue +
				"\n> NEW INPUT: " + inputValue +
				"\nNOTE GLOW: " + glowValue + "\n ";
			case 7:
				configText.text = 
				"NOTE OFFSET: " + offsetValue + "ms" +
				"\nACCURACY DISPLAY: " + accuracyType + 
				"\nHP GAIN MULTIPLIER: " + healthValue / 10.0 + 
				"\nHP DRAIN MULTIPLIER: " + (healthDrainValue / 10.0) + 
				"\nIMPROVED HEALTH HEADS: " + iconValue +
				"\nDOWNSCROLL: " + downValue +
				"\nNEW INPUT: " + inputValue +
				"\n> NOTE GLOW: " + glowValue + "\n ";
		}
		
	
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if(canChangeItems){
			if (controls.UP_P)
				{
					FlxG.sound.play('scrollMenu');
					changeItem(-1);
				}

				if (controls.DOWN_P)
				{
					FlxG.sound.play('scrollMenu');
					changeItem(1);
				}
				
				switch(configSelected){
					case 0: //Offset
						if (controls.RIGHT_P)
						{
							FlxG.sound.play('scrollMenu');
							offsetValue += 1;
						}
						
						if (controls.LEFT_P)
						{
							FlxG.sound.play('scrollMenu');
							offsetValue -= 1;
						}
						
						if (controls.RIGHT)
						{
							leftRightCount++;
							
							if(leftRightCount > 64) {
								offsetValue += 1;
							}
						}
						
						if (controls.LEFT)
						{
							leftRightCount++;
							
							if(leftRightCount > 64) {
								offsetValue -= 1;
							}
						}
						
						if(!controls.RIGHT && !controls.LEFT)
						{
							leftRightCount = 0;
						}

						if(FlxG.keys.justPressed.ENTER){
							FlxG.sound.music.fadeOut(0.3);
							Config.write(offsetValue, accuracyType, healthValue / 10.0, healthDrainValue / 10.0, iconValue, downValue, inputValue, glowValue);
							AutoOffsetState.forceEasterEgg = FlxG.keys.pressed.SHIFT ? 1 : (FlxG.keys.pressed.CONTROL ? -1 : 0);
							FlxG.switchState(new AutoOffsetState());
						}
						
					case 1: //Accuracy
						if (controls.RIGHT_P)
							{
								FlxG.sound.play('scrollMenu');
								accuracyTypeInt += 1;
							}
							
							if (controls.LEFT_P)
							{
								FlxG.sound.play('scrollMenu');
								accuracyTypeInt -= 1;
							}
							
							if (accuracyTypeInt > 2)
								accuracyTypeInt = 0;
							if (accuracyTypeInt < 0)
								accuracyTypeInt = 2;
								
							accuracyType = accuracyTypes[accuracyTypeInt];
					case 2: //Health Multiplier
						if (controls.RIGHT_P)
							{
								FlxG.sound.play('scrollMenu');
								healthValue += 1;
							}
							
							if (controls.LEFT_P)
							{
								FlxG.sound.play('scrollMenu');
								healthValue -= 1;
							}
							
							if (healthValue > 50)
								healthValue = 0;
							if (healthValue < 0)
								healthValue = 50;
								
						if (controls.RIGHT)
						{
							leftRightCount++;
							
							if(leftRightCount > 64 && leftRightCount % 10 == 0) {
								healthValue += 1;
							}
						}
						
						if (controls.LEFT)
						{
							leftRightCount++;
							
							if(leftRightCount > 64 && leftRightCount % 10 == 0) {
								healthValue -= 1;
							}
						}
						
						if(!controls.RIGHT && !controls.LEFT)
						{
							leftRightCount = 0;
						}
						
						if(!controls.RIGHT && !controls.LEFT)
						{
							leftRightCount = 0;
						}
								
					case 3: //Health Drain Multiplier
						if (controls.RIGHT_P)
							{
								FlxG.sound.play('scrollMenu');
								healthDrainValue += 1;
							}
							
							if (controls.LEFT_P)
							{
								FlxG.sound.play('scrollMenu');
								healthDrainValue -= 1;
							}
							
							if (healthDrainValue > 100)
								healthDrainValue = 0;
							if (healthDrainValue < 0)
								healthDrainValue = 100;
								
						if (controls.RIGHT)
						{
							leftRightCount++;
							
							if(leftRightCount > 64 && leftRightCount % 10 == 0) {
								healthDrainValue += 1;
							}
						}
						
						if (controls.LEFT)
						{
							leftRightCount++;
							
							if(leftRightCount > 64 && leftRightCount % 10 == 0) {
								healthDrainValue -= 1;
							}
						}
						
						if(!controls.RIGHT && !controls.LEFT)
						{
							leftRightCount = 0;
						}
					case 4: //Heads
						if (controls.RIGHT_P || controls.LEFT_P) {
							FlxG.sound.play('scrollMenu');
							iconValue = !iconValue;
						}
					case 5: //Downscroll
						if (controls.RIGHT_P || controls.LEFT_P) {
							FlxG.sound.play('scrollMenu');
							downValue = !downValue;
						}
					case 6: //Miss Stun
						if (controls.RIGHT_P || controls.LEFT_P) {
							FlxG.sound.play('scrollMenu');
							inputValue = !inputValue;
						}
					case 7: //Note Glow
						if (controls.RIGHT_P || controls.LEFT_P) {
							FlxG.sound.play('scrollMenu');
							glowValue = !glowValue;
						}
			}
		}

			if (controls.BACK)
			{
				Config.write(offsetValue, accuracyType, healthValue / 10.0, healthDrainValue / 10.0, iconValue, downValue, inputValue, glowValue);
				canChangeItems = false;
				FlxG.sound.music.stop();
				FlxG.sound.play('cancelMenu');
				FlxG.switchState(new MainMenuState());
			}

			if (FlxG.keys.justPressed.R)
				{
					Config.resetSettings();
					FlxG.save.data.ee1 = false;

					canChangeItems = false;

					FlxG.sound.music.stop();
					FlxG.sound.play('cancelMenu');

					FlxG.switchState(new MainMenuState());
				}
		

		super.update(elapsed);
		
		changeItem();
		
	}

	function changeItem(huh:Int = 0)
	{
		configSelected += huh;
			
		if (configSelected > settingDesc.length - 1)
			configSelected = 0;
		if (configSelected < 0)
			configSelected = settingDesc.length - 1;
			
		descText.text = settingDesc[configSelected];
	}
}
