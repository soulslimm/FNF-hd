package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	static inline final GF_DEFAULT = 'gf default';

	var box:FlxSprite;

	var curCharacter:String = '';
	var prevChar:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???/
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;
	//Cutscene shit, HAS TO LOAD ON EVERY STAGE IDIOT
	var cutsceneImage:FlxSprite;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitGF:FlxSprite;
	var nervousGF:FlxSprite;
	var sadGF:FlxSprite;
	var happyGF:FlxSprite;
	var turnGF:FlxSprite;
	var blushGF:FlxSprite;
	var confusedGF:FlxSprite;
	var portraitDAD:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		
		}
		cutsceneImage = new FlxSprite(0,0);
		add(cutsceneImage);	

		
		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);
		if (PlayState.SONG.song.toLowerCase() == 'tutorial')
		bgFade.visible = false;

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		//REPOSITIONING, NEW ANIMATIONS AND MUSIC SHIT IDIOTS
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			default:
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByPrefix('normal', 'speech bubble normal', 24, true);
				box.y += 345;
				box.x += 60;
				box.flipX = true;
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
		}

		this.dialogueList = dialogueList;

		if (!hasDialog)
			return;
		if (PlayState.SONG.song.toLowerCase() == 'senpai'
			|| PlayState.SONG.song.toLowerCase() == 'roses'
			|| PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft = new FlxSprite(-20, 40);
			portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
			portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
			portraitLeft.animation.addByIndices('idle', 'Senpai Portrait Enter', [3], "", 24, false);
			portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;
		}
		else
		{
		

			portraitDAD = new FlxSprite(170, 85);
			portraitDAD.frames = Paths.getSparrowAtlas('portraits/dadPortrait', 'preload');
			portraitDAD.animation.addByPrefix('daddefault', 'dad default', 24, false);
			portraitDAD.animation.addByPrefix('dadmic', 'dad mic', 24, false);
			portraitDAD.animation.addByPrefix('dadworried', 'dad worried', 24, false);
			portraitDAD.animation.addByPrefix('dadmoreblood', 'dad more blood', 24, false);
			portraitDAD.animation.addByPrefix('dadblood', 'dad blood', 24, false);
			portraitDAD.setGraphicSize(Std.int(portraitDAD.width * 0.3));
			portraitDAD.updateHitbox();
			portraitDAD.scrollFactor.set();
			portraitDAD.visible = false;
			add(portraitDAD);
			/*
			portraitDAD = new FlxSprite(170, 90).loadGraphic(Paths.image('dad default', 'preload'));
			portraitDAD.setGraphicSize(Std.int(portraitDAD.width * 0.3));
			portraitDAD.updateHitbox();
			portraitDAD.scrollFactor.set();
			portraitDAD.visible = false;
			add(portraitDAD);
			*/

			portraitGF = new FlxSprite(170, 85);
			portraitGF.frames = Paths.getSparrowAtlas('portraits/gfportrait', 'preload');
			portraitGF.animation.addByPrefix('gfblush', 'gf blush', 24, false);
			portraitGF.animation.addByPrefix('gfconfused', 'gf confused', 24, false);
			portraitGF.animation.addByPrefix('gfdefault', 'gf default', 24, false);
			portraitGF.animation.addByPrefix('gfnervous', 'gf nervous', 24, false);
			portraitGF.animation.addByPrefix('gfsmile', 'gf smile', 24, false);
			portraitGF.animation.addByPrefix('gftears', 'gf tears', 24, false);
			portraitGF.animation.addByPrefix('gfturn', 'gf turn', 24, false);
			portraitGF.setGraphicSize(Std.int(portraitGF.width * 0.3));
			portraitGF.updateHitbox();
			portraitGF.scrollFactor.set();
			portraitGF.visible = false;
			add(portraitGF);
			/*
			nervousGF = new FlxSprite(170, 90).loadGraphic(Paths.image('gf nervous', 'preload'));
			nervousGF.setGraphicSize(Std.int(nervousGF.width * 0.3));
			nervousGF.updateHitbox();
			nervousGF.scrollFactor.set();
			nervousGF.visible = false;
			add(nervousGF);

			confusedGF = new FlxSprite(170, 90).loadGraphic(Paths.image('gf confused', 'preload'));
			confusedGF.setGraphicSize(Std.int(confusedGF.width * 0.3));
			confusedGF.updateHitbox();
			confusedGF.scrollFactor.set();
			confusedGF.visible = false;
			add(confusedGF);

			happyGF = new FlxSprite(170, 90).loadGraphic(Paths.image('gf smile', 'preload'));
			happyGF.setGraphicSize(Std.int(happyGF.width * 0.3));
			happyGF.updateHitbox();
			happyGF.scrollFactor.set();
			happyGF.visible = false;
			add(happyGF);

			sadGF = new FlxSprite(170, 90).loadGraphic(Paths.image('gf tears', 'preload'));
			sadGF.setGraphicSize(Std.int(sadGF.width * 0.3));
			sadGF.updateHitbox();
			sadGF.scrollFactor.set();
			sadGF.visible = false;
			add(sadGF);

			blushGF = new FlxSprite(170, 90).loadGraphic(Paths.image('gf blush', 'preload'));
			blushGF.setGraphicSize(Std.int(blushGF.width * 0.3));
			blushGF.updateHitbox();
			blushGF.scrollFactor.set();
			blushGF.visible = false;
			add(blushGF);

			turnGF = new FlxSprite(170, 90).loadGraphic(Paths.image('gf turn', 'preload'));
			turnGF.setGraphicSize(Std.int(turnGF.width * 0.3));
			turnGF.updateHitbox();
			turnGF.scrollFactor.set();
			turnGF.visible = false;
			add(turnGF);
			*/
		}
		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = Paths.getSparrowAtlas('bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.animation.addByIndices('idle', 'Boyfriend portrait enter', [3], "", 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;


		switch PlayState.SONG.song.toLowerCase(){
		case 'senpai' | 'roses' | 'thorns':
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);	
		case 'tutorial':
		cutsceneImage.loadGraphic(Paths.image('tutorialcutscene'));
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * 0.9));
		box.updateHitbox();
		add(box);
	
		
		default:
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * 0.9));
		box.updateHitbox();
		add(box);
		}
	
		box.screenCenter(X);
	

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('hand_textbox', 'shared'));
		add(handSelect);

		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY && dialogueStarted == true)
		{
			remove(dialogue);

			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						
						cutsceneImage.alpha -= 1 / 5 * 0.7;
						/*
						portraitLeft.visible = false;
						portraitRight.visible = false;
						portraitGF.visible = false;
						nervousGF.visible = false;
						blushGF.visible = false;
						confusedGF.visible = false;
						happyGF.visible = false;
						turnGF.visible = false;
						sadGF.visible = false;
						portraitDAD.visible = false;
						*/
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}

		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();

		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		hideAll();

		switch (curCharacter)
		{
			case 'gf':
				portraitGF.animation.play('gf default');
				portraitGF.visible = true;
			case 'nervousGF':
				portraitGF.animation.play('gfnervous');
				portraitGF.visible = true;
			case 'blushGF':
				portraitGF.animation.play('gfblush');
				portraitGF.visible = true;
			case 'sadGF':
				portraitGF.animation.play('gftears');
				portraitGF.visible = true;
			case 'confusedGF':
				portraitGF.animation.play('gfconfused');
				portraitGF.visible = true;
			case 'happyGF':
				portraitGF.animation.play('gfsmile');
				portraitGF.visible = true;
			case 'turnGF':
				portraitGF.animation.play('gfturn');
				portraitGF.visible = true;
			case 'dad':
				portraitDAD.animation.play('daddefault');
				portraitDAD.visible = true;
			case 'worriedDad':
				portraitDAD.animation.play('dadworried');
				portraitDAD.visible = true;
			case 'dadMic':
				portraitDAD.animation.play('dadmic');
				portraitDAD.visible = true;
			case 'dadBlood':
				portraitDAD.animation.play('dadblood');
				portraitDAD.visible = true;
			case 'dadMoreblood':
				portraitDAD.animation.play('dadmoreblood');
				portraitDAD.visible = true;
			case 'idk':
				portraitLeft.visible = true;
				portraitLeft.animation.play((curCharacter != prevChar) ? "enter" : "idle");
			case 'bf':
				portraitRight.visible = true;
				portraitRight.animation.play((curCharacter != prevChar) ? "enter" : "idle");
		}

		prevChar = curCharacter;

	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
		
		
	}

	function hideAll():Void{
		/*
		portraitGF.visible = false;
		nervousGF.visible = false;
		blushGF.visible = false;
		sadGF.visible = false;
		confusedGF.visible = false;
		happyGF.visible = false;
		turnGF.visible = false;
		*/
		portraitGF.visible = false;
		portraitRight.visible = false;
		portraitDAD.visible = false;

	}
}
