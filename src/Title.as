package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	public class Title extends Entity
	{
		public function Title(xin:int, yin:int)
		{
			x = xin;
			y = yin;
			
			graphic = new Text("Corvus", 0, 0);
			(graphic as Text).size = 400;
			
		}

		override public function update():void
		{
			super.update();
			
			// Fade out the title
			if ( (graphic as Text).alpha != 0 )
				(graphic as Text).alpha -= 0.009
		}

	}
}