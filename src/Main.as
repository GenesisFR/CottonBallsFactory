package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author David
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{	
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			//addChild(new Level(this));
			SoundManager.instance.registerSound("../assets/bonSons/theme.mp3", "theme", null);
			SoundManager.instance.registerSound("../assets/bonSons/click1.mp3", "click1", null);
			SoundManager.instance.registerSound("../assets/bonSons/click2.mp3", "click2", null);
			SoundManager.instance.registerSound("../assets/bonSons/click3.mp3", "click3", null);
			SoundManager.instance.registerSound("../assets/bonSons/click4.mp3", "click4", null);
			SoundManager.instance.registerSound("../assets/bonSons/click5.mp3", "click5", null);
			SoundManager.instance.registerSound("../assets/bonSons/click6.mp3", "click6", null);
			
			addChild(new Intro());
			
			
			
		}
		
	}
	
}