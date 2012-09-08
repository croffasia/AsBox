/******************************************************************
 * AsBox - AS3 component game framework
 * Copyright (C) 2012 Poluosmal Andrew
 * Email: poluosmak.a@gmail.com
 ****************************************************************/

package com.asbox.scene
{
	import com.asbox.scene.events.SceneEvents;
	import com.asbox.scene.interfaces.IScene;
	
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;

	/** 
	 * Scene Options Object
	 * 
	 * @author Poluosmak Andrew
	 */
	public class SceneOptions
	{
		/**
		 * @private
		 */
		private var _Name:String;
		
		/**
		 * @private
		 */
		private var _LiveTime:int = 0;
		
		/**
		 * @private
		 */
		private var _Params:Dictionary;
		
		/**
		 * @private
		 */
		private var _locked:Boolean = false;
		
		/**
		 * @private
		 */
		private var _Timer:Timer;
		
		/**
		 * @private
		 */
		private var _Owner:IScene;		

		/**
		 * Scene Name
		 */
		public function get Name():String
		{
			return _Name;
		}

		/**
		 * @private
		 */
		public function set Name(value:String):void
		{
			_Name = value;
		}

		/**
		 * Scene Live Time
		 */
		public function get LiveTime():int
		{
			return _LiveTime;
		}
		
		/**
		 * Start Live timer
		 */
		public function Live():void
		{
			if(_LiveTime > 0)
			{
				if(_Timer != null)
				{
					_Timer.stop();
					_Timer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnTimerComplete);
					_Timer = null;
				}
				
				_Timer = new Timer(_LiveTime * 1000, 1);
				_Timer.addEventListener(TimerEvent.TIMER_COMPLETE, OnTimerComplete, false, 0, true);
				_Timer.start();
			}
		} 

		/**
		 * @private
		 */
		public function set LiveTime(value:int):void
		{
			_LiveTime = value;
		}
		
		/**
		 * @private
		 */
		private function OnTimerComplete(event:TimerEvent):void
		{
			_Timer.stop();
			_Timer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnTimerComplete);
			_Timer = null;
			
			_Owner.dispatchEvent(new SceneEvents(SceneEvents.LIVE_RIP));
		}

		/**
		 * Options Owner IScene
		 */
		public function get Owner():IScene
		{
			return _Owner;
		}

		/**
		 * @private
		 */
		public function set Owner(value:IScene):void
		{
			if(value != null && value !== _Owner && _Timer != null)
			{
				_Timer.stop();
				_Timer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnTimerComplete);
				_Timer = null;
			}
			
			_Owner = value;
		}

		/**
		 * Additional Params
		 */
		public function get Params():Dictionary
		{
			return _Params;
		}

		/**
		 * @private
		 */
		public function set Params(value:Dictionary):void
		{
			_Params = value;
		}
	
		/**
		 * Disposal options object
		 */
		public function Dispose():void
		{
			if(_Timer != null)
			{
				_Timer.stop();
				_Timer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnTimerComplete);
				_Timer = null;
			}
			
			_Owner = null;
			_Params = null;
		}

		/**
		 * Locked Status
		 */
		public function get locked():Boolean
		{
			return _locked;
		}

		/**
		 * @private
		 */
		public function set locked(value:Boolean):void
		{
			_locked = value;
		}
	}
}