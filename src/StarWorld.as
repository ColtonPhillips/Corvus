package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.utils.*;
	public class StarWorld extends World
	{
		// ASSETS
		[Embed(source = 'res/notetrigger.png')] private const CURSOR:Class;
		public var cursorEmitter:Emitter;
		
		// ENTITIES
		public var constellations:Vector.<Constellation>;
		public var crow:Crow;
		public var grass:Grass;
		public var background:StarBackground;
		public var cloud:Cloud;
		public var title:Title;
		public var cursor:Entity;
		
		// MAGIC NUMBERS
		public static var CAMERASPEED:int = 5;
		
		public static var height:int = 2000;
		public static var width:int = 2000;
		
		public function StarWorld()
		{
			constellations = new Vector.<Constellation>;
			
			cursorEmitter = new Emitter(CURSOR);
			cursorEmitter.relative = false;
			cursorEmitter.newType('sprinkle', [0]);
			cursorEmitter.setMotion('sprinkle', 50, 10, 1, 360, 30, 1);
			
		}
		
		override public function begin():void 
		{
			super.begin();
			
			background = new StarBackground();
			add (background);
			
			grass = new Grass(300,height - 220);
			add (grass);
			
			grass = new Grass(400, height - 160);
			grass.graphic.scrollX = 0.2;
			add (grass);
			
			// TODO: Match Marta's buttload of vision - CP
			// Create a buttload of clouds
			for (var i:int = 0; i < 60; i++)
			{
				cloud = new Cloud();
				add(cloud);
			}
			
			crow = new Crow(width/2 + 300,height + 800);
			add (crow);
			
			
			title = new Title(width / 2 + 200, height + 200);
			add (title);
			
			cursor = addGraphic(cursorEmitter);
			
			// The first screen should have a constellation visible
			makeConstellation(1400, 2080);
			
			// set camera square in the center on the bottom
			FP.camera.x = (width / 2) - (FP.screen.width / 2);
			FP.camera.y = height - FP.screen.height;
			
			// Create X random constellations
			/*for (var j:int = 0; j < 15; j++)
			{
				makeConstellation(FP.rand(RBOUND + FP.screen.width), FP.rand(DBOUND + FP.height) );
			}*/
			
			
			// MOCK CONST SPREAD OUT BETTER
			for (var j:int = 0; j < 2000; j+= FP.screen.width) {
				
				for (var k:int = 0; k < 2000; k+= FP.screen.height) {
						makeConstellation(j, k);	makeConstellation(j + 200, k + 200);
				}
			}
		}
		
		override public function update():void 
		{
			
			super.update();
			
			// Bird flys out of grass
			bringToFront(grass);
			
			cursorEmitter.emit('sprinkle', FP.world.mouseX, FP.world.mouseY);
			cursorEmitter.emit('sprinkle', FP.world.mouseX, FP.world.mouseY);
			
			moveCameraFromMouse();
			boundCamera();
		}
		// TODO: Refactor scene so I fully understand how it's laid out, and can be used on multi platforms/res - CP
		public function makeConstellation(xin:int, yin:int):void
		{
			var constellation:Constellation = new Constellation(xin, yin);
			add (constellation);
			
			// Generate random number in the constellation 
			constellation.addStarToPool(xin, yin);
			
			// MAGIC NUMBERS
			var OFFSET:int = 600;
			var TOOCLOSE:int = 20;
			
			var lastStarX:int = xin; 
			var lastStarY:int = yin;
			var numStars:int = FP.rand(8) + 2;
			for (var i:int = 0; i < numStars; i++)
			{
				// vector offset a little from previous star
				var distanceX:int = FP.rand(OFFSET) - OFFSET / 2;
				var distanceY:int = FP.rand(OFFSET) - OFFSET / 2;
		
				// If it's too close, just kinda put it somewhere else
				if (distanceX < TOOCLOSE && distanceX > -TOOCLOSE) distanceX = 50;
				if (distanceY < TOOCLOSE && distanceY > -TOOCLOSE) distanceY = -50;
				
				// add star offset after bounding it to the screen
				lastStarX = boundToScreenX(lastStarX + distanceX);
				lastStarY = boundToScreenY(lastStarY + distanceY);
				constellation.addStarToPool(lastStarX, lastStarY);	
			}
			
		}
		// It's pretty fucking stupid that I have two functions
		public function boundToScreenX( xin:int):int
		{
			var x:int = xin;
			if (x < 10) x = 100 + FP.rand(50);
			if (x > width - 10) x = height - 100 - FP.rand(50);
			
			return x;
		}
		
		// The reason is Flashpunk doesn't use vectors for positions
		public function boundToScreenY(yin:int):int
		{
			var y:int = yin;
			if (y < 10) y = 100 + FP.rand(50);
			if (y > width - 10) y = height - 100 - FP.rand(50);
			
			return y;
		}
		
		// Nailed it. Or did I ? Fuck no I didn't! :D
		public function boundCamera():void
		{
			// TODO: width - FP.screen.width should be a function. :D - CP
			
			if (camera.x < 0) { camera.x = 0 };
			if (camera.x > width - FP.screen.width) { camera.x = width - FP.screen.width };
			if (camera.y < 0) { camera.y = 0 };
			if (camera.y > height - FP.screen.height) { camera.y = height - FP.screen.height };
		}
		
		// The camera moves faster so the player is guiding the crow
		public function moveCameraFromMouse():void
		{
			var xfactor:Number = (Input.mouseX - FP.screen.width/2)  / FP.screen.width;
			var yfactor:Number = (Input.mouseY - FP.screen.height/2) / FP.screen.height;
			
			camera.x += xfactor * CAMERASPEED;
			camera.y += yfactor * CAMERASPEED;
		}
	}
}