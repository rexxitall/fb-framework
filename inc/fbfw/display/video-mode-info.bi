#ifndef __FBFW_DISPLAY_VIDEOMODEINFO__
#define __FBFW_DISPLAY_VIDEOMODEINFO__

namespace Display
  /'
    Encapsulates info about supported full screen modes
  '/
  type _
    VideoModeInfo
    
    public:
      declare constructor( _
        byval as long, _
        byval as long, _
        byval as long => 32 )
      declare destructor()
      
      declare operator _
        cast() as string
      
      declare property _
        width() as long
      declare property _
        height() as long
      declare property _
        depth() as long
      
    private:
      declare constructor()
      
      as long _
        _width, _
        _height, _
        _depth
  end type
  
  constructor _
    VideoModeInfo()
  end constructor
  
  constructor _
    VideoModeInfo( _
      byval aWidth as long, _
      byval aHeight as long, _
      byval aDepth as long )
    
    _width => aWidth
    _height => aHeight
    _depth => aDepth
  end constructor
  
  destructor _
    VideoModeInfo()
  end destructor
  
  property _
    VideoModeInfo.width() _
    as long
    
    return( _width )
  end property
  
  property _
    VideoModeInfo.height() _
    as long
    
    return( _height )
  end property
  
  property _
    VideoModeInfo.depth() _
    as long
    
    return( _depth )
  end property
  
  operator _
    VideoModeInfo.cast() _
    as string
    
    return( "{" & _width & "x" & _height & "x" & _depth & "}" )
  end operator
  
  operator _
    =( _
      byref lhs as VideoModeInfo, _
      byref rhs as VideoModeInfo ) _
    as integer
    
    return( _
      cbool( lhs.width = rhs.width ) andAlso _
      cbool( lhs.height = rhs.height ) andAlso _
      cbool( lhs.depth = rhs.depth ) )
  end operator
  
  template( List, of( VideoModeInfo ) )
end namespace

#endif
