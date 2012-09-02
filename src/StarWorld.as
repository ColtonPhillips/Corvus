package
{
	import net.flashpunk.*;
	import net.flashpunk.utils.*;
	public class StarWorld extends World
	{
		// ENTITIES
		public var constellations:Vector.<Constellation>;
		public var crow:Crow;
		public var grass:Grass;
		public var background:StarBackground;
		public var cloud:Cloud;
		public var title:Title;
		
		
		// MAGIC NUMBERS
		public static var LBOUND:int = 0;
		public static var RBOUND:int = 2000;
		public static var UBOUND:int = 0;
		public static var DBOUND:int = 2000;
		public static var CAMERASPEED:int = 5.5;
		
		public function StarWorld()
		{
			constellations = new Vector.<Constellation>;
			
		}
		
		override public function begin():void 
		{
			super.begin();
			
			background = new StarBackground();
			add (background);
			
			grass = new Grass(300,DBOUND + 500);
			add (grass);
			
			grass = new Grass(400, DBOUND + 450);
			grass.graphic.scrollX = 0.2;
			add (grass);
			
			// Create a buttload of clouds
			for (var i:int = 0; i < 60; i++)
			{
				cloud = new Cloud(FP.rand(RBOUND + 1500), FP.rand(DBOUND - 200));
				add(cloud);
			}
			
			crow = new Crow(RBOUND/2 + 300,DBOUND + 800);
			add (crow);
			
			
			title = new Title(RBOUND / 2 + 200, DBOUND + 200);
			add (title);
			
			// The first screen should have a constellation visible
			makeConstellation(1400, 2000);
			
			// set camera default
			FP.camera.x = RBOUND / 2;
			FP.camera.y = DBOUND;
			
			// Create X random constellations
			for (var j:int = 0; j < 15; j++)
			{
				makeConstellation(FP.rand(RBOUND + FP.screen.width), FP.rand(DBOUND + FP.height) );
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			moveCameraFromMouse();
			boundCamera();
		}
		
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
			if (x > StarWorld.RBOUND - 10) x = StarWorld.RBOUND - 100 - FP.rand(50);
			
			return x;
		}
		
		// The reason is Flashpunk doesn't use vectors for positions
		public function boundToScreenY(yin:int):int
		{
			var y:int = yin;
			if (y < 10) y = 100 + FP.rand(50);
			if (y > StarWorld.DBOUND - 10) y = StarWorld.DBOUND - 100 - FP.rand(50);
			
			return y;
		}
		
		// Nailed it.
		public function boundCamera():void
		{
			if (camera.x < LBOUND) { camera.x = LBOUND };
			if (camera.x > RBOUND) { camera.x = RBOUND };
			if (camera.y < UBOUND) { camera.y = UBOUND };
			if (camera.y > DBOUND) { camera.y = DBOUND };
		}
		
		// So dope.
		public function moveCameraFromMouse():void
		{
			var xfactor:Number = (Input.mouseX - FP.screen.width/2)  / FP.screen.width;
			var yfactor:Number = (Input.mouseY - FP.screen.height/2) / FP.screen.height;
			
			camera.x += xfactor * CAMERASPEED;
			camera.y += yfactor * CAMERASPEED;
		}
	}
}