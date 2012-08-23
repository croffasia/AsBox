package com.airlib.components.interfaces 
{
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	public interface IDisplayComponent extends IComponent 
	{
		function Create(DisplayContainer:DisplayObjectContainer = null):void;
		function get EnableAutoRegisterComponents():Boolean;
		function set EnableAutoRegisterComponents(value:Boolean):void;
	}
	
}