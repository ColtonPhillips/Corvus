package
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	public class Cloud extends Entity
	{
		[Embed(source = 'assets/cloud1.png')] private const CLOUD1:Class;
		[Embed(source = 'assets/cloud2.png')] private const CLOUD2:Class;
		[Embed(source = 'assets/cloud3.png')] private const CLOUD3:Class;
		[Embed(source = 'assets/cloud4.png')] private const CLOUD4:Class;
		
		public var cloudFactor:Number;
		public var CLOUDLESS_ZONE:int = 300;
		
		public function Cloud()
		{
			x = FP.rand(StarWorld.height);
			y = FP.rand(StarWorld.width);
			
			cloudFactor = FP.rand(StarWorld.height - CLOUDLESS_ZONE);
			cloudFactor = FP.scale(cloudFactor, 0, height, 0, 1)
			
			// TODO: Make clouds based on the cloud Factor
			
			var chince:int = FP.rand(3);
			
			var image:Image;
			if (chince == 0) 
			{	image = new Image(CLOUD1);
				image.alpha = 0.6+ FP.rand(2);
				graphic = image;
				
			}
			if (chince == 1)
			{
				image = new Image(CLOUD2);
				image.alpha = 0.4+ FP.rand(2);
				
				graphic = image;
			}
			if (chince == 2)
			{
				image = new Image(CLOUD3);
				image.alpha = 0.5+ FP.rand(2);
				graphic = image;
			}
			if (chince == 3)
			{
				image = new Image(CLOUD4);
				image.alpha = 0.6+ FP.rand(2);
				graphic = image;
			}
			var ix:Number = (0.5 + FP.rand(1)) * image.width/250 + FP.rand(1);
			var iy:Number = (0.3 + FP.rand(1)) * image.height/200 + FP.rand(1);
			graphic.scrollX = ix ;
			graphic.scrollY = iy ;
			
			
		}

		override public function update():void
		{
			super.update();
			//x += 0.4;
			
			// Cloud wraps around screen
			//if (x > StarWorld.width + 1500)
			//{
			//	x = -1500;
			//}
			
		}

	}
}