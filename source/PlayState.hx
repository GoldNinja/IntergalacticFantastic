package;
/** @author Gold_Ninja */

import flixel.group.FlxGroup;
import openfl.Assets;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.util.FlxMath;

class PlayState extends FlxState
{	private var player:Player;
	private var level_floor:FlxTilemap;
	private var level_walls:FlxTilemap;
	
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
		
		//FlxG.timeScale = 0.5;
		
		super.create();
	}

	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{	super.update();
		FlxG.collide(player, level_walls);
		FlxG.collide(_bullets, level_walls);
	}	

	
	
	
	
}









