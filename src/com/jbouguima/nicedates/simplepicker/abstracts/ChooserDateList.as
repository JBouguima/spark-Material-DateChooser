package com.jbouguima.nicedates.simplepicker.abstracts
{

import mx.collections.ArrayList;



public class ChooserDateList extends ArrayList
{

	public static const dayOfMS:Number = 1000 * 60 * 60 * 24;

	private var _chooserDate:Boolean;
	
	public function set chooserDate(_value:Boolean):void
	{
		_chooserDate = _value;
	}

	public function get chooserDate():Boolean
	{
		return _chooserDate;
	}

	public function setMonthAndYear(dateChooser:Date, month:int, year:int):void
	{
		_month = month;
		_year = year;
		_dateChooser = dateChooser;
		
		var d:Date = new Date(year, month, 1, 12);
		
		var dofw:Number = d.day;
		var value:Number = d.time;
		
		if(dofw == 0){
			dofw = 7;
		}
		while (dofw > 1)
		{
			value -= dayOfMS;
			dofw--;
		}
		var arr:Array = [];

		for (var i:int = 0; i < 42; i++)
		{
			var dt:Date = new Date(value);
			var dt2:Date = new Date();
			var data:ChooserDateListDay = new ChooserDateListDay();
			data.date = dt;
			data.currentMonth = dt.month == month;
			data.choosenDate = dateChooser ? (dateChooser.date == dt.date) && 
				(dateChooser.month == dt.month) && (dateChooser.fullYear == dt.fullYear) : false;
			data.currentDateMonth = ((dt2.month == month) && (dt2.fullYear == year));
			arr.push(data);
			value += dayOfMS;
		}
		source = arr;
	}
	private var _dateChooser:Date;
	private var _month:int;
	
	[Bindable("collectionChange")]
	public function get month():int
	{
		return _month;
	}
	
	private var _year:int;
	
	[Bindable("collectionChange")]
	public function get year():int
	{
		return _year;
	}

}

}
