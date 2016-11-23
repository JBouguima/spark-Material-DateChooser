package com.jbouguima.nicedates.simplepicker.abstracts
{
	import mx.collections.ArrayCollection;

	public class YearVO
	{
		
		private var _year:Number;
		private var _actualMonth:Number;
		private var _selectedMonth:Number;
		private var _actualYear:Number;
		private var _selectedYear:Number;
		private var _monthList:ArrayCollection;
		
		public function set year(value:Number):void
		{
			_year = value;
		}
		
		public function get year():Number
		{
			return _year;
		}		
		
		public function set monthList(value:ArrayCollection):void
		{
			_monthList = value;
		}
		
		public function get monthList():ArrayCollection
		{
			return _monthList;
		}
		
		public function set actualMonth(value:Number):void
		{
			_actualMonth = value;
		}
		
		public function get actualMonth():Number
		{
			return _actualMonth;
		}	
		
		public function set selectedMonth(value:Number):void
		{
			_selectedMonth = value;
		}
		
		public function get selectedMonth():Number
		{
			return _selectedMonth;
		}	
		
		
		public function set actualYear(value:Number):void
		{
			_actualYear = value;
		}
		
		public function get actualYear():Number
		{
			return _actualYear;
		}	
		
		
		public function set selectedYear(value:Number):void
		{
			_selectedYear = value;
		}
		
		public function get selectedYear():Number
		{
			return _selectedYear;
		}		
		
		
	}
}