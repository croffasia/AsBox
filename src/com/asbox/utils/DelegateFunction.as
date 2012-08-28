/******************************************************************
 * AsBox - AS3 component game framework
 * Copyright (C) 2012 Poluosmal Andrew
 * Email: poluosmak.a@gmail.com
 ****************************************************************/

package com.asbox.utils
{
	/**
	 * Delegates utils
	 * 
	 * @author Poluosmak Andrew
	 */
	public class DelegateFunction
	{		
		public static function create( handler:Function, ...args ):Function
		{
			return function(...innerArgs):*
			{
				return handler.apply( this, innerArgs.concat( args ) );
			}
		}
		
	}
}