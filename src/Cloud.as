package
{
	import common.Assets;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	public class Cloud extends Entity
	{		
		public var cloudFactor:Number;
		public var CLOUDLESS_ZONE:int = 300;
		
		public function Cloud()
		{
			x = FP.rand(StarWorld.height);
			y = FP.rand(StarWorld.width);
			
			cloudFactor = FP.rand(StarWorld.height - CLOUDLESS_ZONE);
			cloudFactor = FP.scale(cloudFactor, 0, height, 0, 1);

			var decider:int = FP.rand(3);
			var image:Image;
			if (decider == 0) 
			{	image = new Image(Assets.IMG_CLOUD1);
				image.alpha = 0.6+ FP.rand(2);
				graphic = image;
				
			}
			if (decider == 1)
			{
				image = new Image(Assets.IMG_CLOUD2);
				image.alpha = 0.4+ FP.rand(2);
				
				graphic = image;
			}
			if (decider == 2)
			{
				image = new Image(Assets.IMG_CLOUD3);
				image.alpha = 0.5+ FP.rand(2);
				graphic = image;
			}
			if (decider == 3)
			{
				image = new Image(Assets.IMG_CLOUD4);
				image.alpha = 0.6+ FP.rand(2);
				graphic = image;
			}
			var ix:Number = (0.5 + FP.rand(1)) * image.width/250 + FP.rand(1);
			var iy:Number = (0.3 + FP.rand(1)) * image.height / 200 + FP.rand(1);
			graphic.scrollX = ix;
			graphic.scrollY = iy;
		}

		override public function update():void
		{
			super.update();
		}

	}
}