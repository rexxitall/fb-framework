#ifndef __FBFW_TIMESPAN__
#define __FBFW_TIMESPAN__

type _
  TimeSpan
  
  public:
    declare constructor( _
      byval as long, _
      byval as long, _
      byval as long, _
      byval as long, _
      byval as long, _
      byval as long, _
      byval as long, _
      byval as long, _
      byval as long )
    declare constructor( _
      byval as long, _
      byval as long, _
      byval as long )
    declare constructor( _
      byval as long, _
      byval as long, _
      byval as long, _
      byval as long, _
      byval as long, _
      byval as long )
    declare constructor( _
      byref as TimeSpan )
    declare destructor()
    
    declare operator _
      let( byref as TimeSpan )
    
    declare operator _
      cast() as string
    
    declare static function _
      fromDate( _
        byval as long, _
        byval as long, _
        byval as long ) _
      as TimeSpan
    declare static function _
      fromTime( _
        byval as long, _
        byval as long, _
        byval as long ) _
      as TimeSpan
    declare static function _
      fromDateTime( _
        byval as long, _
        byval as long, _
        byval as long, _
        byval as long, _
        byval as long, _
        byval as long ) _
      as TimeSpan
    declare static function _ 
      fromWeeks( _
        byval as long ) _
      as TimeSpan
    declare static function _
      fromCalendarWeeks( _
        byval as long ) _
      as TimeSpan
    declare static function _
      fromQuarters( _
        byval as long ) _
      as TimeSpan
    
    declare property _
      years() as long
    declare property _
      quarters() as long
    declare property _
      months() as long
    declare property _
      weeks() as long
    declare property _
      calendarWeeks() as long
    declare property _
      days() as long
    declare property _
      hours() as long
    declare property _
      minutes() as long
    declare property _
      seconds() as long
    
  private:
    declare constructor()
    
    as long _
      _years, _
      _quarters, _
      _months, _
      _weeks, _
      _calendarWeeks, _
      _days, _
      _hours, _
      _minutes, _
      _seconds
end type

constructor _
  TimeSpan()
end constructor

constructor _
  TimeSpan( _
    byval aYears as long, _
    byval aMonths as long, _
    byval aDays as long )
  
  _years => aYears
  _months => aMonths
  _days => aDays
end constructor

constructor _
  TimeSpan( _
    byval aYears as long, _
    byval aMonths as long, _
    byval aDays as long, _
    byval aHours as long, _
    byval aMinutes as long, _
    byval aSeconds as long )
  
  _years => aYears
  _months => aMonths
  _days => aDays
  _hours => aHours
  _minutes => aMinutes
  _seconds => aSeconds
end constructor

constructor _
  TimeSpan( _
    byval aYears as long, _
    byval aQuarters as long, _
    byval aMonths as long, _
    byval aWeeks as long, _
    byval aCalendarWeeks as long, _
    byval aDays as long, _
    byval aHours as long, _
    byval aMinutes as long, _
    byval aSeconds as long )
  
  _years => aYears
  _quarters => aQuarters
  _months => aMonths
  _weeks => aWeeks
  _calendarWeeks => aCalendarWeeks
  _days => aDays
  _hours => aHours
  _minutes => aMinutes
  _seconds => aSeconds
end constructor

constructor _
  TimeSpan( _
    byref rhs as TimeSpan )
  
  _years => rhs._years
  _quarters => rhs._quarters
  _months => rhs._months
  _weeks => rhs._weeks
  _calendarWeeks => rhs._calendarWeeks
  _days => rhs._days
  _hours => rhs._hours
  _minutes => rhs._minutes
  _seconds => rhs._seconds
end constructor

destructor _
  TimeSpan()
end destructor

operator _
  TimeSpan.let( _
    byref rhs as TimeSpan )
  
  _years => rhs._years
  _quarters => rhs._quarters
  _months => rhs._months
  _weeks => rhs._weeks
  _calendarWeeks => rhs._calendarWeeks
  _days => rhs._days
  _hours => rhs._hours
  _minutes => rhs._minutes
  _seconds => rhs._seconds
end operator

operator _
  TimeSpan.cast() _
  as string
  
  return( "{Years:" & _years & _
    ",Quarters:" & _quarters & _
    ",Months:" & _months & _
    ",Weeks:" & _weeks & _
    ",CalendarWeeks:" & _calendarWeeks & _
    ",Days:" & _days & _
    ",Hours:" & _hours & _
    ",Minutes:" & _minutes & _
    ",Seconds:" & _seconds & "}" )
end operator

property _
  TimeSpan.years() _
  as long
  
  return( _years )
end property

property _
  TimeSpan.quarters() _
  as long
  
  return( _quarters )
end property

property _
  TimeSpan.months() _
  as long
  
  return( _months )
end property

property _
  TimeSpan.weeks() _
  as long
  
  return( _weeks )
end property

property _
  TimeSpan.calendarWeeks() _
  as long
  
  return( _calendarWeeks )
end property

property _
  TimeSpan.days() _
  as long
  
  return( _days )
end property

property _
  TimeSpan.hours() _
  as long
  
  return( _hours )
end property

property _
  TimeSpan.minutes() _
  as long
  
  return( _minutes )
end property

property _
  TimeSpan.seconds() _
  as long
  
  return( _seconds )
end property

function _
  TimeSpan.fromDate( _
    byval aYears as long, _
    byval aMonths as long, _
    byval aDays as long ) _
  as TimeSpan
  
  return( TimeSpan( _
    aYears, 0, aMonths, 0, 0, aDays, 0, 0, 0 ) )
end function

function _
  TimeSpan.fromTime( _
    byval aHours as long, _
    byval aMinutes as long, _
    byval aSeconds as long ) _
  as TimeSpan
  
  return( TimeSpan( _
    0, 0, 0, 0, 0, 0, aHours, aMinutes, aSeconds ) )
end function

function _
  TimeSpan.fromDateTime( _
    byval aYears as long, _
    byval aMonths as long, _
    byval aDays as long, _
    byval aHours as long, _
    byval aMinutes as long, _
    byval aSeconds as long ) _
  as TimeSpan
  
  return( TimeSpan( _
    aYears, 0, aMonths, 0, 0, aDays, _
    aHours, aMinutes, aSeconds ) )
end function


function _
  TimeSpan.fromWeeks( _
    byval aWeeks as long ) _
  as TimeSpan
  
  return( TimeSpan( _
    0, 0, 0, aWeeks, 0, 0, 0, 0, 0 ) )
end function

function _
  TimeSpan.fromCalendarWeeks( _
    byval aCalendarWeeks as long ) _
  as TimeSpan
  
  return( TimeSpan( _
    0, 0, 0, 0, aCalendarWeeks, 0, 0, 0, 0 ) )
end function

function _
  TimeSpan.fromQuarters( _
    byval aQuarters as long ) _
  as TimeSpan
  
  return( TimeSpan( _
    0, aQuarters, 0, 0, 0, 0, 0, 0, 0 ) )
end function

operator _
  = ( _
    byref lhs as TimeSpan, _
    byref rhs as TimeSpan ) _
  as integer
  
  return( _
    lhs.years = rhs.years andAlso _
    lhs.quarters = rhs.quarters andAlso _
    lhs.months = rhs.months andAlso _
    lhs.weeks = rhs.weeks andAlso _
    lhs.calendarWeeks = rhs.calendarWeeks andAlso _
    lhs.days = rhs.days andAlso _
    lhs.hours = rhs.hours andAlso _
    lhs.minutes = rhs.minutes andAlso _
    lhs.seconds = rhs.seconds )
end operator

operator _
  <> ( _
    byref lhs as TimeSpan, _
    byref rhs as TimeSpan ) _
  as integer
  
  return( _
    lhs.years <> rhs.years orElse _
    lhs.quarters <> rhs.quarters orElse _
    lhs.months <> rhs.months orElse _
    lhs.weeks <> rhs.weeks orElse _
    lhs.calendarWeeks <> rhs.calendarWeeks orElse _
    lhs.days <> rhs.days orElse _
    lhs.hours <> rhs.hours orElse _
    lhs.minutes <> rhs.minutes orElse _
    lhs.seconds <> rhs.seconds )
end operator

operator _
  + ( _
    byref lhs as TimeSpan, _
    byref rhs as TimeSpan ) _
  as TimeSpan
  
  return( TimeSpan( _
    lhs.years + rhs.years, _
    lhs.quarters + rhs.quarters, _
    lhs.months + rhs.months, _
    lhs.weeks + rhs.weeks, _
    lhs.calendarWeeks + rhs.calendarWeeks, _
    lhs.days + rhs.days, _
    lhs.hours + rhs.hours, _
    lhs.minutes + rhs.minutes, _
    lhs.seconds + rhs.seconds ) )
end operator

operator _
  - ( _
    byref lhs as TimeSpan, _
    byref rhs as TimeSpan ) _
  as TimeSpan
  
  return( TimeSpan( _
    lhs.years - rhs.years, _
    lhs.quarters - rhs.quarters, _
    lhs.months - rhs.months, _
    lhs.weeks - rhs.weeks, _
    lhs.calendarWeeks - rhs.calendarWeeks, _
    lhs.days - rhs.days, _
    lhs.hours - rhs.hours, _
    lhs.minutes - rhs.minutes, _
    lhs.seconds - rhs.seconds ) )
end operator

#endif
