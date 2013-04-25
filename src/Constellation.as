package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Draw;
	
	public class Constellation extends Entity
	{
		public var stars:Vector.<Star>;
		public var starPool:Vector.<Star>;
		public var noteTrigger:NoteTrigger;
		
		public function Constellation(xin:int, yin:int)
		{
			x = xin;
			y = yin;
			starPool = new Vector.<Star>();
			stars = new Vector.<Star>();
		}

		override public function update():void
		{
			super.update();
		}
		
		override public function render():void
		{
			// Draw constellation when all of them are unlocked
			if (starPool.length == stars.length)
			{
				for (var i:int = 0; i < stars.length - 1; i++)
				{
					Draw.linePlus(stars[i].x, stars[i].y, stars[i + 1].x, stars[i + 1].y, 0xFFFFF, 0.4,2); 
				}
			}
		}
		
		// Pregenerate placement for stars before "shining" them
		public function addStarToPool(sx:int,sy:int):void
		{ 
			var star:Star = new Star(sx, sy, this)
			
			starPool.push(star);
			
			// If first star, put it in the world
			if (stars.length == 0)
			{
				stars.push(star);
				FP.world.add(star);
				noteTrigger = new NoteTrigger(stars[0].x, stars[0].y, stars[0], this);
				FP.world.add(noteTrigger);
			}
			
		}
		
		public function addNextStar():void
		{
			if (starPool.length == stars.length) { 
				// last stars are shit
				(stars[stars.length - 1].graphic as Spritemap).alpha = 0.8;
				(stars[stars.length - 1].graphic as Spritemap).scale = 0.7;
				return;
			}
			
			stars.push(starPool[stars.length]);
			FP.world.add(stars[stars.length - 1]);
			
			// make latest star more vibrant!
			(stars[stars.length - 1].graphic as Spritemap).alpha = 1;
			(stars[stars.length - 1].graphic as Spritemap).scale = 1;
			
			// last stars are shit
			(stars[stars.length - 2].graphic as Spritemap).alpha = 0.8;
			(stars[stars.length - 2].graphic as Spritemap).scale = 0.7;
		}
	}
}
