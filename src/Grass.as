package
{
	import common.Assets;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	public class Grass extends Entity
	{
		public function Grass(xin:int, yin:int)
		{
			x = xin;
			y = yin;
			graphic = new Backdrop(Assets.IMG_GRASS, true, false);
			graphic.scrollX = 0.4;
			
		}

		override public function update():void
		{
			super.update();
			
		}

	}
}