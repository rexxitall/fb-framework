#ifndef __FBFW_DATETIME__
#define __FBFW_DATETIME__

#include once "vbcompat.bi"
#include once "timespan.bi"

#macro _
  defDateFn( __name__, __fnc__ )
  
  function _
    __name__( _
      byval aDateSerial as double ) _
    as long
    
    return( __fnc__( aDateSerial ) )
  end function
#endmacro

defDateFn( yearf, year )
defDateFn( monthf, month )
defDateFn( dayf, day )

type _
  DateTime
  
  public:
    declare constructor()
    declare constructor( _
      byval as double )
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
    declare destructor()
    
    declare operator _
      cast() as double
    
    declare property _
      year() as long
    declare property _
      month() as long
    declare property _
      day() as long
    
    declare property _
      hours() as long
    declare property _
      minutes() as long
    declare property _
      seconds() as long
    
    declare function _
      equals( _
        byref as DateTime ) _
      as boolean
    
    declare function _
      toString( _
        byref as const string => "mm-dd-yyyy hh:mm:ss" ) _
      as string
    declare function _
      differenceWith( _
        byref as DateTime, _
        byval as long => fbUseSystem, _
        byval as long => fbUseSystem ) _
      as TimeSpan
    
  private:
    as double _
      _dateSerial
end type

constructor _
  DateTime()
  
  _dateSerial => now()
end constructor

constructor _
  DateTime( _
    byval aDateSerial as double )
  
  _dateSerial => aDateSerial
end constructor

constructor _
  DateTime( _
    byval aYear as long, _
    byval aMonth as long, _
    byval aDay as long )
  
  _dateSerial => dateSerial( aYear, aMonth, aDay )
end constructor

constructor _
  DateTime( _
    byval aYear as long, _
    byval aMonth as long, _
    byval aDay as long, _
    byval anHour as long, _
    byval aMinutes as long, _
    byval aSeconds as long )
  
  _dateSerial => dateSerial( aYear, aMonth, aDay ) + _
    timeSerial( anHour, aMinutes, aSeconds )
end constructor

destructor _
  DateTime()
end destructor

operator _
  DateTime.cast() _
  as double
  
  return( _dateSerial )
end operator

property _
  DateTime.year() _
  as long
  
  return( yearf( _dateSerial ) )
end property

property _
  DateTime.month() _
  as long
  
  return( monthf( _dateSerial ) )
end property

property _
  DateTime.day() _
  as long
  
  return( dayf( _dateSerial ) )
end property

property _
  DateTime.hours() _
  as long
  
  return( hour( _dateSerial ) )
end property

property _
  DateTime.minutes() _
  as long
  
  return( minute( _dateSerial ) )
end property

property _
  DateTime.seconds() _
  as long
  
  return( second( _dateSerial ) )
end property

function _
  DateTime.equals( _
    byref rhs as DateTime ) _
  as boolean
  
  return( cbool( _
    year = rhs.year andAlso _
    month = rhs.month andAlso _
    day = rhs.day andAlso _
    hours = rhs.hours andAlso _
    minutes = rhs.minutes andAlso _
    seconds = rhs.seconds ) )
end function

function _
  DateTime.toString( _
    byref aFormat as const string => "mm-dd-yyyy hh:mm:ss" ) _
  as string
  
  return( format( _dateSerial, aFormat ) )
end function

function _
  DateTime.differenceWith( _
    byref another as DateTime, _
    byval aFirstDayOfWeek as long => fbUseSystem, _
    byval aFirstDayOfYear as long => fbUseSystem ) _
  as TimeSpan
  
  dim as long _
    aYears => dateDiff( _
      "yyyy", _dateSerial, another, aFirstDayOfWeek, aFirstDayOfYear ), _
    aQuarters => dateDiff( _
      "q", _dateSerial, another, aFirstDayOfWeek, aFirstDayOfYear ), _
    aMonths => dateDiff( _
      "m", _dateSerial, another, aFirstDayOfWeek, aFirstDayOfYear ), _
    aWeeks => dateDiff( _
      "w", _dateSerial, another, aFirstDayOfWeek, aFirstDayOfYear ), _
    aCalendarWeeks => dateDiff( _
      "ww", _dateSerial, another, aFirstDayOfWeek, aFirstDayOfYear ), _
    aDays => dateDiff( _
      "d", _dateSerial, another, aFirstDayOfWeek, aFirstDayOfYear ), _
    aHours => dateDiff( _
      "h", _dateSerial, another, aFirstDayOfWeek, aFirstDayOfYear ), _
    aMinutes => dateDiff( _
      "n", _dateSerial, another, aFirstDayOfWeek, aFirstDayOfYear ), _
    aSeconds => dateDiff( _
      "s", _dateSerial, another, aFirstDayOfWeek, aFirstDayOfYear )
    
  return( TimeSpan( _
    aYears, _
    aQuarters, _
    aMonths, _
    aWeeks, _
    aCalendarWeeks, _
    aDays, _
    aHours, _
    aMinutes, _
    aSeconds ) )
end function

operator _
  = ( _
    byref lhs as DateTime, _
    byref rhs as DateTime ) _
  as integer
  
  return( _
    lhs.year = rhs.year andAlso _
    lhs.month = rhs.month andAlso _
    lhs.day = rhs.day )
end operator

operator _
  <> ( _
    byref lhs as DateTime, _
    byref rhs as DateTime ) _
  as integer
  
  return( _
    lhs.year <> rhs.year orElse _
    lhs.month <> rhs.month orElse _
    lhs.day <> rhs.day )
end operator

operator _
  + ( _
    byref lhs as DateTime, _
    byref rhs as TimeSpan ) _
  as DateTime
  
  return( DateTime( _
    lhs.year + rhs.years, _
    lhs.month + rhs.months, _
    lhs.day + rhs.days, _
    lhs.hours + rhs.hours, _
    lhs.minutes + rhs.minutes, _
    lhs.seconds + rhs.seconds ) )
end operator

operator _
  - ( _
    byref lhs as DateTime, _
    byref rhs as TimeSpan ) _
  as DateTime
  
  return( DateTime( _
    lhs.year - rhs.years, _
    lhs.month - rhs.months, _
    lhs.day - rhs.days, _
    lhs.hours - rhs.hours, _
    lhs.minutes - rhs.minutes, _
    lhs.seconds - rhs.seconds ) )
end operator

#undef defDateFn

#endif
