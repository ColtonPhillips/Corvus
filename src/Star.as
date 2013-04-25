package
{
	import common.Assets;
	import net.flashpunk.*;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import net.flashpunk.graphics.Emitter;
	
	
	public class Star extends Entity
	{	
		public var sprite:Spritemap = new Spritemap(Assets.IMG_STAR, 36, 50);
		public var emitter:Emitter;
		private var hasExploded:Boolean = false;
		
		// REFERENCE 
		public var constellation:Constellation;
		
		public var note:Note;
		public var enabled:Boolean = false;
		
		public function Star(xin:int, yin:int, con:Constellation)
		{
			constellation = con;
			x = xin;
			y = yin;
			type = "star";
		
			setHitbox(20, 20, 10, 10);
			
			sprite.add("shimmer", [0, 1, 2], 4, true);
			graphic = sprite;
			sprite.centerOrigin();
			sprite.play("shimmer");
			(graphic as Spritemap).scale = 1.4;
			(graphic as Spritemap).smooth = true;
			(graphic as Spritemap).alpha = 0.8;
			
			emitter = new Emitter(Assets.IMG_DUST);
			emitter.relative = false;
			
			// when it's not moving
			emitter.newType('explosion', [0]);
			emitter.setMotion('explosion', 50, 300, 1, 360, 200, 5);
			FP.world.addGraphic(emitter);
		}
		
		override public function added():void 
		{
			note = new Note(x,y);
			FP.world.add(note);
		}

		override public function update():void
		{
			super.update();
			
			// Unlock the next star, when crow hits the last star currently unlocked
			if ((constellation.stars.length - 1 == constellation.stars.indexOf(this) && collide("crow", x, y)))
			{
				constellation.addNextStar();
				
				if (hasExploded) return;
				
				for (var i:int = 0; i < 500; i++) {
					emitter.emit('explosion', x, y);	
					hasExploded = true;
				}
				
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