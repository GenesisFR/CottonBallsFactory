package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author ...
	 */
	[Embed(source="../assets/scene.swf", symbol="Robot")]
	public class Robot extends MovieClip
	{
		private var mWorking:Boolean;
		
		public function Robot() 
		{
			mWorking = false;
		}
		
		public function startWorking():void {
			if(!mWorking){
				//start animation
				mWorking = true;
			}
		}
		
		public function stopWorking():void {
			if (mWorking) {
				//stop animation
				mWorking = false;
			}
		}
	}

}