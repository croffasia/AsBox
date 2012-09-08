/******************************************************************
 * AsBox - AS3 component game framework
 * Copyright (C) 2012 Poluosmal Andrew
 * Email: poluosmak.a@gmail.com
 ****************************************************************/

package com.asbox.components.base.interfaces
{
	import flash.events.IEventDispatcher;

	public interface IComponentObject extends IEventDispatcher
	{
		function get OwnerComponent():IComponentObject;
		function set OwnerComponent(value:IComponentObject):void;
		
		function get ComponentName():String;
		function set ComponentName(value:String):void;
		
		function get ComponentHash():String;
		function set ComponentHash(value:String):void;
		
		function get Status():int;
		
		function ActivateComponent():void;
		function DeactivateComponent():void;
		
		function Initialize(name:String):void;
		function Dispose():void;		
	}
}