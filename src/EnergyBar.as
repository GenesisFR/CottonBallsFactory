package  
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author David
	 */
	public class EnergyBar extends Sprite
	{
		private var mEnergy:int;
		private var mOverload:Boolean;
		private var mTimer:Timer;
		private var mBar:Shape;
		
		public function EnergyBar(main:Sprite)
		{
			mEnergy = 100;
			mOverload = false;
			mTimer = new Timer(20);
			mBar = new Shape;
			with(mBar.graphics){
			beginFill(0xba4820);
			drawRect(0,0, 21, -120);
			endFill();
			}
			//to adjust
			mBar.x = 118;
			mBar.y = 370;
			addChild(mBar);
			
			mTimer.addEventListener(TimerEvent.TIMER, consume);
			main.stage.addEventListener(KeyboardEvent.KEY_DOWN, charge);
			
			mTimer.start();
		}
		
		public function decrease(decreaseValue:int):void {
			if (mEnergy - decreaseValue >= 0){
				mEnergy -= decreaseValue;
			}
			else {
				mEnergy = 0;
				mOverload = false;
				var ct1:ColorTransform = new ColorTransform();
				ct1.color = 0xba4820;
				mBar.transform.colorTransform = ct1;
			}
		}
		
		public function increase(increaseValue:int):void {
			if (mEnergy + increaseValue <= 110) {
				mEnergy += increaseValue;
			}
			else {
				mEnergy = 110;
				mOverload = true;
				mBar.height = 120;
				var ct1:ColorTransform = new ColorTransform();
				ct1.color = 0xFF0000;
				mBar.transform.colorTransform = ct1;
			}
		}
		
		public function consume(e:TimerEvent):void {
			decrease(1);
			mBar.height = mEnergy;
		}
		
		public function charge(e:KeyboardEvent):void {
			if (e.keyCode == 32 && mOverload == false) {
				
				increase(10);
			}
		}
		
		public function isReadyToWork():Boolean {
			if (mEnergy > 30 && mEnergy < 75 && !mOverload) {
				return true;
			}
			else {
				return false;
			}
		}
		
	}

}