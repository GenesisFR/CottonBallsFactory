package  
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author ...
	 * 
	 */
	[Embed(source="../assets/intro.swf", symbol="Intro")]
	public class Intro extends Sprite
	{
		public var mButtonIntro:SimpleButton;
		private var mMain:Sprite;
		
		public function Intro(main:Sprite) 
		{
			mButtonIntro.addEventListener(MouseEvent.CLICK, startGame);
			mMain = main;
		}
		
		private function loopTheme():void 
		{
			SoundManager.instance.loopSound("theme");			
		}
		
		private function registerSounds():void
		{
			SoundManager.instance.registerSound("../assets/sounds/click1.mp3", "click1");
			SoundManager.instance.registerSound("../assets/sounds/click2.mp3", "click2");
			SoundManager.instance.registerSound("../assets/sounds/click3.mp3", "click3");
			SoundManager.instance.registerSound("../assets/sounds/click4.mp3", "click4");
			SoundManager.instance.registerSound("../assets/sounds/click5.mp3", "click5");
			SoundManager.instance.registerSound("../assets/sounds/click6.mp3", "click6");
			SoundManager.instance.registerSound("../assets/sounds/theme.mp3", "theme");
		}
		
		private function startGame(e:MouseEvent):void
		{
			mButtonIntro.removeEventListener(MouseEvent.CLICK, startGame);
			
			// prepares sounds
			registerSounds();
			loopTheme();
			
			// switches from main menu to factory
			parent.removeChild(this);
			mMain.addChild(new Level(mMain));
			
			// gives keyboard focus to the factory to allow pumpimg (needs to be fixed)
			mMain.stage.focus = mMain.getChildAt(0) as Sprite;
		}
		
	}

}