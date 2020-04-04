#include once "fbfw-db-sqlite.bi"

/'
  SQLite connector example.
  
  Shows how to connect to a SQLite database. Note that the connector
  is for SQLite 3, and that the interface is exactly the same as the
  MySQL connector.
'/
using Database

randomize()

var _
  c => SQLite.Connection( "test.s3db" )

if( c.available ) then
  var _
    aQuery => c.execute( "SELECT * FROM `test-table`;" )
  
  if( aQuery->hasRows ) then
    for _
      i as integer => 0 _
      to aQuery->rowCount - 1
      
      for _
        j as integer => 0 _
        to aQuery->row( i ).colCount - 1
        
        ? aQuery->row( i ).col( j ).name; " "; _
          aQuery->row( i ).col( j ).dataType; " "; _
          aQuery->row( i ).col( j ).length
        ? aQuery->row( i ).col( j ).value
      next
    next
  else
    ? "Query returned no rows!"
    ? c.lastError
    ? c.lastErrorCode
  end if
  
  '' Use this code for updating/inserting records
  /'
  dim as string _
    query => "INSERT INTO `test-table` " + _
    "(`col_data`) VALUES (" + _
    "'Baz" + str( cubyte( rnd() * 255 ) ) + "');"
  
  '' Make a non-query
  ? c.executeNonQuery( query )
  '/
else
  ? "Could not connect!"
end if

sleep()
