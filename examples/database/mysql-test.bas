#include once "fbfw-db-mysql.bi"

/'
  MySQL connector example.
  
  Shows how to connect to a MySQL database. Upon installing MySQL Server
  on your computer, it also comes with a test database you can use
  to test queries against, which is what I use here.
'/
using Database

'' Change these to suit yours
var _
  c => MySqlDb.Connection( _
    "world", _
    "root", _
    "xxxx" )

if( c.available ) then
  var _
    aQuery => c.execute( "SELECT * FROM `city` LIMIT 10;" )
  
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
  
  '' Use this code for updating/inserting records
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
