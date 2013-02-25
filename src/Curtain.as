 package  
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Hugo
	 */
	[Embed(source="../assets/scene.swf", symbol="Curtain")]
	public class Curtain extends MovieClip
	{
		private var mCurrentZone:int = 0;
		
		public function Curtain() 
		{	
		}
		public function reduction():void {
			if (mCurrentZone >0 && parent) {
				parent.removeChild(this);
			}
 			x = 1010;
			mCurrentZone++;
		}
	}

}