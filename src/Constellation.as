package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
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
		
		override public function added():void 
		{
			
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
		
		public function addStarToPool(sx:int,sy:int):void
		{ 
			var star:Star = new Star(sx, sy, this)
			FP.console.log(sx, sy);
			
			starPool.push(star);
			
			// If first star add to pool and to star vectors
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
			FP.console.log('addnextstar');
			if (starPool.length == stars.length) return;
			
			stars.push(starPool[stars.length]);
			FP.world.add(stars[stars.length - 1]);
		}
	}
}
