package
{
	import net.flashpunk.debug.Console;
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	import net.flashpunk.FP;
	public class Note extends Entity
	{
		// I actually have no excuse for the last part when it gets to Z
		// I think I did that casually at home. This work is so tedious.
		// We should think about how to make this process smarter. Oh well.
		// Like I fucking care because 
		// We're in the money!  http://www.youtube.com/watch?v=UJOjTNuuEVw
		
		[Embed(source = 'res/note/c.mp3')] public static const C:Class;
		[Embed(source = 'res/note/cs.mp3')] public static const CS:Class;
		[Embed(source = 'res/note/d.mp3')] public static const D:Class;
		[Embed(source = 'res/note/ds.mp3')] public static const DS:Class;
		[Embed(source = 'res/note/e.mp3')] public static const E:Class;
		[Embed(source = 'res/note/f.mp3')] public static const F:Class;
		[Embed(source = 'res/note/fs.mp3')] public static const FS:Class;
		[Embed(source = 'res/note/g.mp3')] public static const G:Class;
		[Embed(source = 'res/note/gS.mp3')] public static const GS:Class;
		[Embed(source = 'res/note/a.mp3')] public static const A:Class;
		[Embed(source = 'res/note/as.mp3')] public static const AS:Class;
		[Embed(source = 'res/note/b.mp3')] public static const B:Class;
		[Embed(source = 'res/note/c1.mp3')] public static const C1:Class;
		[Embed(source = 'res/note/z.mp3')] public static const Z:Class
		[Embed(source = 'res/note/y.mp3')] public static const Y:Class
		[Embed(source = 'res/note/x.mp3')] public static const X:Class
		[Embed(source = 'res/note/w.mp3')] public static const W:Class
		[Embed(source = 'res/note/v.mp3')] public static const V:Class
		[Embed(source = 'res/note/u.mp3')] public static const U:Class
		[Embed(source = 'res/note/t.mp3')] public static const T:Class
		[Embed(source = 'res/note/s.mp3')] public static const S:Class
		[Embed(source = 'res/note/m.mp3')] public static const M:Class
		
		public var soundArray:Array = [C, E, F, G, GS, A, B, C1, Z, Y, W, V, U, T, S, M];
		
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