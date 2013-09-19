package ;
/** @author Gold_Ninja */

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxPoint;
import flixel.animation.FlxAnimationController;

class Bullet extends FlxSprite
{	private var speed:Int = 600;
	private var killTimer:Float = 2;

	public function new():Void
	{	super();
		loadGraphic("assets/images/Bullet.png", true, false, 6, 6, false);
		
		animation.add("Up", [0, 1], 8, true);
		animation.add("Down", [0, 2], 8, true);
		animation.add("Left", [3, 4], 8, true);
		animation.add("Right", [3, 5], 8, true);
		
	}
	
	override public function update():Void
	{	killTimer -= FlxG.elapsed;
		if (killTimer < 0)
		{	exists = false;	}
		
		if (touching != 0)
		{	exists = false;	}
		
		super.update();
	}
	
	override public function kill():Void
	{	if (!alive)
		{	return;	}
		velocity.x = velocity.y = 0;
		solid = false;
	}
	
	public function shoot(Location:FlxPoint, aim:Int):Void
	{	width = height = 6;
		offset.x = offset.y = 0;
		switch (aim) 
		{	case 1:
				super.reset((Location.x - width / 2) + 5, Location.y - height / 2);
				animation.play("Up");
				velocity.y = -speed;
				width = 2;
				offset.x = 2;
			case 2:
				super.reset((Location.x - width / 2) - 1, Location.y - height / 2);
				animation.play("Down");
				velocity.y = speed;
				width = 2;
				offset.x = 2;
			case 3:
				super.reset(Location.x - width / 2, (Location.y - height / 2) - 1);
				animation.play("Left");
				velocity.x = -speed;
				height = 2;
				offset.y = 2;
			case 4:
				super.reset(Location.x - width / 2, (Location.y - height / 2) + 5);
				animation.play("Right");
				velocity.x = speed;
				height = 2;
				offset.y = 2;
		}
		
		killTimer = 5;
		solid = true;
		
	
	}
	
	
}











