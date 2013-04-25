package
{
	import common.Assets;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	public class StarBackground extends Entity
	{
		
		public function StarBackground()
		{
			graphic = new Backdrop(Assets.IMG_BACKGROUND, true, true);
			graphic.scrollX = 0.3;
			graphic.scrollY = 0.3;
		}

		override public function update():void
		{
			super.update();
		}

	}
}