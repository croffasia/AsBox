/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.asbox.managers.objects
{
	import com.asbox.managers.EventManager;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	/** 
	 * @private 
	 * @author Poluosmak Andrew
	 */
	public class EventObject
	{
		/** IEventDispatcher object **/
		private var _eventDispatcher:IEventDispatcher = null;
		
		/** Event string **/
		private var _event:String = "";
		
		/** Event group owner name **/
		private var _eventGroup:String = "";
		
		/** Callback function handler **/
		private var _callbackHandler:Function = null;
		
		/** Flag for auto remove event after first usage **/
		private var _autoRemove:Boolean = false;
		
		/** Flag for enable/disable event status **/
		private var _isDisabled:Boolean = false;
		
		/** Event priority **/
		private var _priority:int = 0;

		public function EventObject(){}
		
		/**
		 * Build Event object. 
		 * This method added new eventlistener for IEventDispatcher object
		 */
		public function build():void
		{
			if(_eventDispatcher == null)
			{
				throw new Error( "IEventDispatcher can not be null (event: "+_event+", event group: "+_eventGroup+")" );
			}
			
			if(_event == "")
			{
				throw new Error( "Please add Event string for "+_eventDispatcher+" EventDispatcher" );
			}
			
			_priority = EventManager.priority;
			_eventDispatcher.addEventListener(_event, internalCallback, false, _priority);
		}
		
		/**
		 * Proxy callback function handler
		 * 
		 * @param event - Event object
		 */
		private function internalCallback(event:Event):void
		{
			if(_callbackHandler != null)
			{
				_callbackHandler(event);				
			}
			
			if(_autoRemove == true)
			{
				destruct();
			}
		}
		
		/**
		 * Enable current event
		 */
		public function enable():void
		{
			if(_isDisabled == true)
			{
				_isDisabled = false;				
				_eventDispatcher.addEventListener(_event, internalCallback, false, _priority);
			}
		}
		
		/**
		 * Disable current event
		 */
		public function disable():void
		{
			if(_isDisabled == false)
			{
				_isDisabled = true;				
				_removeEvent();
			}
		}
		
		/**
		 * Destruc Event Object
		 */
		public function destruct():void
		{
			_removeEvent();
			
			_callbackHandler = null;
			_eventGroup = "";
			_event = "";
			_eventDispatcher = null;
		}
		
		/**
		 * Remove event listener from IEventDispatcher object
		 */
		private function _removeEvent():void
		{
			if(_eventDispatcher != null && _eventDispatcher.hasEventListener(_event)){
				_eventDispatcher.removeEventListener(_event, internalCallback);				
			}
		}
		
		public function get eventDispatcher():IEventDispatcher
		{
			return _eventDispatcher;
		}
		
		public function set eventDispatcher(value:IEventDispatcher):void
		{
			_eventDispatcher = value;
		}
		
		public function get event():String
		{
			return _event;
		}
		
		public function set event(value:String):void
		{
			_event = value;
		}
		
		public function get eventGroup():String
		{
			return _eventGroup;
		}
		
		public function set eventGroup(value:String):void
		{
			_eventGroup = value;
		}
		
		public function get callbackHandler():Function
		{
			return _callbackHandler;
		}
		
		public function set callbackHandler(value:Function):void
		{
			_callbackHandler = value;
		}
		
		public function get autoRemove():Boolean
		{
			return _autoRemove;
		}
		
		public function set autoRemove(value:Boolean):void
		{
			_autoRemove = value;
		}

		public function get isDisabled():Boolean
		{
			return _isDisabled;
		}

		public function set isDisabled(value:Boolean):void
		{
			_isDisabled = value;
		}

	}
}