package;
/** @author Gold_Ninja */

import flixel.group.FlxGroup;
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
	private var hulk_inside:FlxSprite;		//Black sprite for inside
	
	
	override public function create():Void
	{	
		FlxG.cameras.bgColor = 0xff131c1b;
		
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
		
		ship_f.velocity.x = 120;
		
		bed = new Bed(ship_f.x + 52, ship_f.y + 48);
		add(bed);
		bed.solid = false;
		
		FlxG.camera.follow(ship_f);
		FlxG.camera.setBounds(0, 0, hulk_tiles.width, hulk_tiles.height, false);
		FlxG.camera.followLerp = 1;
		
		
		
		
		
		super.create();
	}
	
	override public function update():Void
	{	if (ship_f.x > 3679)
		{	ship_f.velocity.x = 0;	}
		
		if (ship_f.velocity.x == 0 && ship_b.x < 3642)
		{	ship_b.x += 0.5;	}
		
		if (ship_b.x > 3641)
		{	bed.animation.play("slide");	}
		
		
		
		//trace(ship_f.x);				//Makes it go real slow.
		
		super.update();
		if (ship_f.velocity.x > 0)
		{	ship_b.x = ship_f.x - 66;
			bed.x = ship_f.x + 52;	}
	}
}







