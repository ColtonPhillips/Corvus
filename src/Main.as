package
{
	import flash.ui.Mouse;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	public class Main extends Engine
	{
		public function Main()
		{
			super(800, 600, 60, false);
			FP.world = new StarWorld;
			FP.console.enable();
		}
		
		override public function focusGained():void {
			Mouse.hide();
		}
		
		override public function focusLost():void {
			Mouse.show();
		}

	}
}