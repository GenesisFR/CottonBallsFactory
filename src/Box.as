package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author David
	 */
	[Embed(source="../assets/scene.swf", symbol="Box")]
	public class Box extends Sprite
	{
		public var mBoxText:TextField;
		private var mCounter:int = 0;
		
		public function Box()
		{
			mBoxText.text = String(0);
		}
		
		public function increase(number:int):void
		{
			mCounter += number;
			mBoxText.text = mCounter.toString();
		}
		
		public function decrease(number:int):void
		{
			mCounter -= number;
			mBoxText.text = mCounter.toString();
		}
		
		public function isEmpty():Boolean {
			if (mCounter > 0) {
				return false;
			}
			else {
				return true;
			}
		}
	
	}

}