package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	public class Title extends Entity
	{
		public var text:Text;
		public function Title(xin:int, yin:int)
		{
			x = xin;
			y = yin;
			
			graphic = text = new Text("Corvus", 0, 0);
			text.size = 1000; // seems like it's capped at something
			text.centerOrigin();
			
		}

		override public function update():void
		{
			super.update();
			
			// Fade out the title
			if (text.alpha != 0)
				text.alpha -= 0.006
		}

	}
}