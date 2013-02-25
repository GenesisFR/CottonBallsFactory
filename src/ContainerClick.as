package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author ...
	 */
	[Embed(source="../assets/scene.swf", symbol="ContainerClick")]
	public class ContainerClick extends MovieClip
	{
		public var mArm:Robot;
		public var mBattery:Battery;
		public var mButtonClick:Recharge;
		
		private var mLeftBox:Box;
		private var mRightBox:Box;
		
		private var mWorking:Boolean;
		
		private var mTimerProcessing:Timer;
		private var mTimerWorking:Timer;
		private var mTimerAnimation1:Timer;
		private var mTimerAnimation2:Timer;
		private var mTimerAnimation3:Timer;
		
		public function ContainerClick() 
		{
			mTimerAnimation1 = new Timer(500);
			mTimerAnimation2 = new Timer(1000);
			mTimerAnimation3 = new Timer(250);
			mTimerWorking = new Timer(10);
			mTimerWorking.start();
			
			stop();
			
			mWorking = false;

			mButtonClick.addEventListener(MouseEvent.CLICK, actionPerformed);
			mTimerAnimation3.addEventListener(TimerEvent.TIMER, workFinished);
			mTimerWorking.addEventListener(TimerEvent.TIMER, work);
			mTimerAnimation1.addEventListener(TimerEvent.TIMER, updateBox1);
			mTimerAnimation2.addEventListener(TimerEvent.TIMER, updateBox2);
		}
		
		public function actionPerformed(e:MouseEvent):void {
 			mBattery.increase(1);
		}
		
		public function addLeftBox(leftBox:Box):void
		{
			mLeftBox = leftBox;
		}
		
		public function addRightBox(rightBox:Box):void
		{
			mRightBox = rightBox;
		}
		
		public function work(e:TimerEvent ):void {
			if (!mWorking && !mBattery.isEmpty() && !mLeftBox.isEmpty()) {
				gotoAndPlay(21);
				mBattery.decrease(1);
				mTimerAnimation1.start();
				mWorking = true;				
			}
		}
		
		private function workFinished(e:TimerEvent):void {
			gotoAndStop(21);
			mTimerAnimation3.stop()
			mWorking = false;
		}
		
		public function activateButton():void {
			mButtonClick.enabled = mButtonClick.mouseEnabled = true;
			mButtonClick.alpha = 1;
		}
		
		public function desactivateButton():void {
			mButtonClick.enabled = mButtonClick.mouseEnabled = false;
			mButtonClick.alpha = 0.2;
		}
		
		public function updateBox1(e:TimerEvent):void {
			mLeftBox.decrease(1);
			mTimerAnimation1.stop();
			mTimerAnimation2.start();
		}
		
		public function updateBox2(e:TimerEvent):void {
			mRightBox.increase(1);
			mTimerAnimation2.stop();
			mTimerAnimation3.start();
		}
	}

}