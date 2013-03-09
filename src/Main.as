package
{
	import flash.ui.Mouse;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import flash.display.StageDisplayState;
	public class Main extends Engine
	{
		public function Main()
		{
			super(1280, 1024 - 156, 60, false);
			FP.world = new StarWorld;
			//FP.console.enable();
		}
		
		override public function init():void {
			// crap dont work
			//FP.stage.displayState = StageDisplayState.FULL_SCREEN;
		}
		
		override public function focusGained():void {
			Mouse.hide();
		}
		
		override public function focusLost():void {
			Mouse.show();
		}

	}
}