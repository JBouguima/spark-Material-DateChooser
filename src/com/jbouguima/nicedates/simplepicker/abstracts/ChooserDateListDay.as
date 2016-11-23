package com.jbouguima.nicedates.simplepicker.abstracts
{
import flash.events.EventDispatcher;
import mx.core.IUID;



public class ChooserDateListDay extends EventDispatcher implements IUID
{
	[Bindable("__NoChangeEvent__")]
	public var date:Date;
	
	private var _currentMonth:Boolean;
	private var _currentDateMonth:Boolean;
	private var _choosenDate:Boolean;
	
	[Bindable("__NoChangeEvent__")]
	public function get currentMonth():Boolean
	{
		return _currentMonth;
	}
	public function set currentMonth(value:Boolean):void
	{
		_currentMonth = value;
	}
	
	[Bindable("__NoChangeEvent__")]
	public function get currentDateMonth():Boolean
	{
		return _currentDateMonth;
	}
	public function set currentDateMonth(value:Boolean):void
	{
		_currentDateMonth = value;
	}
	
	
	[Bindable("__NoChangeEvent__")]
	public function get choosenDate():Boolean
	{
		return _choosenDate;
	}
	public function set choosenDate(value:Boolean):void
	{
		_choosenDate = value;
	}
	
	public function get uid():String
	{
		return date.fullYear.toString() + date.month.toString() + date.date.toString();
	}
	
	public function set uid(value:String):void
	{
	}
	
	[Bindable("__NoChangeEvent__")]
	public function get dateLabel():String
	{
		return date.date.toString();
	}
}

}
