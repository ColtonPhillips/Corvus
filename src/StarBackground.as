package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	public class StarBackground extends Entity
	{
		[Embed(source = 'res/background.png')] private const BACKGROUND:Class;
		public function StarBackground()
		{
			graphic = new Backdrop(BACKGROUND, true, true);
			graphic.scrollX = 0.3;
			graphic.scrollY = 0.3;
		}

		override public function update():void
		{
			super.update();
		}

	}
}