package ;
/** @author Gold_Ninja */

import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.animation.FlxAnimationController;
import flixel.FlxG;


class Player extends FlxSprite
{	private var walk_drag:Float = 400;
	private var walk_accel:Float = 700;
	private var walk_speed:Float = 160;
	
	private var fire_rate:Float = 0.3;				//4 per second
	private var fire_timer:Float;
	private var shooting:Bool = false;
	
	private var roll_amount:Float = 0.3;
	private var roll_timer:Float;
	private var rolling:Bool = false;
	
	private var aiming:Int;				//1 = up, 2 = down, 3 = left, 4 = right
	private var aiming2:Int;
	
	private var _bullets:FlxGroup;

	public function new(px:Int, py:Int, Bullets:FlxGroup):Void
	{	super(px, py);
		maxVelocity.x = maxVelocity.y = walk_speed;
		drag.x = drag.y = walk_drag;
		
		_bullets = Bullets;
		
		loadGraphic("assets/images/Player.png", true, false, 32, 32, false);
		width = 28;
		height = 28;
		offset.x = offset.y = 2;
		
		animation.add("idle_U", [0], 1, false);
		animation.add("idle_D", [4], 1, false);
		animation.add("idle_L", [8], 1, false);
		animation.add("idle_R", [12], 1, false);
		
		animation.add("walk_U", [3, 0, 1, 2], 6, false);
		animation.add("walk_D", [7, 4, 5, 6], 6, false);
		animation.add("walk_L", [11, 8, 9, 10], 6, false);
		animation.add("walk_R", [15, 12, 13, 14], 6, false);
		
		animation.add("idle_UL", [16], 1, false);
		animation.add("idle_UR", [20], 1, false);
		animation.add("idle_DR", [24], 1, false);
		animation.add("idle_DL", [28], 1, false);
		
		animation.add("walk_UL", [16, 17, 18, 19], 6, false);		//Need to adjust the order to make the player step correctly
		animation.add("walk_UR", [20, 21, 22, 23], 6, false);
		animation.add("walk_DR", [24, 25, 26, 27], 6, false);
		animation.add("walk_DL", [28, 29, 30, 31], 6, false);
		
		
		
		animation.play("idle_U");
		aiming = 0;
		
		roll_timer = roll_amount;
		fire_timer = fire_rate;
	}
	
	override public function destroy():Void
	{	_bullets = null;
		super.destroy();
	}
	
	override public function update():Void
	{	acceleration.x = acceleration.y = 0;
		
		if (velocity.x == 0 && velocity.y == 0)
		{	if (aiming2 == 0)
			{	switch (aiming)
				{	case 1:
						animation.play("idle_U");
					case 2:
						animation.play("idle_D");
					case 3:
						animation.play("idle_L");
					case 4:
						animation.play("idle_R");
					case 5:
						animation.play("idle_UL");
					case 6:
						animation.play("idle_UR");
					case 7:
						animation.play("idle_DR");
					case 8:
						animation.play("idle_DL");
				}
			}
			else
			{	aiming = aiming2;
				switch (aiming2)
				{	case 1:
						animation.play("idle_U");
					case 2:
						animation.play("idle_D");
					case 3:
						animation.play("idle_L");
					case 4:
						animation.play("idle_R");
					case 5:
						animation.play("idle_UL");
					case 6:
						animation.play("idle_UR");
					case 7:
						animation.play("idle_DR");
					case 8:
						animation.play("idle_DL");

				}
			}
		}
/*		if (FlxG.keys.justReleased.UP)
		{	play("idle_U");	}
		if (FlxG.keys.justReleased.DOWN)
		{	play("idle_D");	}
		if (FlxG.keys.justReleased.LEFT)
		{	play("idle_L");	}
		if (FlxG.keys.justReleased.RIGHT)
		{	play("idle_R");	}
*/	
		if (FlxG.keys.pressed.UP)
		{	if (aiming2 == 0)
			{	animation.play("walk_U");	}
			else
			{	switch (aiming2) 
				{	case 1:
						animation.play("walk_U");
					case 2:
						animation.play("walk_D");
					case 3:
						animation.play("walk_L");
					case 4:
						animation.play("walk_R");
					case 5:
						animation.play("walk_UL");
					case 6:
						animation.play("walk_UR");
					case 7:
						animation.play("walk_DR");
					case 8:
						animation.play("walk_DL");
				}
			}
		}
		else if (FlxG.keys.pressed.DOWN)
		{	if (aiming2 == 0)
			{	animation.play("walk_D");	}
			else
			{	switch (aiming2) 
				{	case 1:
						animation.play("walk_U");
					case 2:
						animation.play("walk_D");
					case 3:
						animation.play("walk_L");
					case 4:
						animation.play("walk_R");
					case 5:
						animation.play("walk_UL");
					case 6:
						animation.play("walk_UR");
					case 7:
						animation.play("walk_DR");
					case 8:
						animation.play("walk_DL");
				}
			}
		}
		else if (FlxG.keys.pressed.LEFT)
		{	if (aiming2 == 0)
			{	animation.play("walk_L");	}
			else
			{	switch (aiming2) 
				{	case 1:
						animation.play("walk_U");
					case 2:
						animation.play("walk_D");
					case 3:
						animation.play("walk_L");
					case 4:
						animation.play("walk_R");
					case 5:
						animation.play("walk_UL");
					case 6:
						animation.play("walk_UR");
					case 7:
						animation.play("walk_DR");
					case 8:
						animation.play("walk_DL");
				}
			}
		}
		else if (FlxG.keys.pressed.RIGHT)
		{	if (aiming2 == 0)
			{	animation.play("walk_R");	}
			else
			{	switch (aiming2) 
				{	case 1:
						animation.play("walk_U");
					case 2:
						animation.play("walk_D");
					case 3:
						animation.play("walk_L");
					case 4:
						animation.play("walk_R");
					case 5:
						animation.play("walk_UL");
					case 6:
						animation.play("walk_UR");
					case 7:
						animation.play("walk_DR");
					case 8:
						animation.play("walk_DL");
				}
			}
		}
		
		if (FlxG.keys.pressed.UP && !FlxG.keys.pressed.DOWN)
		{	acceleration.y = - walk_accel;
			aiming = 1;	}
		else if (FlxG.keys.pressed.DOWN && !FlxG.keys.pressed.UP)
		{	acceleration.y = walk_accel;
			aiming = 2;	}
		else if (FlxG.keys.pressed.UP && FlxG.keys.pressed.DOWN)
		{	if (aiming2 != 0)
			{	switch (aiming2) 
				{	case 1:
						animation.play("idle_U");
					case 2:
						animation.play("idle_D");
					case 3:
						animation.play("idle_L");
					case 4:
						animation.play("idle_R");
					case 5:
						animation.play("idle_UL");
					case 6:
						animation.play("idle_UR");
					case 7:
						animation.play("idle_DR");
					case 8:
						animation.play("idle_DL");
				}
			}
			else
			{	animation.play("idle_D");	}
		}
		
		if (FlxG.keys.pressed.LEFT && !FlxG.keys.pressed.RIGHT)
		{	acceleration.x = - walk_accel;
			aiming = 3;	}
		else if (FlxG.keys.pressed.RIGHT && !FlxG.keys.pressed.LEFT)
		{	acceleration.x = walk_accel;
			aiming = 4;	}
		else if (FlxG.keys.pressed.LEFT && FlxG.keys.pressed.RIGHT)
		{	if (aiming2 != 0)
			{	switch (aiming2) 
				{	case 1:
						animation.play("idle_U");
					case 2:
						animation.play("idle_D");
					case 3:
						animation.play("idle_L");
					case 4:
						animation.play("idle_R");
					case 5:
						animation.play("idle_UL");
					case 6:
						animation.play("idle_UR");
					case 7:
						animation.play("idle_DR");
					case 8:
						animation.play("idle_DL");
				}
			}
			else
			{	animation.play("idle_D");	}
		}
		
		
		//*******************************************
		//ROLLING									*
		//*******************************************

		if (FlxG.keys.justPressed.SPACE)			//Make it justReleased and have some kind of charge???
		{	if (FlxG.keys.pressed.UP || FlxG.keys.pressed.DOWN)
			{	maxVelocity.y = walk_speed * 2;
				velocity.y = velocity.y * 2;
				rolling = true; }
			if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.RIGHT)
			{	maxVelocity.x = walk_speed * 2;
				velocity.x = velocity.x * 2;
				rolling = true;	}
		}
		
		if (rolling)
		{	roll_timer -= FlxG.elapsed;	}
		if (roll_timer <= 0 && rolling)
		{	maxVelocity.x = maxVelocity.y = walk_speed;
			rolling = false;
			roll_timer = roll_amount;	}
		
		
		//*******************************************
		//SHOOTING									*
		//*******************************************
		
		
		if (FlxG.keys.justPressed.X)
		{	shooting = true;
			aiming2 = aiming;	}
		
		if (FlxG.keys.pressed.X)
		{	if (fire_timer == fire_rate)
			{	getMidpoint(_point);
				cast(_bullets.recycle(Bullet), Bullet).shoot(_point, aiming2);
			}
			
			fire_timer -= FlxG.elapsed;
			if (fire_timer < 0)
			{	fire_timer = fire_rate;	}
		}
		
		if (FlxG.keys.justReleased.X)
		{	shooting = false;
			aiming2 = 0;
			fire_timer = fire_rate;	}
		
		
		super.update();
		
	}
	

	
	
}









