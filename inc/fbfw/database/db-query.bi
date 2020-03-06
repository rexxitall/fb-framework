#ifndef __FBFW_DATABASE_QUERY__
#define __FBFW_DATABASE_QUERY__

#include once "db-table-row.bi"

namespace Database
  /'
    Represents the results of a database query, arranged in
    rows and columns.
  '/
  type _
    Query _
    extends Object
    
    public:
      declare constructor( _
        byval as List( of( TableRow ) ) ptr )
      declare virtual destructor()
      
      declare property _
        hasRows() as boolean
      declare property _
        rowCount() as integer
      declare property _
        row( _
          byval as integer ) _
        byref as TableRow
      
    protected:
      declare constructor()
      
      as List( of( TableRow ) ) ptr _
        _rows
  end type
  
  constructor _
    Query()
  end constructor
  
  constructor _
    Query( _
      byval aList as List( of( TableRow ) ) ptr )
    
    _rows => aList
  end constructor
  
  destructor _
    Query()
    
    delete( _rows )
  end destructor
  
  property _
    Query.hasRows() _
    as boolean
    
    return( cbool( _rows->count > 0 ) )
  end property
  
  property _
    Query.rowCount() _
    as integer
    
    return( _rows->count )
  end property
  
  property _
    Query.row( _
      byval index as integer ) _
    byref as TableRow
    
    return( *_rows->at( index ) )
  end property
  
  template( Auto_ptr, of( Query ) )
end namespace

#endif
