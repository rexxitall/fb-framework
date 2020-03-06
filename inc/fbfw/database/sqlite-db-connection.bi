#ifndef __FBFW_SQLITE3_CONNECTION__
#define __FBFW_SQLITE3_CONNECTION__

#include once "crt.bi"

namespace Database
  namespace SQLite
    /'
      Database connector for SQLite 3
    '/
    type _
      Connection _
      extends Database.Connection
      
      public:
        declare constructor()
        declare constructor( _
          byref as const string )
        declare constructor( _
          byref as const string, _
          byval as long )
        declare virtual destructor() override
        
        declare operator _
          cast() as sqlite3 ptr
        
        declare property _
          lastErrorCode() as long
        declare property _
          affectedRows() as integer
        
        declare virtual sub _
          connect( _
            byref as const string )
        declare virtual sub _
          connect( _
            byref as const string, _
            byval as long )
        declare virtual function _
          execute( _
            byref as const string ) _
          as Auto_ptr( of( Query ) ) override
        'declare virtual function _
        '  execute( _
        '    byref as PreparedQuery ) _
        '  as Auto_ptr( of( Query ) ) override
        declare virtual function _
          executeNonQuery( _
            byref as const string ) _
          as integer override
        'declare virtual function _
        '  executeNonQuery( _
        '    byref as PreparedQuery ) _
        '  as integer override
        
      protected:
        declare property _
          lastErrorCode( _
            byval as long )
        declare property _
          affectedRows( _
            byval as integer )
          
        declare virtual sub _
          onError( _
            byref as string ) override
          
      private:
        as sqlite3 ptr _
          _database
        as integer _
          _affectedRows
        as long _
          _lastErrorCode
    end type
    
    constructor _
      Connection()
    end constructor
    
    constructor _
      Connection( _
        byref aPath as const string )
      
      connect( _
        aPath, _
        SQLITE_OPEN_READWRITE )
    end constructor
    
    constructor _
      Connection( _
        byref aPath as const string, _
        byval aFlags as long )
      
      connect( _
        aPath, _
        aFlags )
    end constructor
    
    destructor _
      Connection()
      
      if( _database <> 0 ) then
        sqlite3_close( _database )
      end if
    end destructor
    
    operator _
      Connection.cast() _
      as sqlite3 ptr
      
      return( _database )
    end operator
    
    property _
      Connection.lastErrorCode() _
      as long
      
      return( _lastErrorCode )
    end property
    
    property _
      Connection.lastErrorCode( _
        byval value as long )
      
      _lastErrorCode => value
    end property
    
    property _
      Connection.affectedRows() _
      as integer
      
      return( _affectedRows )
    end property
    
    property _
      Connection.affectedRows( _
        byval value as integer )
      
      _affectedRows => value
    end property
    
    sub _
      Connection.onError( _
        byref anErrorMessage as string )
      
      lastError => anErrorMessage
      'lastError => *cptr( zstring ptr, sqlite3_errmsg( _database ) )
      lastErrorCode => sqlite3_extended_errcode( _database )
      
      raiseEvent( _
        DatabaseError, _
        DatabaseErrorEventArgs( _
          lastError, _
          lastErrorCode ) )
    end sub
    
    sub _
      Connection.connect( _
        byref aPath as const string )
      
      connect( _
        aPath, _
        SQLITE_OPEN_READWRITE )
    end sub
    
    sub _
      Connection.connect( _
        byref aPath as const string, _
        byval aFlags as long )
      
      if( _database <> 0 ) then
        sqlite3_close( _database )
      end if
      
      dim as integer _
        result => sqlite3_open_v2( _
          aPath, _
          @_database, _
          aFlags, _
          0 )
        
      if( result ) then
        available => false
        
        onError( *cptr( zstring ptr, sqlite3_errmsg( _database ) ) )
        
        sqlite3_close( _database )
        _database => 0
      else
        available => true
      end if
    end sub
    
    /'
      Executes a SQLite query.
      
      Only single statements are supported for now, so if you execute
      a query that has multiple statements, only the first one will
      be processed, so be careful with this.
    '/
    function _
      Connection.execute( _
        byref aSQLQuery as const string ) _
      as Auto_ptr( of( Query ) )
      
      var _
        rows => new List( of( TableRow ) )()
      
      if( available ) then
        dim as zstring ptr _
          errMsg
        
        dim as sqlite3_stmt ptr _
          stat
        
        var _
          result => sqlite3_prepare_v2( _
          _database, _
          aSQLQuery, _
          len( aSQLQuery ), _
          @stat, _
          0 )
        
        if( result <> SQLITE_OK ) then
          /'
            Do note that the SQLite interface doesn't provide a means to
            identify the error on a SQL query (it just provides a generic
            error code), so we return our own error message here but with
            this generic code.
          '/
          onError( "An error occurred during SQL query execution" )
        else
          '' Continue the query
          do while( sqlite3_step( stat ) = SQLITE_ROW )
            var _
              newRecord => new TableRow()
            
            for _
              i as integer => 0 _
              to sqlite3_column_count( stat ) - 1
              
              dim as string _
                colName => *sqlite3_column_origin_name( stat, i ), _
                colDataType, _
                colValue
              
              dim as uinteger _
                colSize
              
              select case as const( sqlite3_column_type( stat, i ) )
                case SQLITE_INTEGER
                  colValue => str( sqlite3_column_int64( stat, i ) )
                  colSize => 8
                
                case SQLITE_FLOAT
                  colValue => str( sqlite3_column_double( stat, i ) )
                  colSize => 8
                
                case SQLITE_BLOB
                  dim as ulong _
                    size => sqlite3_column_bytes( stat, i )
                  dim as const any ptr _
                    blob => sqlite3_column_blob( stat, i )
                  
                  colValue => space( size )
                  colSize => size
                  
                  memcpy( _
                    strPtr( colValue ), _
                    blob, _
                    size )
                  
                case SQLITE_NULL
                  colValue => ""
                  colSize => 0
                
                case SQLITE3_TEXT
                  dim as ulong _
                    size => sqlite3_column_bytes( stat, i )
                  dim as const ubyte ptr _
                    text => sqlite3_column_text( stat, i )
                  
                  colValue => space( size )
                  colSize => size
                  
                  memcpy( _
                    strPtr( colValue ), _
                    text, _
                    size )
              end select
              
              colDataType => *sqlite3_column_decltype( stat, i )
              
              newRecord->add( new TableColumn( _
                colName, _
                colValue, _
                colDataType, _
                colSize ) )
            next
            
            rows->add( newRecord )
          loop
        end if
        
        sqlite3_finalize( stat )
      end if
      
      return( Auto_ptr( of( Query ) )( new Query( rows ) ) )
    end function
    
    function _
      Connection.executeNonQuery( _
        byref aSQLQuery as const string ) _
      as integer
      
      if( available ) then
        dim as zstring ptr _
          errMsg
        
        if( sqlite3_exec( _
          _database, _
          aSQLQuery, _
          0, 0, _
          @errMsg ) <> SQLITE_OK ) then
          
          dim as string _
            errorMsg => *errMsg
          
          onError( errorMsg )
          
          sqlite3_free( errMsg )
        end if
        
        affectedRows => sqlite3_changes( _database )
      end if
      
      return( affectedRows )
    end function
  end namespace
end namespace

#endif
