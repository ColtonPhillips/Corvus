package
{
	import common.Assets;
	import net.flashpunk.debug.Console;
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	import net.flashpunk.FP;
	public class Note extends Entity
	{
		// This sucks hard - CP
		public var soundArray:Array = [Assets.SND_C, Assets.SND_D, Assets.SND_DS, Assets.SND_F, Assets.SND_GS, Assets.SND_A, Assets.SND_B, Assets.SND_C1];
		
		public var key:Sfx;
		
		// TODO: Compare sound volume level to browser expectations - CP
		public var ATTENUATIONFACTOR:Number = 100;

		public function Note(xin:int, yin:int)
		{
			x = xin;
			y = yin;
			
			
			// TODO: A note key should be set outside of the class - CP
			var index:Class = soundArray[FP.rand(soundArray.length - 1)];
			key = new Sfx(index);
		}

		override public function update():void
		{
			
		}
		
		public function play():void 
		{
			// Volume attenuation
			var thevolume:Number = ATTENUATIONFACTOR / distanceToPoint(FP.camera.x + FP.screen.width / 2, FP.camera.y + FP.screen.height / 2);
			if (thevolume < 0.1) return;
			if (thevolume > 0.6) 
				thevolume = 0.6;
			
			// Pan the sound
			var pan:Number = FP.scale(x, FP.camera.x, FP.camera.x + FP.screen.width, -1, 1);
			if (pan < -1) pan = -1; if (pan > 1) pan = 1;
			
			// Play the key
			key.play(thevolume, pan);
		}
	}
}