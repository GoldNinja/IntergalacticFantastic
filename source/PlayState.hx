package;
/** @author Gold_Ninja */

import flixel.group.FlxGroup;
import openfl.Assets;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;

class PlayState extends FlxState
{	private var player:Player;
	private var level_floor:FlxTilemap;
	private var level_walls:FlxTilemap;
	
	private var grain1:FlxSprite;
	private var grain2:FlxSprite;
	private var grain3:FlxSprite;
	private var grainTimer:Float = 0.33;
	private var grainState:Int = 1;

	
	private var _bullets:FlxGroup;
	
	override public function create():Void
	{
		FlxG.cameras.bgColor = 0xff131c1b;
		#if !FLX_NO_MOUSE
		FlxG.mouse.show();
		#end
		
		level_floor = new FlxTilemap();
		level_floor.loadMap(Assets.getText("assets/data/mapCSV_Test_Floor.csv"), "assets/images/T_Floor.png", 32, 32, 0, 0, 1, 100);
		add(level_floor);
		level_floor.solid = false;
		level_floor.active = false;
		
		level_walls = new FlxTilemap();
		level_walls.loadMap(Assets.getText("assets/data/mapCSV_Test_Walls.csv"), "assets/images/T_Walls.png", 32, 32, 0, 0, 1, 1);
		add(level_walls);
		level_walls.active = false;			//REMEMBER THIS. IT WILL PROBABLY BREAK SOMETHING DOWN THE LINE.
		
		_bullets = new FlxGroup();
		_bullets.maxSize = 30;
		add(_bullets);
		
		player = new Player(64, 640, _bullets);
		add(player);
		
		FlxG.camera.setBounds(0, 0, level_floor.width, level_floor.height, true);
		FlxG.camera.follow(player);
		FlxG.camera.deadzone.height = 70;
		
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

	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{	grainTimer -= FlxG.elapsed;
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
		
		
		super.update();
		FlxG.collide(player, level_walls);
		FlxG.collide(_bullets, level_walls);
	}	

	
	
	
	
}









