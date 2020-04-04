#ifndef __FBFW_UNIXDATE__
#define __FBFW_UNIXDATE__

/'
  Represents an instant in time, expressed as the number of
  seconds elapsed since Jan 1st, 1970 at 0:00:00.
'/
type _
  UnixDate
  
  public:
    declare constructor( _
      byval as longint )
    declare constructor( _
      byref as UnixDate )
    declare destructor()
    
    declare operator _
      let( byref as UnixDate )
    declare operator _
      let( byval as longint )
    
    declare operator _
      cast() as longint
    
    declare static function _
      fromDateTime( _
        byref as DateTime ) _
      as UnixDate
    declare function _
      toDateTime() as DateTime
    declare function _
      toString( _
        byref as const string => "mm-dd-yyyy hh:mm:ss" ) _
      as string
    declare function _
      withoutTime() as UnixDate
    
    static as const DateTime _
      Epoch
    
  private:
    declare constructor()
    
    declare static function _
      toTimestamp( _
        byref as DateTime ) _
      as longint
    declare static function _
      fromTimestamp( _
        byval as longint ) _
      as DateTime
    declare static function _
      withoutTime( _
        byval as longint ) _
      as longint 
    
    as longint _
      _timestamp
end type

dim as const DateTime _
  UnixDate.Epoch => DateTime( 1970, 1, 1, 0, 0, 0 )

constructor _
  UnixDate()
end constructor

constructor _
  UnixDate( _
    byval aTimestamp as longint )
  
  _timestamp => aTimestamp
end constructor

constructor _
  UnixDate( _
    byref rhs as UnixDate )
  
  _timestamp => rhs._timestamp
end constructor

destructor _
  UnixDate()
end destructor

operator _
  UnixDate.let( _
    byref rhs as UnixDate )
  
  _timestamp => rhs._timestamp
end operator

operator _
  UnixDate.let( _
    byval rhs as longint )
  
  _timestamp => rhs
end operator

operator _
  UnixDate.cast() as longint
  
  return( _timestamp )
end operator

function _
  UnixDate.fromDateTime( _
    byref aDate as DateTime ) _
  as UnixDate
  
  return( UnixDate( toTimestamp( aDate ) ) )
end function

function _
  UnixDate.toTimestamp( _
    byref aDate as DateTime ) _
  as longint
  
  return( ( aDate - Epoch ).seconds )
end function

function _
  UnixDate.fromTimestamp( _
    byval aTimestamp as longint ) _
  as DateTime
  
  return( cast( DateTime, Epoch ).addSeconds( aTimestamp ) )
end function

function _
  UnixDate.withoutTime( _
    byval aTimestamp as longint ) _
  as longint
  
  var _
    aDate => fromTimestamp( aTimestamp )
  
  return( toTimestamp( DateTime( _
    aDate.years, aDate.months, aDate.days ) ) )
end function

function _
  UnixDate.toDateTime() _
  as DateTime
  
  return( fromTimestamp( _timestamp ) )
end function

function _
  UnixDate.toString( _
    byref aFormat as const string => "mm-dd-yyyy hh:mm:ss" ) _
  as string
  
  return( toDateTime().toString( aFormat ) )
end function

function _
  UnixDate.withoutTime() _
  as UnixDate
  
  return( UnixDate( withoutTime( _timestamp ) ) )
end function

operator _
  = ( _
    byref lhs as UnixDate, _
    byref rhs as UnixDate ) _
  as integer
  
  return( cast( longint, lhs ) = cast( longint, rhs ) )
end operator

operator _
  <> ( _
    byref lhs as UnixDate, _
    byref rhs as UnixDate ) _
  as integer
  
  return( cast( longint, lhs ) <> cast( longint, rhs ) )
end operator

operator _
  > ( _
    byref lhs as UnixDate, _
    byref rhs as UnixDate ) _
  as integer
  
  return( cast( longint, lhs ) > cast( longint, rhs ) )
end operator

operator _
  >= ( _
    byref lhs as UnixDate, _
    byref rhs as UnixDate ) _
  as integer
  
  return( cast( longint, lhs ) >= cast( longint, rhs ) )
end operator

operator _
  < ( _
    byref lhs as UnixDate, _
    byref rhs as UnixDate ) _
  as integer
  
  return( cast( longint, lhs ) < cast( longint, rhs ) )
end operator

operator _
  <= ( _
    byref lhs as UnixDate, _
    byref rhs as UnixDate ) _
  as integer
  
  return( cast( longint, lhs ) <= cast( longint, rhs ) )
end operator

#endif
