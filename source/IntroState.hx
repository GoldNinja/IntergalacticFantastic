package;
/** @author Gold_Ninja */

import flixel.group.FlxGroup;
import flixel.util.FlxPoint;
import openfl.Assets;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.util.FlxMath;
import flixel.util.FlxTimer;



class IntroState extends FlxState
{	private var hulk_tiles:FlxTilemap;
	private var ship_f:FlxSprite;
	private var ship_b:FlxSprite;
	private var bed:Bed;
	private var door_t:FlxSprite;
	private var door_b:FlxSprite;
	private var door_t2:FlxSprite;
	private var hulk_inside:FlxSprite;		//Black sprite for inside
	private var timer:Float = 0;
	private var timerTemp:Float = 0;
	private var intro_state:Int = 0;
	private var zGroup:FlxGroup;
	private var grain1:FlxSprite;
	private var grain2:FlxSprite;
	private var grain3:FlxSprite;
	private var grainTimer:Float = 0.33;
	private var grainState:Int = 1;
	private var bg_stars:FlxBackdrop;
	
	
	override public function create():Void
	{	FlxG.cameras.bgColor = 0xff131c1b;
		
		bg_stars = new FlxBackdrop("assets/images/BG_Stars_01.png", 0.1, 1, true, false);
		add(bg_stars);
		
		hulk_inside = new FlxSprite(3628, 166, "assets/images/Intro_Inside.png");
		add(hulk_inside);
		hulk_inside.active = false;
		
		hulk_tiles = new FlxTilemap();
		hulk_tiles.loadMap(Assets.getText("assets/data/mapCSV_Intro_Hulk.csv"), "assets/images/T_Intro_Hulk.png", 64, 64);
		add(hulk_tiles);
		hulk_tiles.solid = false;
		hulk_tiles.active = false;
		
		ship_f = new FlxSprite(32, 192, "assets/images/Intro_Ship_F.png");
		add(ship_f);
		ship_f.solid = false;
		
		ship_b = new FlxSprite(0, 192, "assets/images/Intro_Ship_B.png");
		add(ship_b);
		ship_b.solid = false;
		
		ship_f.velocity.x = 120;			// Maybe something like 90? or 60?
		
		bed = new Bed(ship_f.x + 52, ship_f.y + 48);
		add(bed);
		bed.solid = false;
		
		door_t = new FlxSprite(3628, 166, "assets/images/Intro_Door_T.png");
		add(door_t);
		door_b = new FlxSprite(3628, 256, "assets/images/Intro_Door_B.png");
		add(door_b);
		
		door_t2 = new FlxSprite(3628, 550, "assets/images/Intro_Door_T.png");
		add(door_t2);
		door_t2.active = false;
		
		FlxG.camera.follow(ship_f);
		FlxG.camera.setBounds(0, 0, hulk_tiles.width, hulk_tiles.height, false);
		FlxG.camera.followLerp = 1;
		
		zGroup = new FlxGroup(20);
		add(zGroup);
		zGroup.add(door_t);
		zGroup.add(door_b);
		zGroup.add(hulk_tiles);
		zGroup.add(ship_f);
		zGroup.add(ship_b);
		zGroup.add(bed);
		
		grain1 = new FlxSprite(0, 0, "assets/images/Grain_1.png");
		grain2 = new FlxSprite(0, 0, "assets/images/Grain_2.png");
		grain3 = new FlxSprite(0, 0, "assets/images/Grain_3.png");
		add(grain1);
		add(grain2);
		add(grain3);
		grain1.scrollFactor = grain2.scrollFactor = grain3.scrollFactor = new FlxPoint(0, 0);
		//grain1.alpha = grain2.alpha = grain3.alpha = 0.2;
		grain2.visible = grain3.visible = false;
		
		
		super.create();
	}
	
	override public function update():Void
	{	timer += FlxG.elapsed;
		
		switch (intro_state) 
		{	case 0:
				if (ship_f.x > 2100)
				{	bg_stars.visible = false;
					intro_state += 1; }
					
			case 1:
				if (ship_f.x > 3679)
				{	ship_f.velocity.x = 0;
					timerTemp = timer + 1;
					intro_state += 1;	}
					
			case 2:
				if (timer > timerTemp && ship_b.x < (ship_f.x - 37))
				{	ship_b.x += 0.5;	}
				if (ship_b.x == ship_f.x - 37)
				{	timerTemp = timer + 2;
					intro_state += 1;	}
					
			case 3:
				if (timer > timerTemp)
				{	intro_state += 1;
					bed.animation.play("wake");	}
				
			case 4:
				door_t.y -= 0.5;
				door_b.y += 0.5;
				
				if (door_t.y == 90)
				{	intro_state += 1;	}
				
			case 5:
				intro_state += 1;
				bed.animation.play("gun");
				timerTemp = timer + 1.2;
				ship_f.loadGraphic("assets/images/Intro_Ship_F2.png");
				
			case 6:
				ship_f.alpha = ship_b.alpha = bed.alpha -= FlxG.elapsed / 2;
				
				if (timer > timerTemp)
				{	intro_state += 1;
					bed.animation.play("bed_open");
					timerTemp = timer + 1.2;	}
				
			case 7:
				if (timer > timerTemp)
				{	intro_state += 1;
					bed.animation.play("slide");	}
				
			case 8:
				var temp_bed = zGroup.members[5];
				var temp_f = zGroup.members[3];
				var temp_b = zGroup.members[4];
				zGroup.members[5] = zGroup.members[2];
				zGroup.members[4] = zGroup.members[1];
				zGroup.members[3] = zGroup.members[0];
				
				zGroup.members[0] = temp_f;
				zGroup.members[1] = temp_b;
				zGroup.members[2] = temp_bed;
				
				intro_state += 1;
				
			case 9:
				door_t.y += 0.5;
				door_b.y -= 0.5;
				if (door_t.y == 166)
				{	intro_state += 1;
					timerTemp = timer + 2; }
				
			case 10:
				if (timer > timerTemp)
				{	FlxG.switchState(new PlayState());	}
				
		}
		
		if (FlxG.keys.justReleased.ESCAPE)
		{	FlxG.switchState(new PlayState());	}
		
		grainTimer -= FlxG.elapsed;
		if (grainTimer < 0)
		{	grainTimer = 0.27;
			
			switch (grainState) 
			{	case 1:
					grain3.visible = false;
					grain1.visible = true;
					grainState = 2;
				case 2:
					grain1.visible = false;
					grain2.visible = true;
					grainState = 3;
				case 3:
					grain2.visible = false;
					grain3.visible = true;
					grainState = 1; 
			}
		}
		
		
		
		//trace (intro_state + " " + timerTemp + " " + timer);
		
		super.update();
		if (ship_f.velocity.x > 0)
		{	ship_b.x = ship_f.x - 66;
			bed.x = ship_f.x + 52;	}
	}
}







