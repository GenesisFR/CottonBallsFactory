package 
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author David
	 */
	
	public class SoundManager
	{
		
	 	private static var mInstance:SoundManager;
		private var mSoundTable:Dictionary;
		
		// -- INITIALIZATION ---
	 	public static function get instance():SoundManager
		{
	 		if(!SoundManager.mInstance)
	 			SoundManager.mInstance = new SoundManager(new SingletonEnforcer());
	 		
	 		return SoundManager.mInstance;
	 	}
	 	
	 	// ----------------------
	 	
	 	public function SoundManager(enforcer:SingletonEnforcer)
		{
			mSoundTable = new Dictionary(true);
		}
		
	 	public function getSound(soundId:String):SoundTrack
		{
			if (!mSoundTable[soundId])
				throw new Error( "<SoundManager> Sound: " + soundId + " does not exist!");
			else
				return (mSoundTable[soundId] as SoundTrack);
		}
		
		public function getSoundVolume(soundId:String):Number
		{
			if (!mSoundTable[soundId])
				throw new Error( "<SoundManager> Sound: " + soundId + " does not exist!");
			else
				return (mSoundTable[soundId] as SoundTrack).volume;
		}
		
	 	public function setSoundVolume(soundId:String, volume:Number):void
	 	{
	 		if (volume < 0)
				volume = 0;
			else if (volume > 1)
				volume = 1;
			
			if (!mSoundTable[soundId])
				throw new Error( "<SoundManager> Sound: " + soundId + " does not exist!");
			else
				(mSoundTable[soundId] as SoundTrack).volume = volume; 
	 	}
		
		public function registerSound(soundFile:String, soundId:String, onComplete:Function = null):void
		{
			mSoundTable[soundId] = new SoundTrack(new Sound(new URLRequest(soundFile)), onComplete);
		}
		
		public function playSound(soundId:String, resume:Boolean = false):void
		{
			if(!mSoundTable[soundId])
				throw new Error( "<SoundManager> Sound: " + soundId + " does not exist!");
			else
				(mSoundTable[soundId] as SoundTrack).play(resume);
		}
		
		public function loopSound(soundId:String, loopPosition:int = 0, resume:Boolean = false):void
		{
			if(!mSoundTable[soundId])
				throw new Error( "<SoundManager> Sound: " + soundId + " does not exist!");
			else
				(mSoundTable[soundId] as SoundTrack).loop(loopPosition, resume);
		}
		
		public function pauseSound(soundId:String):void
		{
			if(!mSoundTable[soundId])
				throw new Error( "<SoundManager> Sound: " + soundId + " does not exist!");
			else
				(mSoundTable[soundId] as SoundTrack).pause();
		}
		
		public function stopSound(soundId:String):void
		{
			if(!mSoundTable[soundId])
				throw new Error( "<SoundManager> Sound: " + soundId + " does not exist!");
			else
				(mSoundTable[soundId] as SoundTrack).stop();
		}
		
		public function get globalVolume():Number
		{
			return (SoundMixer.soundTransform.volume);
		}
		
		public function set globalVolume(volume:Number):void
		{
			if (volume < 0)
				volume = 0;
			else if (volume > 1)
				volume = 1;
			
			SoundMixer.soundTransform = new SoundTransform(volume);
		}
		
		public function dispose():void
		{
			for (var key:String in mSoundTable)
			{
				(mSoundTable[key] as SoundTrack).cleanup();
				delete mSoundTable[key];
			}
			
			mInstance = null;
		}
	}
	
}

class SingletonEnforcer{}