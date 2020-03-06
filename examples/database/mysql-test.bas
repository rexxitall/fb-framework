#include once "fbfw-db-mysql.bi"

using Database

'' Change these to suit yours
var _
  c => MySqlDb.Connection( _
    "databaseName", _
    "userName", _
    "password" )

if( c.available ) then
  var _
    aQuery => c.execute( "SELECT * FROM `some-table`;" )
  
  if( aQuery->hasRows ) then
    for _
      i as integer => 0 _
      to aQuery->rowCount - 1
      
      for _
        j as integer => 0 _
        to aQuery->row( i ).colCount - 1
        
        with aQuery->row( i ).col( j )
          ? .name; " " + .dataType + " " & .length
          
          if( .length > 0 ) then
            ? .value
          end if
        end with
      next
    next
  end if
  
  /'
  dim as string _
    query => "INSERT INTO `database`.`table` " + _
    "(`cols`) VALUES " + _
    "('" + colValues + "');"
  
  '' Make a non-query
  ? c.executeNonQuery( query )
  '/
else
  ? "Could not connect!"
end if

sleep()
