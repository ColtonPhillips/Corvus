package  
{
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Entity;
	
	public class UVicBackground extends Entity
	{
		[Embed(source = 'res/uvgd/uvgd1.png')] private const UVGD1:Class;
		[Embed(source = 'res/uvgd/uvgd2.png')] private const UVGD2:Class;
		[Embed(source = 'res/uvgd/uvgd3.png')] private const UVGD3:Class;
		[Embed(source = 'res/uvgd/uvgd4.png')] private const UVGD4:Class;
		
		// TODO: This is brittle and computer dependant.
		// A better solution would be to inspect the amount of time passed in the 
		// sound effect
		public var time:int = -3;
		public var count:int = 0;
		
		public function UVicBackground() 
		{
			graphic = new Image(UVGD1);
		}
		
		override public function update():void
		{
			super.update();
			
			time++;
			
			// Show the UVic GameDev bumper screens
			if (time == 60) 
			{
				if 		(count == 0) { time = 0; graphic = new Image(UVGD2); }
				else if (count == 1) { time = -8; graphic = new Image(UVGD3); }
				else if (count == 2) { graphic = new Image(UVGD4); }
				count++;
			}
			
		}
		
	}

}