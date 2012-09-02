package
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	public class Cloud extends Entity
	{
		[Embed(source = 'res/cloud1.png')] private const CLOUD1:Class;
		[Embed(source = 'res/cloud2.png')] private const CLOUD2:Class;
		[Embed(source = 'res/cloud3.png')] private const CLOUD3:Class;
		[Embed(source = 'res/cloud4.png')] private const CLOUD4:Class;
		public function Cloud(xin:int, yin:int)
		{
			x = xin;
			y = yin;
			
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
			x += 0.4;
			
			// Cloud wraps around screen
			if (x > StarWorld.RBOUND + 1500)
			{
				x = StarWorld.LBOUND - 1500;
			}
			
		}

	}
}