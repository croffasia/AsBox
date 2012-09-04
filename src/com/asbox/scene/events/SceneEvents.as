/******************************************************************
 * AsBox - AS3 component game framework
 * Copyright (C) 2012 Poluosmal Andrew
 * Email: poluosmak.a@gmail.com
 ****************************************************************/

package com.asbox.scene.events
{
	import flash.events.Event;

	/** 
	 * Scene Event
	 * 
	 * @author Poluosmak Andrew
	 */
	public class SceneEvents extends Event
	{
		/**
		 * Change Status Event.
		 */
		public static const CHANGE_STATUS:String = "ChangeStatus";
		
		/**
		 * End of the lifetime of the scene event
		 */
		public static const LIVE_RIP:String = "LiveRip";		
		
		/**
		 * Transfered Data
		 */
		public var TransferData:*;
		
		/** 
		 * @inheritDoc 
		 */
		public function SceneEvents(type:String, TransferData:* = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);			
			this.TransferData = TransferData;
		}
		
		/** 
		 * @inheritDoc 
		 */
		public override function clone():Event 
		{ 
			return new SceneEvents(type, TransferData, bubbles, cancelable);
		} 
		
		/** 
		 * @inheritDoc 
		 */
		public override function toString():String 
		{ 
			return formatToString("SceneEvents", "type", "TransferData", "bubbles", "cancelable", "eventPhase"); 
		}
	}
}