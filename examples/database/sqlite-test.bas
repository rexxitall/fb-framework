#include once "fbfw-db-sqlite.bi"

randomize()

using Database

var _
  c => SQLite.Connection( "test-db.sdb" )

if( c.available ) then
  var _
    aQuery => c.execute( "SELECT * FROM `test-types`;" )
  
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
