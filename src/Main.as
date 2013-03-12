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
			super(800, 600, 60, false);
			FP.world = new UVicWorld;
			//FP.console.enable();
		}
		
		override public function init():void {
			
		}
		
		override public function focusGained():void {
			// Kids get confused without mouse cursor - CP
			//Mouse.hide();
		}
		
		override public function focusLost():void {
			//Mouse.show();
		}

	}
}