#ifndef __FBFW_DATABASE_CONNECTION__
#define __FBFW_DATABASE_CONNECTION__

#include once "fbfw-collections.bi"
#include once "fbfw-events.bi"
#include once "db-query.bi"
#include once "db-erroreventargs.bi"

namespace Database
  /'
    This abstraction represents the connection to a database
    server.
  '/
  type _
    Connection _
    extends Events.WithEvents
    
    public:
      declare virtual destructor()
      
      declare property _
        DatabaseError() byref as const Events.Event
      
      declare property _
        available() as boolean
      declare property _
        lastError() as string
      
      declare abstract function _
        execute( _
          byref as const string ) _
        as Auto_ptr( of( Query ) )
      'declare abstract function _
      '  execute( _
      '    byref as PreparedQuery ) _
      '  as Auto_ptr( of( Query ) )
      declare abstract function _
        executeNonQuery( _
          byref as const string ) _
        as integer
      'declare abstract function _
      '  executeNonQuery( _
      '    byref as PreparedQuery ) _
      '  as integer
      
    protected:
      declare constructor()
      
      declare property _
        available( _
          byval as boolean )
      declare property _
        lastError( byref as string )
      
      declare virtual sub _
        onError( _
          byref as string )
        
    private:
      static as Events.Event _
        _EvDatabaseError
      as string _
        _lastError
      as boolean _
        _available
  end type
  
  dim as Events.Event _
    Connection._EvDatabaseError => Events.Event( _
      "DatabaseError" )
  
  constructor _
    Connection()
    
    register( _EvDatabaseError )
  end constructor
  
  destructor _
    Connection()
  end destructor
  
  property _
    Connection.DatabaseError() _
    byref as const Events.Event
    
    return( _EvDatabaseError )
  end property
  
  property _
    Connection.available() _
    as boolean
    
    return( _available )
  end property
  
  property _
    Connection.available( _
      byval value as boolean )
    
    _available => value
  end property
  
  property _
    Connection.lastError() _
    as string
    
    return( _lastError )
  end property
  
  property _
    Connection.lastError( _
      byref value as string )
    
    _lastError => value
  end property
  
  sub _
    Connection.onError( _
      byref anErrorMessage as string )
  end sub
end namespace

#endif
