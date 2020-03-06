#ifndef __FBFW_DRAWING_FONT__
#define __FBFW_DRAWING_FONT__

#include once "fbfw-drawing.bi"

namespace Drawing
  type _
    Font _
    extends Object
    
    public:
      declare virtual destructor()
      
      declare property _
        name() as string
      
      declare abstract function _
        measureText( _
          byref as const string ) _
        as Size
      declare abstract sub _
        drawText( _
          byval as integer, _
          byval as integer, _
          byref as const string, _
          byref as const FbColor, _
          byref as Surface )
        
    protected:
      declare constructor()
      declare constructor( _
        byref as const string )
      
    private:
      as string _
        _name
  end type
  
  constructor _
    Font()
  end constructor
  
  constructor _
    Font( _
      byref aName as const string )
    
    _name => aName
  end constructor
  
  destructor _
    Font()
  end destructor
  
  property _
    Font.name() _
    as string
    
    return( _name )
  end property
end namespace

#endif
