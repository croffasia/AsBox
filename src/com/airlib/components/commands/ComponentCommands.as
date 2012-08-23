package com.airlib.components.commands 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	public class ComponentCommands extends Event 
	{
		public static const HOLD:String = "set_inactive_status";
		public static const ACTIVATE:String = "set_active_status";
		public static const REMOVE:String = "remove_component";
		
		public function ComponentCommands(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);			
		} 
		
		public override function clone():Event 
		{ 
			return new ComponentCommands(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ComponentCommands", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}