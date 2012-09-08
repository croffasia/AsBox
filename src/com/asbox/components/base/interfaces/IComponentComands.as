/******************************************************************
 * AsBox - AS3 component game framework
 * Copyright (C) 2012 Poluosmal Andrew
 * Email: poluosmak.a@gmail.com
 ****************************************************************/

package com.asbox.components.base.interfaces
{
	public interface IComponentComands extends IComponentObject
	{
		function Listener(callback:Function, type:String, component:String = "", autoRemove:Boolean = false):void;
		function UnregisterListener(callback:Function, type:String, component:String = ""):void;	
		function Call(type:String, data:* = null):void;
	}
}