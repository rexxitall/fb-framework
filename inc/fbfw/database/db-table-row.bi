#ifndef __FBFW_DATABASE_TABLE_ROW__
#define __FBFW_DATABASE_TABLE_ROW__

#include once "db-table-col.bi"

namespace Database
  /'
    Represents a row (or record) on a database table
  '/
  type _
    TableRow
    
    public:
      declare constructor()
      declare destructor()
      
      declare property _
        colCount() as integer
      declare property _
        col( _
          byval as integer ) _
        byref as TableColumn
      declare property _
        col( _
          byref as const string ) _
        byref as TableColumn
      
      declare sub _
        add( _
          byval as TableColumn ptr )
      declare function _
        clone() as TableRow ptr
      
    private:
      declare constructor( _
        byval as Dictionary( _
          of( string), of( TableColumn ) ) ptr, _
        byval as List( of( TableColumn ) ) ptr )
      
      as Dictionary( _
        of( string ), _
        of( TableColumn ) ) ptr _
        _columnsDic
      as List( of( TableColumn ) ) ptr _
        _columns
  end type
  
  constructor _
    TableRow()
    
    _columnsDic => new Dictionary( _
      of( string ), of( TableColumn ) )( 16 )
    _columns => new List( of( TableColumn ) )()
  end constructor
  
  constructor _
    TableRow( _
      byval aDictionary as Dictionary( _
        of( string ), of( TableColumn ) ) ptr, _
      byval aList as List( of( TableColumn ) ) ptr )
    
    _columnsDic => aDictionary
    _columns => aList
  end constructor
  
  destructor _
    TableRow()
    
    delete( _columnsDic )
    delete( _columns )
  end destructor
  
  property _
    TableRow.colCount() _
    as integer
    
    return( _columns->count )
  end property
  
  property _
    TableRow.col( _
      byval index as integer ) _
    byref as TableColumn
    
    return( *_columns->at( index ) )
  end property
  
  property _
    TableRow.col( _
      byref key as const string ) _
    byref as TableColumn
    
    return( *_columnsDic->find( lcase( key ) ) )
  end property
  
  sub _
    TableRow.add( _
      byval aCol as TableColumn ptr )
    
    _columnsDic->add( lcase( aCol->name ), *aCol )
    _columns->add( aCol )
  end sub
  
  function _
    TableRow.clone() _
    as TableRow ptr
    
    var _
      aColDic => new Dictionary( _
        of( string ), of( TableColumn ) )( 16 ), _
      aColList => new List( of( TableColumn ) )(), _
      cols => *_columns->elements
    
    for _
      i as integer => 0 _
      to _columns->count - 1
      
      var _
        aCol => cols[ i ]._item->clone()
      
      aColDic->add( lcase( aCol->name ), *aCol )
      aColList->add( aCol )
    next
    
    return( new TableRow( aColDic, aColList ) )
  end function
  
  template( List, of( TableRow ) )
end namespace

#endif
