#ifndef __FBFW_DRAWING_DISPLAYOPS__
#define __FBFW_DRAWING_DISPLAYOPS__

namespace Drawing
  /'
    Represent the operations that can be performed on a
    Display object. Used to implement independent graphic
    backends.
  '/
  type _
    DisplayOps _
    extends Object
    
    public:
      declare virtual destructor()
      
      declare virtual property _
        opName() as string
      declare virtual property _
        opWidth() as integer
      declare virtual property _
        opHeight() as integer
      declare virtual property _
        opForeColor() as Drawing.FbColor
      declare virtual property _
        opForeColor( _
          byref as const Drawing.FbColor )
      declare virtual property _
        opBackColor() as Drawing.FbColor
      declare virtual property _
        opBackColor( _
          byref as const Drawing.FbColor )
      declare virtual property _
        opRows() as integer
      declare virtual property _
        opColumns() as integer
      declare virtual property _
        opFlags() as integer
      
      declare abstract sub _
        opInit( _
          byval as integer, _
          byval as integer )
      declare abstract sub _
        opInitFullScreen()
      declare abstract sub _
        opInitFullScreenLowest()
      declare abstract sub _
        opInitFullScreenHighest()
      declare abstract sub _
        opInitFullScreen( _
          byval as integer, _
          byval as integer )
      declare abstract sub _
        opClear( _
          byval as Drawing.Surface ptr )
      declare abstract sub _
        opClear( _
          byval as Drawing.Surface ptr, _
          byref as const Drawing.FbColor )
      declare abstract sub _
        opClear( _
          byval as Drawing.Surface ptr, _
          byref as const Drawing.FbColor, _
          byref as const Drawing.FbColor )
      declare abstract sub _
        opStartFrame( _
          byval as Drawing.Surface ptr )
      declare abstract sub _
        opEndFrame( _
          byval as Drawing.Surface ptr )
      
      declare abstract function _
        opCreateSurface( _
          byval as integer, _
          byval as integer ) _
        as Drawing.Surface ptr
      declare abstract function _
        opCreateGraphics( _
          byref as Drawing.Surface ) _
        as Drawing.Graphics ptr
      
      declare abstract sub _
        opTextAt( _
          byval as Drawing.Surface ptr, _
          byval as integer, _
          byval as integer, _
          byref as const string )
      declare abstract sub _
        opTextAt( _
          byval as Drawing.Surface ptr, _
          byval as integer, _
          byval as integer, _
          byref as const string, _
          byref as const Drawing.FbColor )
      declare abstract sub _
        opTextAt( _
          byval as Drawing.Surface ptr, _
          byval as integer, _
          byval as integer, _
          byref as const string, _
          byref as const Drawing.FbColor, _
          byref as const Drawing.FbColor )
      
    protected:
      declare virtual property _
        opName( _
          byref as const string )
      declare virtual property _
        opWidth( _
          byval as integer )
      declare virtual property _
        opHeight( _
          byval as integer )
      declare virtual property _
        opRows( _
          byval as integer )
      declare virtual property _
        opColumns( _
          byval as integer )
      declare virtual property _
        opFlags( _
          byval as integer )
        
      declare property _
        fullScreenModes() _
        byref as List( of( FullScreenModeInfo ) )
      
      declare function _
        closestFullScreenResTo( _
          byval as integer, _
          byval as integer ) _
        as FullScreenModeInfo ptr
      
    private:
      as string _
        _name
      as integer _
        _width, _
        _height, _
        _flags, _
        _rows, _
        _columns, _
        _fontWidth => 8, _
        _fontHeight => 16
      as Drawing.FbColor _
        _foreColor => Drawing.FbColor.Gray, _
        _backColor => Drawing.FbColor.Black
      
      as List( of( FullScreenModeInfo ) ) ptr _
        _fullScreenModes => new List( of( FullScreenModeInfo ) )()
  end type
  
  destructor _
    DisplayOps()
    
    delete( _fullScreenModes )
  end destructor
  
  property _
    DisplayOps.opName() _
    as string
    
    return( _name )
  end property
  
  property _
    DisplayOps.opName( _
      byref value as const string )
    
    _name => value
  end property
  
  property _
    DisplayOps.opWidth() _
    as integer
    
    return( _width )
  end property
  
  property _
    DisplayOps.opWidth( _
      byval value as integer )
    
    _width => value
  end property
  
  property _
    DisplayOps.opHeight() _
    as integer
    
    return( _height )
  end property
  
  property _
    DisplayOps.opHeight( _
      byval value as integer )
    
    _height => value
  end property
  
  property _
    DisplayOps.opForeColor() _
    as Drawing.FbColor
    
    return( _foreColor )
  end property
  
  property _
    DisplayOps.opForeColor( _
      byref value as const Drawing.FbColor )
    
    _foreColor => value
  end property
  
  property _
    DisplayOps.opBackColor() _
    as Drawing.FbColor
    
    return( _backColor )
  end property
  
  property _
    DisplayOps.opBackColor( _
      byref value as const Drawing.FbColor )
    
    _backColor => value
  end property
  
  property _
    DisplayOps.opRows() _
    as integer
    
    return( _rows )
  end property
  
  property _
    DisplayOps.opRows( _
      byval value as integer )
    
    _rows => value
  end property
  
  property _
    DisplayOps.opColumns() _
    as integer
    
    return( _columns )
  end property
  
  property _
    DisplayOps.opColumns( _
      byval value as integer )
    
    _columns => value
  end property
  
  property _
    DisplayOps.opFlags() _
    as integer
    
    return( _flags )
  end property
  
  property _
    DisplayOps.opFlags( _
      byval value as integer )
    
    _flags => value
  end property
  
  property _
    DisplayOps.fullScreenModes() _
    byref as List( of( FullScreenModeInfo ) )
    
    return( *_fullScreenModes )
  end property
  
  function _
    DisplayOps.closestFullScreenResTo( _
      byval aWidth as integer, _
      byval aHeight as integer ) _
    as FullScreenModeInfo ptr
    
    dim as integer _
      closest => 99999, _
      index
    
    for _
      i as integer => 0 _
      to _fullScreenModes->count - 1
      
      dim as integer _
        dist => _
          ( aWidth - _fullScreenModes->at( i )->width ) ^ 2 + _
          ( aHeight - _fullScreenModes->at( i )->height ) ^ 2 
      
      if( _
        dist <= closest ) then
        
        index => i
        closest => dist
      end if
    next
    
    return( _fullScreenModes->at( index ) )
  end function
end namespace

#endif
