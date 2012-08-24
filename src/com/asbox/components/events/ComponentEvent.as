package com.asbox.components.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	public class ComponentEvent extends Event 
	{
		public static const LOADED:String = "ComponentEvent_Loaded";
		public static const UNLOADED:String = "ComponentEvent_UnLoaded";
		public static const DISPOSED:String = "ComponentEvent_Disposed";
		public static const ACTIVE:String = "ComponentEvent_Active";
		public static const INACTIVE:String = "ComponentEvent_InActive";
		
		public static const TRANSFER_DATA:String = "ComponentEvent_TransferData";
		
		public var ComponentName:String = "";
		public var ComponentHash:String = "";
		public var TransferData:*;
		
		public function ComponentEvent(type:String, ComponentName:String, ComponentHash:String, TransferData:* = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);		
			this.ComponentName = ComponentName;
			this.ComponentHash = ComponentHash;
			this.TransferData = TransferData;
		} 
		
		public override function clone():Event 
		{ 
			return new ComponentEvent(type, ComponentName, ComponentHash, TransferData, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ComponentEvent", "type", "ComponentName", "ComponentHash", "TransferData", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}