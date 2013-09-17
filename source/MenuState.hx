package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

class MenuState extends FlxState
{	private var start_text:FlxText;
	private var start_glow:Int = 0;
	
	override public function create():Void
	{
		// Set a background color
		FlxG.cameras.bgColor = 0xff131c1b;
		// Show the mouse (in case it hasn't been disabled)
		#if !FLX_NO_MOUSE
		FlxG.mouse.show();
		#end
		add(new FlxText(60, 100, 400, "Intergalactic Fantastic", 20));
		
		start_text = new FlxText(500, 440, 100, "Press Space");
		add(start_text);
		start_text.alpha = 0;
		
		FlxG.sound.playMusic("assets/music/Title.mp3", 1);
		FlxG.sound.music.autoDestroy = true;
		super.create();
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		if (FlxG.keys.justPressed.SPACE)
		{	FlxG.sound.music.fadeOut(1);	}
		
		if (FlxG.keys.justReleased.SPACE)
		{	FlxG.switchState(new IntroState());	}
		
		
		if (start_text.alpha < 1 && start_glow == 0)
		{	start_text.alpha += 0.002;	}
		
		if (start_text.alpha == 1)
		{	start_glow = 1;	}
		
		if (start_glow == 1)
		{	start_text.alpha -= 0.003;
			if (start_text.alpha < 0.65)
			{	start_glow = 2;	}
		}
		
		if (start_glow == 2)
		{	start_text.alpha += 0.008;
			if (start_text.alpha > 1.2)
			{	start_glow = 1;	}
		}
		
		super.update();
	}	
}