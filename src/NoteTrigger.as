package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.*;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class NoteTrigger extends Entity
	{
		// ASSETS
		[Embed(source = 'res/notetrigger.png')] private const NOTETRIGGER:Class;
		public var emitter:Emitter;
		
		// REFERENCES
		// TODO: Maybe don't need all refs
		public var constellation:Constellation;
		public var target:Star;
		public var stars:Vector.<Star>;
		
		public var goingForward:Boolean;
		public var nextStarIndex:int;
		public function NoteTrigger(xin:int, yin:int, targetin:Star, con:Constellation)
		{	goingForward = true;
			nextStarIndex = 0;
			
			constellation = con;
			stars = con.stars;
			
			x = xin;
			y = yin;
			
			graphic = emitter = new Emitter(NOTETRIGGER);
			emitter.relative = false;
			
			// when it's not moving
			emitter.newType('sprinkle', [0]);
			emitter.setMotion('sprinkle', 50, 10, 1, 360, 30, 1);
			
			// when it's moving
			emitter.newType('motion', [0]);
			emitter.setMotion('motion', 50, 10, 10, 360, 30, 1);
			setHitbox(10, 10, 5, 5);
			target = targetin;
		}

		override public function update():void
		{
			// If only star, play no sound, and emit fewer sparkles
			if (stars.length == 1)
			{
				var ran:int = FP.rand(2);
				if (ran == 1) 
					emitter.emit('sprinkle', x, y);
				return;
			}
			else {
				emitter.emit('motion', x, y);	
			}

			if (x == target.x && y == target.y)
			{
				target.play();
				
				// Hits last start - turn around
				if (stars.indexOf(target) == stars.length - 1 )
				{
					goingForward = false;
				}
				
				// Hits first - turn around
				if (stars.indexOf(target) == 0)
				{
					goingForward = true;
				}
				
				if (goingForward) { nextStarIndex++; }
				else { nextStarIndex--; }
				
				target = stars[nextStarIndex];
			}
			
			moveTowards(target.x, target.y, 1);
		}
		
		public function setTarget(star:Star):void
		{
			target = star;
		}
	}
}