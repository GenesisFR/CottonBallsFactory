package {
 
	/**
	 * SoundTrack : 12/30/10 : version 1.0
	 * 
	 * AS3 SoundTrack component to easily control and animate the playback of audio files.
	 * 
	 * Features:
	 * 1. Dynamic looping
	 * 2. Play/Pause/Stop/Resume
	 * 3. Volume Control
	 * 4. Panning Control
	 * 5. Peak Level Info
	 * 6. Animate volume and Pan using tweens
	 * 
	 * Author:Todd Williams
	 * http://www.taterboy.com/
	 * http://hdinteractive.com/
	 **/
 
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
 
	public class SoundTrack{
 
		private var _soundObj:Sound;			// sound object
		private var _channel:SoundChannel;		// sound channel
		private var _trans:SoundTransform;		// sound transform
		private var _pos:int = 0;				// sound position (seek)
		private var _volume:Number = 1;			// sound volume
		private var _pan:Number = 0;			// sound pan
		private var _complete:Function;			// on complete function, called when the sound Track has reached the end of the audio file.
												// Returns a reference to SoundTrack
 
		private var _loopPos:int = 0;			// loop position, allows for an intro to the audio loop, will loop back to 0 by default
		public var isPlaying:Boolean;			// if sound is currently playing
 
		/**
		 * get position of sound channel
		 * @returns a number representing the sound position
		 **/
		public function get position():Number{ return _channel.position;}
 
		/**
		 * direct access to sound
		 * @returns a Sound Object
		 **/
		public function get sound():Sound{ return _soundObj; }
 
		/**
		 * set onComplete function
		 * @param onCompleteHandler: Function
		 **/
		public function set onComplete(onCompleteHandler:Function):void{
			_complete = onCompleteHandler;
		}
 
		/**
		 * INIT soundTrack, hook up controls
		 *  @param soundObject: Sound
		 * 	@param onCompleteHandler: Function
		 **/
		public function SoundTrack(soundObject:Sound,onCompleteHandler:Function=null){
			_soundObj = soundObject;
			_channel = new SoundChannel();
			_trans = new SoundTransform();
			_complete = onCompleteHandler;
		}
 
		/**
		 * play the sound
		 * @param resume: start from the beginning of sound (default) or resume
		 **/
		public function play(resume:Boolean=false):void{
			isPlaying = true;
			if(resume){
				_channel = _soundObj.play(_pos);
			}
			else{
				_channel = _soundObj.play(0);
			}
			_volume < 1 ? volume = _volume:null;
			_pan != 0 ? pan = _pan:null;
 
			if(!_channel.hasEventListener(Event.SOUND_COMPLETE)){
				_channel.addEventListener(Event.SOUND_COMPLETE,soundHandler);
			}
		}
 
		/**
		 * loop the sound
		 * @param startPosition: the position to restart the loop
		 **/
		public function loop(loopPosition:int=0,resume:Boolean=false):void{
			isPlaying = true;
			if(loopPosition > 0){
				_loopPos = loopPosition;
				play(resume);
			}
			else{
				if(resume){
					_channel = _soundObj.play(_pos,int.MAX_VALUE);
				}
				else{
					_channel = _soundObj.play(0,int.MAX_VALUE);
				}
			}
			_volume < 1 ? volume = _volume:null;
			_pan != 0 ? pan = _pan:null;
		}
 
		/**
		 * pause the sound
		 **/
		public function pause():void{
			isPlaying = false;
			_pos = _channel.position;
			_channel.stop();
		}
 
		/**
		 * stop the sound
		 **/
		public function stop():void{
			isPlaying = false;
			_pos = 0;
			_loopPos = 0;
			_channel.stop();
		}
 
		/**
		 * close sound and remove listeners
		 **/
		public function cleanup():void{
			stop();
			try{
				_soundObj.close();
			}catch(e:Error){}
			if(_channel != null){
				if(_channel.hasEventListener(Event.SOUND_COMPLETE)){
					_channel.removeEventListener(Event.SOUND_COMPLETE,soundHandler);
				}
			}
		}
 
		/**
		 * set the volume as a property
		 * @param num: number representing the volume 0 - 1
		 **/
		public function set volume(num:Number):void{
			_volume = num;
			_trans.volume = num;
			_channel.soundTransform = _trans;
		}
 
		/**
		 * get the volume as a property
		 * @param val number representing the volume 0 - 1
		 **/
		public function get volume():Number{ return _volume; }
 
 
		/**
		 * set the pan
		 * @param num: the pan to left or right speaker -1 - 1
		 **/
		public function set pan(num:Number):void{
			_pan = num;
			_trans.pan = num;
			_channel.soundTransform = _trans;
		}
 
		/**
		 * get the current pan
		 * @returns a number representing the current pan -1 - 1
		 **/
		public function get pan():Number{ return _pan; }
 
		/**
		 * get the sound levels
		 * @returns an object containing the peak information for the "right" and "left" channel (numbers 0 - 1)
		 **/
		public function get levels():Object{
			var obj:Object = {right: _channel.rightPeak, left: _channel.leftPeak};
			return obj;
		}
 
		/**
		 * get the current pan
		 * @returns a number representing the right channel peak
		 **/
		public function get rightLevel():Number{ return _channel.rightPeak; }
 
		/**
		 * get the current pan
		 * @returns a number representing the left channel peak
		 **/
		public function get leftLevel():Number{ return _channel.leftPeak; }
 
		/**
		 * get peak
		 * @returns a number representing the average peak for left and right channels
		 **/
		public function get peak():Number{ return (_channel.leftPeak + _channel.rightPeak) / 2; }
 
		/**
		 * on sound complete event handler
		 * calls complete function if one has been set.
		 * @returns an refernce to SoundTrack
		 **/
		private function soundHandler(ev:Event):void{
			isPlaying = false;
			_pos = 0;
			if(_loopPos > 0){
				_pos = _loopPos;
				play(true);
			}
			if(_complete != null){
				_complete(this);
			}
		}	
	}
}