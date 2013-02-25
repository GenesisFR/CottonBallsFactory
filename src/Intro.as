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
		
		public function Intro() 
		{
			mButtonIntro.addEventListener(MouseEvent.CLICK, goGame);
		}
		
		private function goGame(e:MouseEvent):void {
			SoundManager.instance.loopSound("theme");
			mButtonIntro.removeEventListener(MouseEvent.CLICK, goGame);
			parent.addChild(new Level(this));
			stage.focus = parent.getChildAt(1) as Sprite;
			parent.removeChild(this);
		}
		
	}

}