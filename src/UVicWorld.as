package
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.Sfx;
	import net.flashpunk.FP;
	public class UVicWorld extends World
	{
		[Embed(source = 'res/uvgd/uvgd.mp3')] private const BUMPER:Class;
		
		// After bumper finishes, change the scene.
		public var bumperSound:Sfx = new Sfx(BUMPER,onSoundFinished);
		
		public function UVicWorld()
		{
			add(new UVicBackground);
			
			bumperSound.play();
			
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		public function onSoundFinished():void
		{	
			FP.world = new StarWorld;
		}
	}
}