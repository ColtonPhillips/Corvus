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
		[Embed(source = 'res/notetrigger.png')] private const NOTETRIGGER:Class;
		public var target:Star;
		public var stars:Vector.<Star>;
		public var constellation:Constellation;
		public var emitter:Emitter;
		public var goingForward:Boolean;
		public var nextStarIndex:int;
		public function NoteTrigger(xin:int, yin:int, targetin:Star, con:Constellation)
		{
			nextStarIndex = 0;
			goingForward = true;
			constellation = con;
			stars = con.stars;
			x = xin;
			y = yin;
			graphic = emitter = new Emitter(NOTETRIGGER);
			emitter.newType('sprinkle', [0]);
			emitter.setMotion('sprinkle', 50, 10, 1, 360, 30, 1);
			setHitbox(10, 10, 5, 5);
			target = targetin;
		}
		
		override public function added():void
		{
			
		}

		override public function update():void
		{
			emitter.emit('sprinkle', 0, 0);
			if (Input.pressed(Key.SPACE))
			{
				constellation.addNextStar();
			}
			
			
			// If only star, play no sound, and do nothing.
			if (stars.length == 1)
			{
				return;
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