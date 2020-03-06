#ifndef __FBFW_DATABASE_TABLE_COLUMN__
#define __FBFW_DATABASE_TABLE_COLUMN__

namespace Database
  template( List, of( string ) )
  
  /'
    Represents a column (or field) on a database table
  '/
  type _
    TableColumn
    
    public:
      declare constructor( _
        byref as const string, _
        byref as const string )
      declare constructor( _
        byref as const string, _
        byref as const string, _
        byval as uinteger )
      declare constructor( _
        byref as const string, _
        byref as const string, _
        byref as const string, _
        byval as uinteger )
      declare destructor()
    
    declare property _
      name() as string
    declare property _
      value() byref as string
    declare property _
      dataType() as string
    declare property _
      length() as uinteger
    
    declare function _
      clone() as TableColumn ptr
    
    private:
      declare constructor()
      
      as string _
        _name, _
        _value, _
        _dataType
      as uinteger _
        _length
  end type
  
  constructor _
    TableColumn()
  end constructor
  
  constructor _
    TableColumn( _
      byref aName as const string, _
      byref aValue as const string )
    
    this.constructor( _
      aName, aValue, "<unknown>", 0 )
  end constructor
  
  constructor _
    TableColumn( _
      byref aName as const string, _
      byref aValue as const string, _
      byval aLength as uinteger )
    
    this.constructor( _
      aName, aValue, "<unknown>", aLength )
  end constructor
  
  constructor _
    TableColumn( _
      byref aName as const string, _
      byref aValue as const string, _
      byref aDataType as const string, _
      byval aLength as uinteger )
    
    _name => aName
    _value => aValue
    _dataType => aDataType
    _length => aLength
  end constructor
  
  destructor _
    TableColumn()
  end destructor
  
  property _
    TableColumn.name() _
    as string
    
    return( _name )
  end property
  
  property _
    TableColumn.value() _
    byref as string
    
    return( _value )
  end property
  
  property _ 
    TableColumn.dataType() _
    as string
    
    return( _dataType )
  end property
  
  property _
    TableColumn.length() _
    as uinteger
    
    return( _length )
  end property
  
  function _
    TableColumn.clone() _
    as TableColumn ptr
    
    return( new TableColumn( _
      _name, _value, _dataType, _length ) )
  end function
  
  template( List, of( TableColumn ) )
  template( Dictionary, _
    of( string ), of( TableColumn ) )
end namespace

#endif
