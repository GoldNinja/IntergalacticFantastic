package;

import flash.Lib;
import flixel.FlxGame;
	
class GameClass extends FlxGame
{	
	public function new()
	{
		super(800, 600, MenuState, 1, 60, 60);
	}
}
