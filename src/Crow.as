package
{
	import common.Assets;
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	
	public class Crow extends Entity
	{		
		public var sprite:Spritemap = new Spritemap(Assets.IMG_CROW, 143, 126);
		
		// MAGIC NUMBERS
		public static var CROW_SPEED:Number = 1.8;
		
		public function Crow(xin:int, yin:int)
		{
			x = xin;
			y = yin;
			
			graphic = sprite;
			type = "crow";
			
			sprite.add("fly", [0,1,2,3,2,1], 15, true);
			
			sprite.play("fly");
			
			sprite.centerOrigin();
			setHitbox(40, 40, 20, 20);
		}
		

		override public function update():void
		{
			FP.world.bringForward(this);
			
				if (distanceToPoint(FP.world.mouseX, FP.world.mouseY) > 10)
				{
					if (x < FP.world.mouseX) 
				{
					sprite.flipped = true;
				}
				else 
				{
					sprite.flipped = false;
				}
			}
			
			moveTowards(FP.world.mouseX,FP.world.mouseY,CROW_SPEED);
		}
	}
}