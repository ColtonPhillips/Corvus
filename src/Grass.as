package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	public class Grass extends Entity
	{
		[Embed(source = 'assets/grass.png')] private const GRASS:Class;
		public function Grass(xin:int, yin:int)
		{
			x = xin;
			y = yin;
			graphic = new Backdrop(GRASS, true, false);
			graphic.scrollX = 0.4;
			
		}

		override public function update():void
		{
			super.update();
			
		}

	}
}