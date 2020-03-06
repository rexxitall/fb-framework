#ifndef __FBFW_MYSQL8_CONNECTION__
#define __FBFW_MYSQL8_CONNECTION__

#include once "crt.bi"

namespace Database
  namespace MySqlDb
    /'
      Database connector for MySQL 8.x
    '/
    type _
      Connection _
      extends Database.Connection
      
      public:
        declare constructor()
        declare constructor( _
          byref as const string, _
          byref as const string, _
          byref as const string, _
          byval as ulong => 0 )
        declare constructor( _
          byref as const string, _
          byref as const string, _
          byref as const string, _
          byref as const string, _
          byval as ulong => 0 )
        declare virtual destructor() override
        
        declare operator _
          cast() as MYSQL ptr
        
        declare property _
          lastErrorCode() as ulong
        declare property _
          affectedRows() as integer
        
        declare virtual sub _
          connect( _
            byref as const string, _
            byref as const string, _
            byref as const string, _
            byval as ulong )
        declare virtual sub _
          connect( _
            byref as const string, _
            byref as const string, _
            byref as const string, _
            byref as const string, _
            byval as ulong )
          
        declare virtual function _
          execute( _
            byref as const string ) _
          as Auto_ptr( of( Query ) ) override
        declare virtual function _
          executeNonQuery( _
            byref as const string ) _
          as integer override
        
      protected:
        declare property _
          lastErrorCode( _
            byval as ulong )
        declare property _
          affectedRows( _
            byval as integer )
          
        declare virtual sub _
          onError( _
            byref as string ) override
          
      private:
        declare function _
          fieldTypeToString( _
            byval as enum_field_types ) _
          as string
          
        as MYSQL ptr _
          _database
        as integer _
          _affectedRows
        as ulong _
          _lastErrorCode
    end type
    
    /'
      IMPORTANT NOTE: 
        mysql_init() is NOT thread-safe. Excerpt from the MySQL Documentation:
      
      "In a nonmultithreaded environment, mysql_init() invokes mysql_library_init()
      automatically as necessary. However, mysql_library_init() is not thread-safe
      in a multithreaded environment, and thus neither is mysql_init(). Before
      calling mysql_init(), either call mysql_library_init() prior to spawning any
      threads, or use a mutex to protect the mysql_library_init() call. This should
      be done prior to any other client library call."
      
      We don't need to pass anything relevant to the parameter (it accepts a MYSQL
      ptr, that it then initializes and return its address; if we pass null, the
      function just creates one and returns it).
    '/
    constructor _
      Connection()
      
      base()
    end constructor
    
    constructor _
      Connection( _
        byref aDatabaseName as const string, _
        byref aUserName as const string, _
        byref aPassword as const string, _
        byval aPort as ulong => 0 )
      
      base()
      
      connect( _
        "", _
        aDatabaseName, _
        aUserName, _
        aPassword, _
        aPort )
    end constructor
    
    constructor _
      Connection( _
        byref aHost as const string, _
        byref aDatabaseName as const string, _
        byref aUserName as const string, _
        byref aPassword as const string, _
        byval aPort as ulong => 0 )
      
      base()
      
      connect( _
        aHost, _
        aDatabaseName, _
        aUserName, _
        aPassword, _
        aPort )
    end constructor
    
    destructor _
      Connection()
      
      mysql_close( _database )
    end destructor
    
    operator _
      Connection.cast() _
      as MYSQL ptr
      
      return( _database )
    end operator
    
    property _
      Connection.lastErrorCode() _
      as ulong
      
      return( _lastErrorCode )
    end property
    
    property _
      Connection.lastErrorCode( _
        byval value as ulong )
      
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
    
    function _
      Connection.fieldTypeToString( _
        byval fieldType as enum_field_types ) _
      as string
      
      dim as string _
        result => "<unknown>"
      
      select case as const( fieldType )
      	case FIELD_TYPE_DECIMAL
      	  result => "DECIMAL"
      	
      	case FIELD_TYPE_TINY
      	  result => "TINY"
      	
      	case FIELD_TYPE_SHORT
      	  result => "SHORT"
      	
      	case FIELD_TYPE_LONG
      	  result => "LONG"
      	
      	case FIELD_TYPE_FLOAT
      	  result => "FLOAT"
      	
      	case FIELD_TYPE_DOUBLE
      	  result => "DOUBLE"
      	
      	case FIELD_TYPE_NULL
      	  result => "NULL"
      	
      	case FIELD_TYPE_TIMESTAMP
      	  result => "TIMESTAMP"
      	
      	case FIELD_TYPE_LONGLONG
      	  result => "LONGLONG"
      	
      	case FIELD_TYPE_INT24
      	  result => "INT24"
      	
      	case FIELD_TYPE_DATE
      	  result => "DATE"
      	
      	case FIELD_TYPE_TIME
      	  result => "TIME"
      	
      	case FIELD_TYPE_DATETIME
      	  result => "DATETIME"
      	
      	case FIELD_TYPE_YEAR
      	  result => "YEAR"
      	
      	case FIELD_TYPE_NEWDATE
      	  result => "NEWDATE"
      	
      	case FIELD_TYPE_VARCHAR
      	  result => "VARCHAR"
      	
      	case FIELD_TYPE_BIT
      	  result => "BIT"
      	
      	case FIELD_TYPE_TIME2
      	  result => "TIME2"
      	
      	case FIELD_TYPE_JSON
      	  result => "JSON"
      	
      	case FIELD_TYPE_NEWDECIMAL
      	  result => "NEWDECIMAL"
      	
      	case FIELD_TYPE_ENUM
      	  result => "ENUM"
      	
      	case FIELD_TYPE_SET
      	  result => "SET"
      	
      	case FIELD_TYPE_TINY_BLOB
      	  result => "TINYBLOB"
      	
      	case FIELD_TYPE_MEDIUM_BLOB
      	  result => "MEDIUMBLOB"
      	
      	case FIELD_TYPE_LONG_BLOB
      	  result => "LONGBLOB"
      	
      	case FIELD_TYPE_BLOB
      	  result => "BLOB"
      	
      	case FIELD_TYPE_VAR_STRING
      	  result => "VARSTRING"
      	
      	case FIELD_TYPE_STRING
      	  result => "STRING"
      	
      	case FIELD_TYPE_GEOMETRY
      	  result => "GEOMETRY"
      end select
      
      return( result )
    end function
    
    sub _
      Connection.onError( _
        byref anErrorMessage as string )
      
      lastError => anErrorMessage
      lastErrorCode => mysql_errno( _database )
      
      raiseEvent( _
        DatabaseError, _
        DatabaseErrorEventArgs( _
          lastError, _
          lastErrorCode ) )
    end sub
    
    /'
      Connect to local host
    '/
    sub _
      Connection.connect( _
        byref aDatabaseName as const string, _
        byref aUserName as const string, _
        byref aPassword as const string, _
        byval aPort as ulong => 0 )
      
      connect( _
        "", _
        aDatabaseName, _
        aUserName, _
        aPassword, _
        aPort )
    end sub
    
    /'
      Connect to remote host
    '/
    sub _
      Connection.connect( _
        byref aHost as const string, _
        byref aDatabaseName as const string, _
        byref aUserName as const string, _
        byref aPassword as const string, _
        byval aPort as ulong => 0 )
      
      if( available ) then
        mysql_close( _database )
      end if
      
      _database => mysql_init( 0 )
      
      dim as MYSQL ptr _
        result => mysql_real_connect( _
          _database, _
          aHost, _
          aUsername, _
          aPassword, _
          aDatabaseName, _
          iif( aPort = 0, _
            MYSQL_PORT, _
            aPort ), _
          0, 0 )
      
      if( result = _database ) then
        available => true
      end if
      
      if( not available ) then
        onError( *mysql_error( _database ) )
      end if
    end sub
    
    function _
      Connection.execute( _
        byref aSQLQuery as const string ) _
      as Auto_ptr( of( Query ) )
      
      var _
        rows => new List( of( TableRow ) )()
      
      if( available ) then
        /'
          Make the query and report the error if unsuccessful. Note we use
          'mysql_real_query()' and not 'mysql_query()' since the latter uses
          null-terminated strings and thus cannot be used with binary data.
        '/
        if( mysql_real_query( _
          _database, _
          aSQLQuery, _
          len( aSQLQuery ) ) ) then
          
          onError( *mysql_error( _database ) )
        else
          /'
            Process the query. We need to fetch the query once made, to be
            able to free the buffer on the MySQL database for further queries.
            If we don't do this (even though the query may be invalid), further
            calls to 'mysql_real_query()' return with errors.
          '/
          dim as MYSQL_RES ptr _
            result => mysql_store_result( _database )
          
          if( result ) then
            '' There are actually rows to retrieve, do so
            dim as integer _
              fields => mysql_num_fields( result )
            dim as MYSQL_ROW _
              row => mysql_fetch_row( result )
            
            '' Fetch all the rows from the returned set
            do while( row <> 0 )
              var _
                newRecord => new TableRow()
              
              '' Fetch all the fields from the current row
              for _
                i as integer => 0 to _
                fields - 1 
                
                dim as MYSQL_FIELD ptr _
                  fieldData
                
                fieldData => mysql_fetch_field_direct( result, i )
                
                dim as string _
                  fieldValue => ""
                
                if( row[ i ] <> 0 ) then
                  fieldValue => space( fieldData->max_length )
                  
                  memcpy( _
                    strPtr( fieldValue ), _
                    row[ i ], _
                    fieldData->max_length )
                end if
                
                newRecord->add( new TableColumn( _
                  *fieldData->org_name, _
                  fieldValue, _
                  fieldTypeToString( fieldData->type ), _
                  len( fieldValue ) ) )
              next 
              
              '' Add the retrieved row
              rows->add( newRecord )
              
              '' And continue seeking
              row => mysql_fetch_row( result )
            loop
            
            /'
              Free the last query
            '/
            mysql_free_result( result )
          else
            '' The query returned nothing. Should it have?
            if( mysql_errno( _database ) ) then
              '' Report the error
              onError( *mysql_error( _database ) )
            elseif( mysql_field_count( _database ) = 0 ) then
              /'
                Query isn't supposed to return data (it was not a 'SELECT'
                statement)
              '/
              affectedRows => mysql_affected_rows( _database )
            end if
          end if
        end if
      end if
      
      return( Auto_ptr( of( Query ) )( new Query( rows ) ) )
    end function
    
    function _
      Connection.executeNonQuery( _
        byref aSQLQuery as const string ) _
      as integer
      
      if( available ) then
        if( mysql_real_query( _
          _database, _
          aSQLQuery, _
          len( aSQLQuery ) ) ) then
          
          onError( *mysql_error( _database ) )
        else
          affectedRows => mysql_affected_rows( _database )
        end if
      end if
      
      return( affectedRows )
    end function
  end namespace
end namespace

#endif
