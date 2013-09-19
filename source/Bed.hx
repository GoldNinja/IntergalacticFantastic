package ;
/** @author Gold_Ninja */

import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.animation.FlxAnimationController;
import flixel.FlxG;


class Bed extends FlxSprite
{	
	public function new(bx:Float, by:Float):Void
	{	super(bx, by);
		
		loadGraphic("assets/images/Intro_Bed.png", true, false, 64, 32, false);
		width = 64;
		height = 32;
		
		animation.add("idle", [0], 1, false);
		
		animation.add("wake", [0, 1, 2, 3], 1, false);
		
		animation.add("gun", [4, 5, 6, 7], 4, false);
		
		animation.add("bed_open", [8, 9, 10], 2, false);
		
		animation.add("slide", [11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38], 15, false);
		
		animation.play("idle");
	}
	
	override public function destroy():Void
	{	super.destroy();	}
	
	override public function update():Void
	{	
		
		
		
		
		super.update();
	}
}









