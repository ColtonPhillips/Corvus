package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	
	public class Star extends Entity
	{		
		[Embed(source = 'res/star.png')] private const STAR:Class;
		public var starSpriteMap:Spritemap = new Spritemap(STAR, 36, 50);
		
		public var constellation:Constellation;
		public var note:Note;
		public var count:int = 0;
		public var enabled:Boolean = false;
		public function Star(xin:int, yin:int, con:Constellation)
		{
			constellation = con;
			x = xin;
			y = yin;
			type = "star";
		
			setHitbox(20, 20, 10, 10);
			
			starSpriteMap.add("shimmer", [0, 1, 2], 4, true);
			graphic = starSpriteMap;
			starSpriteMap.centerOrigin();
			starSpriteMap.play("shimmer");
		}
		
		override public function added():void 
		{
			note = new Note();
			FP.world.add(note);
		}

		override public function update():void
		{
			super.update();
			
			// Unlock the next star, when crow hits the last star currently unlocked
			if (collide("crow", x, y) && (constellation.stars.length - 1 == constellation.stars.indexOf(this)))
			{
				constellation.addNextStar();
			}
		}
		
		override public function render():void {
			super.render();
		}
		
		public function play():void 
		{
			note.play();
		}
	}
}