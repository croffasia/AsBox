/******************************************************************
 * AsBox - AS3 component game framework
 * Copyright (C) 2012 Poluosmal Andrew
 * Email: poluosmak.a@gmail.com
 ****************************************************************/

package com.asbox.components.base.interfaces
{
	public interface IComponentContainer extends IComponentComands
	{
		function AddComponent(hash:String):Boolean;
		function RemoveComponent(hash:String, system:Boolean = true):Boolean;				
		function GetComponentByName(name:String):IComponentObject;
		function GetComponentByClass(component:Class):Array;
		function GetComponentByHash(hash:String):IComponentObject;
		function get Components():Array;
	}
}