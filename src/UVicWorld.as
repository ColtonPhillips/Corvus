package
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.Sfx;
	import net.flashpunk.FP;
	import common.Assets;
	
	public class UVicWorld extends World
	{
		// After bumper finishes, change the scene.
		public var bumperSound:Sfx = new Sfx(Assets.SND_UVGD,onSoundFinished);
		
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