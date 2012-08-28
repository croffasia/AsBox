/******************************************************************
 * AsBox - AS3 component game framework
 * Copyright (C) 2012 Poluosmal Andrew
 * Email: poluosmak.a@gmail.com
 ****************************************************************/

package com.asbox.utils 
{
	/**
	 * Event name utils
	 * @author Poluosmak Andrew
	 */
	public class EventsMap 
	{	
		public static function CreateType(component:String, type:String):String 
		{
			return component + "::" + type;
		}
	}

}