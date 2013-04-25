package
{
	import common.Assets;
	import flash.display.StageDisplayState;
	import net.flashpunk.*;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.*;
	public class StarWorld extends World
	{
		// ASSETS
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
		
		// INTRO TWEENER
		private var introTween:Tween;
		private var INTRO_WAIT_RATE:Number = 1/10;
		private var introRunning:Boolean = true;
		
		public function StarWorld()
		{
			constellations = new Vector.<Constellation>;
			
			cursorEmitter = new Emitter(Assets.IMG_DUST);
			cursorEmitter.relative = false;
			cursorEmitter.newType('sprinkle', [0]);
			cursorEmitter.setMotion('sprinkle', 50, 10, 1, 360, 30, 1);
			cursorEmitter.newType('shoot', [0]);
			cursorEmitter.setMotion('shoot', 50, 40, 20, 360, 30, 1);			
			cursorEmitter.newType('stay', [0]);
			cursorEmitter.setMotion('stay', 50, 2000, 100, 360, 200, 10);			
		}
		
		private function loadEntities():void
		{
			background = new StarBackground();
			add (background);
			
			// Create a buttload of clouds
			for (var i:int = 0; i < 60; i++)
			{
				cloud = new Cloud();
				add(cloud);
			}
			
			crow = new Crow(width/2 ,height);
			add (crow);
			
			grass = new Grass(300,height - 220);
			add (grass);
			
			grass = new Grass(400, height - 160);
			grass.graphic.scrollX = 0.2;
			add (grass);

			title = new Title(width / 2, height - 450);
			add (title);
			
			for (var j:int = 0; j < width; j+= FP.screen.width) {
				
				for (var k:int = 0; k < height; k+= FP.screen.height) {
						makeConstellation(j, k);	makeConstellation(j + 200, k + 200);
				}
			}
		}
		
		private function setupGame():void
		{
			introTween = new Tween(4, Tween.ONESHOT, function():void { introRunning = false; }, Ease.sineIn);
			addTween(introTween, true);
			
			// cursorEmitter needs to be on a Entity, prols.
			cursor = addGraphic(cursorEmitter);
			
			// The first screen should have a constellation visible
			makeConstellation(1400, 2080);
			
			// set camera square in the center on the bottom
			FP.camera.x = (width / 2) - (FP.screen.width / 2);
			FP.camera.y = height - FP.screen.height;
		}
		
		override public function begin():void 
		{
			super.begin();
			loadEntities();
			setupGame();
		}
		
		private function longWait(j:int):void
		{
			for (var i:int = 0; i < 5000000; i++) {
				for (; j > 0; j--) {
					i = i;
					j = j;
				}
			}
		}
		
		override public function render():void
		{			
			super.render();
			if (introRunning) {
				Draw.rect(camera.x, camera.y, FP.width, FP.height, 0xffffff, 1 - introTween.percent);
			}
		}
		
		override public function update():void 
		{
			super.update();
						
			// HACK: Figure it out yourself, genius, but this all sucks.
			bringToFront(grass);
			
			// For first x seconds we want a shutter effect. KIDFRENDLY
			introTween.update();
			if (introRunning) {
				longWait((introTween.percent) * INTRO_WAIT_RATE);
				crow.y = crow.y -1;
			}
			
			cursorEmitter.emit('sprinkle', FP.world.mouseX, FP.world.mouseY);
			cursorEmitter.emit('sprinkle', FP.world.mouseX, FP.world.mouseY);
			cursorEmitter.emit('shoot', FP.world.mouseX, FP.world.mouseY);
			if (FP.rand(10) == 2){
				cursorEmitter.emit('stay', FP.world.mouseX, FP.world.mouseY);
			}
			
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
		
		// Nailed it. Or did I ? No I didn't! :D
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