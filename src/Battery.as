package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Kim
	 */
	[Embed(source="../assets/scene.swf", symbol="Battery")]
	public class Battery extends MovieClip
	{
		private var mMax:int;
		private var mCurrentValue:int;
		private var mText:TextField;
		
		public function Battery(/*max:int*/) 
		{
			mMax = 10;
			mCurrentValue = 10;
			mText = new TextField();
			mText.text = mCurrentValue.toString();
			mText.textColor = 0xffffff;
			mText.x = this.width * 0.4;
			addChild(mText);
			gotoAndStop(100);
		}
		
		public function decrease(decreaseValue:int):void {
			if(mCurrentValue > 0){
				mCurrentValue -= decreaseValue;
				mText.text = mCurrentValue.toString();
				gotoAndStop(mCurrentValue * 10);
			}
		}
		
		public function reset():void {
			mCurrentValue = mMax;
			mText.text = mCurrentValue.toString();
		}
		
		public function increase(increaseValue:int):void {
			if(mCurrentValue != mMax){
				mCurrentValue += increaseValue;
				mText.text = mCurrentValue.toString();
				gotoAndStop(mCurrentValue * 10);
			}
		}
		
		public function isEmpty():Boolean {
			if (mCurrentValue == 0) {
				return true;
			}
			else {
				return false;
			}
		}
	}

}