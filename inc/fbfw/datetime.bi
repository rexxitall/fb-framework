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

/'
  Represents an instant in time, expressed as a number of
  years, months, days, hours, minutes and seconds.
'/
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
      years() as long
    declare property _
      months() as long
    declare property _
      days() as long
    
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
    declare function _
      addYears( byval as integer ) _
      as DateTime
    declare function _
      addQuarters( byval as integer ) _
      as DateTime
    declare function _
      addMonths( byval as integer ) _
      as DateTime
    declare function _
      addWeeks( byval as integer ) _
      as DateTime
    declare function _
      addDays( byval as integer ) _
      as DateTime
    declare function _
      addHours( byval as integer ) _
      as DateTime
    declare function _
      addMinutes( byval as integer ) _
      as DateTime
    declare function _
      addSeconds( byval as integer ) _
      as DateTime
    declare function _
      withoutTime() as DateTime
    
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
  DateTime.years() _
  as long
  
  return( yearf( _dateSerial ) )
end property

property _
  DateTime.months() _
  as long
  
  return( monthf( _dateSerial ) )
end property

property _
  DateTime.days() _
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
    years = rhs.years andAlso _
    months = rhs.months andAlso _
    days = rhs.days andAlso _
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

function _
  DateTime.addYears( _
    byval value as integer ) _
  as DateTime
  
  return( DateTime( dateAdd( _
    "yyyy", value, _dateSerial ) ) )
end function

function _
  DateTime.addQuarters( _
    byval value as integer ) _
  as DateTime
  
  return( DateTime( dateAdd( _
    "q", value, _dateSerial ) ) )
end function

function _
  DateTime.addMonths( _
    byval value as integer ) _
  as DateTime
  
  return( DateTime( dateAdd( _
    "m", value, _dateSerial ) ) )
end function

function _
  DateTime.addWeeks( _
    byval value as integer ) _
  as DateTime
  
  return( DateTime( dateAdd( _
    "ww", value, _dateSerial ) ) )
end function

function _
  DateTime.addDays( _
    byval value as integer ) _
  as DateTime
  
  return( DateTime( dateAdd( _
    "d", value, _dateSerial ) ) )
end function

function _
  DateTime.addHours( _
    byval value as integer ) _
  as DateTime
  
  return( DateTime( dateAdd( _
    "h", value, _dateSerial ) ) )
end function

function _
  DateTime.addMinutes( _
    byval value as integer ) _
  as DateTime
  
  return( DateTime( dateAdd( _
    "n", value, _dateSerial ) ) )
end function

function _
  DateTime.addSeconds( _
    byval value as integer ) _
  as DateTime
  
  return( DateTime( dateAdd( _
    "s", value, _dateSerial ) ) )
end function

function _
  DateTime.withoutTime() _
  as DateTime
  
  return( DateTime( _
    yearf( _dateSerial ), _
    monthf( _dateSerial ), _
    dayf( _dateSerial ) ) )
end function

operator _
  = ( _
    byref lhs as DateTime, _
    byref rhs as DateTime ) _
  as integer
  
  return( _
    lhs.years = rhs.years andAlso _
    lhs.months = rhs.months andAlso _
    lhs.days = rhs.days )
end operator

operator _
  <> ( _
    byref lhs as DateTime, _
    byref rhs as DateTime ) _
  as integer
  
  return( _
    lhs.years <> rhs.years orElse _
    lhs.months <> rhs.months orElse _
    lhs.days <> rhs.days )
end operator

operator _
  > ( _
    byref lhs as DateTime, _
    byref rhs as DateTime ) _
  as integer
  
  return( _
    dateDiff( "s", rhs, lhs ) > 0 )
end operator

operator _
  >= ( _
    byref lhs as DateTime, _
    byref rhs as DateTime ) _
  as integer
  
  return( _
    dateDiff( "s", rhs, lhs ) >= 0 )
end operator

operator _
  < ( _
    byref lhs as DateTime, _
    byref rhs as DateTime ) _
  as integer
  
  return( _
    dateDiff( "s", rhs, lhs ) < 0 )
end operator

operator _
  <= ( _
    byref lhs as DateTime, _
    byref rhs as DateTime ) _
  as integer
  
  return( _
    dateDiff( "s", rhs, lhs ) <= 0 )
end operator

operator _
  + ( _
    byref lhs as DateTime, _
    byref rhs as TimeSpan ) _
  as DateTime
  
  return( DateTime( _
    lhs.years + rhs.years, _
    lhs.months + rhs.months, _
    lhs.days + rhs.days, _
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
    lhs.years - rhs.years, _
    lhs.months - rhs.months, _
    lhs.days - rhs.days, _
    lhs.hours - rhs.hours, _
    lhs.minutes - rhs.minutes, _
    lhs.seconds - rhs.seconds ) )
end operator

operator _
  - ( _
    byref lhs as DateTime, _
    byref rhs as DateTime ) _
  as TimeSpan
  
  return( TimeSpan( _
    dateDiff( "yyyy", rhs, lhs ), _
    dateDiff( "m", rhs, lhs ), _
    dateDiff( "d", rhs, lhs ), _
    dateDiff( "h", rhs, lhs ), _
    dateDiff( "n", rhs, lhs ), _
    dateDiff( "s", rhs, lhs ) ) )
end operator

#include once "unixdate.bi"

#undef defDateFn

#endif
