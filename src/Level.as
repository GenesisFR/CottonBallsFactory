package  
{ 
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author David
	 */
	[Embed(source="../assets/scene.swf", symbol="Level")]
	public class Level extends Sprite
	{
		public var mBox1:Box;
		public var mBox2:Box;
		public var mBox3:Box;
		public var mBox4:Box;
		public var mBox5:Box;
		public var mBox6:Box;
		public var mBoxVirtuelle:Box;
		//public var mBoxScore:Box;
		public var mContainerClick1:ContainerClick;
		public var mContainerClick2:ContainerClick;
		public var mContainerClick3:ContainerClick;
		public var mContainerClick4:ContainerClick;
		public var mContainerClick5:ContainerClick;
		public var mContainerClick6:ContainerClick;
		public var mContainerPump:ContainerPump;
		public var mCurtain:Curtain;
		public var mEnergyBar:EnergyBar;
		private var mTimerStep:Timer;
		private var mTimerSpawn:Timer;
		private var mTimerPump:Timer;
		
		public function Level(main:Sprite) 
		{
			mEnergyBar = new EnergyBar(main);
			mBoxVirtuelle = new Box();
			mBoxVirtuelle.x = 1090;
			mBoxVirtuelle.y = 415;
			mBoxVirtuelle.mBoxText.textColor = 0xffffff;

			main.stage.
			
			addChild(mEnergyBar);
			addChild(mBoxVirtuelle);
			addChild(mCurtain);
			
			mContainerClick1.addLeftBox(mBox1);
			mContainerClick1.addRightBox(mBox2);
			mContainerClick2.addLeftBox(mBox2);
			mContainerClick2.addRightBox(mBox3);
			mContainerClick3.addLeftBox(mBox3);
			mContainerClick3.addRightBox(mBox4);
			mContainerClick4.addLeftBox(mBox4);
			mContainerClick4.addRightBox(mBox5);
			mContainerClick5.addLeftBox(mBox5);
			mContainerClick5.addRightBox(mBox6);
			mContainerClick6.addLeftBox(mBox6);
			mContainerClick6.addRightBox(mBoxVirtuelle);
			
			mContainerClick1.mButtonClick.addEventListener(MouseEvent.CLICK, function():void 
			{
				SoundManager.instance.playSound("click1");
			});
			mContainerClick2.mButtonClick.addEventListener(MouseEvent.CLICK, function():void 
			{
				SoundManager.instance.playSound("click2");
			});
			mContainerClick3.mButtonClick.addEventListener(MouseEvent.CLICK, function():void 
			{
				SoundManager.instance.playSound("click3");
			});
			mContainerClick4.mButtonClick.addEventListener(MouseEvent.CLICK, function():void 
			{
				SoundManager.instance.playSound("click4");
			});
			mContainerClick5.mButtonClick.addEventListener(MouseEvent.CLICK, function():void 
			{
				SoundManager.instance.playSound("click5");
			});
			mContainerClick6.mButtonClick.addEventListener(MouseEvent.CLICK, function():void 
			{
				SoundManager.instance.playSound("click6");
			});
			
			mTimerStep = new Timer(100);
			mTimerStep.addEventListener(TimerEvent.TIMER, verifyEnergyBar);
			mTimerStep.start();
			
			mTimerPump = new Timer(5000);
			mTimerPump.addEventListener(TimerEvent.TIMER, endOfPart1);
			mTimerPump.start();
			
			mTimerSpawn = new Timer(1000);
			mTimerSpawn.addEventListener(TimerEvent.TIMER, spawnCreature);
		}
		
		private function spawnCreature(e:TimerEvent):void {
			if(mEnergyBar.isReadyToWork()){
				mBox1.increase(1);
			}
		}
		
		private function endOfPart1(e:TimerEvent):void {
				mTimerPump.stop();
				mTimerPump.removeEventListener(TimerEvent.TIMER, endOfPart1);
				mTimerSpawn.start();
				mCurtain.reduction();
		}
		
		private function endOfPartX():void {
			mCurtain.reduction();
		}
		
		private function verifyEnergyBar(e:TimerEvent):void {
			if (!mEnergyBar.isReadyToWork() && mTimerPump.hasEventListener(TimerEvent.TIMER)) {
				mTimerPump.reset();
				mTimerPump.start();
			}
			
			if (mEnergyBar.isReadyToWork()) {
				mContainerClick1.activateButton();
				mContainerClick2.activateButton();
				mContainerClick3.activateButton();
				mContainerClick4.activateButton();
				mContainerClick5.activateButton();
				mContainerClick6.activateButton();
			}
			else {
				mContainerClick1.desactivateButton();
				mContainerClick2.desactivateButton();
				mContainerClick3.desactivateButton();
				mContainerClick4.desactivateButton();
				mContainerClick5.desactivateButton();
				mContainerClick6.desactivateButton();
			}
			
			if (!mBox6.isEmpty()) {
				mCurtain.reduction();
			}
		}
	}

}