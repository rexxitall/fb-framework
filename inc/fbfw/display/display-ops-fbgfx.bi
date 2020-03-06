#ifndef __FBFW_DRAWING_DISPLAYOPS_FBGFX__
#define __FBFW_DRAWING_DISPLAYOPS_FBGFX__

namespace Drawing
  /'
    FBGFX backend DisplayOps implementation
  '/
  namespace FBGFX
    type _
      DisplayOps _
      extends Drawing.DisplayOps
      
      public:
        declare constructor()
        declare constructor( _
          byval as integer )
        declare virtual destructor() override
        
        declare property _
          opName() as string override
        
        declare sub _
          opInit( _
            byval as integer, _
            byval as integer ) override
        declare sub _
          opInitFullScreen() override
        declare sub _
          opInitFullScreenLowest() override
        declare sub _
          opInitFullScreenHighest() override
        declare sub _
          opInitFullScreen( _
            byval as integer, _
            byval as integer ) override
        declare sub _
          opClear( _
            byval as Drawing.Surface ptr ) override
        declare sub _
          opClear( _
            byval as Drawing.Surface ptr, _
            byref as const Drawing.FbColor ) override
        declare sub _
          opClear( _
            byval as Drawing.Surface ptr, _
            byref as const Drawing.FbColor, _
            byref as const Drawing.FbColor ) override
        declare sub _
          opStartFrame( _
            byval as Drawing.Surface ptr ) override
        declare sub _
          opEndFrame( _
            byval as Drawing.Surface ptr ) override
        
        declare function _
          opCreateSurface( _
            byval as integer, _
            byval as integer ) _
          as Drawing.Surface ptr override
        declare function _
          opCreateGraphics( _
            byref as Drawing.Surface ) _
          as Graphics ptr override
        
        declare sub _
          opTextAt( _
            byval as Drawing.Surface ptr, _
            byval as integer, _
            byval as integer, _
            byref as const string ) override
        declare sub _
          opTextAt( _
            byval as Drawing.Surface ptr, _
            byval as integer, _
            byval as integer, _
            byref as const string, _
            byref as const Drawing.FbColor ) override
        declare sub _
          opTextAt( _
            byval as Drawing.Surface ptr, _
            byval as integer, _
            byval as integer, _
            byref as const string, _
            byref as const Drawing.FbColor, _
            byref as const Drawing.FbColor ) override
      
      protected:
        declare sub _
          initialize()
        declare sub _
          setMeasures( _
            byval as integer, _
            byval as integer )
          
        as integer _
          _fontWidth => 8, _
          _fontHeight => 16
        as boolean _
          _initialized
    end type
    
    constructor _
      DisplayOps()
      
      this.constructor( 0 )
    end constructor
    
    constructor _
      DisplayOps( _
        byval aFlags as integer )
      
      opFlags => aFlags and not Fb.GFX_FULLSCREEN
    end constructor
    
    destructor _
      DisplayOps()
    end destructor
    
    property _
      DisplayOps.opName() _
      as string
      
      return( "FBGFX" )
    end property
    
    sub _
      DisplayOps.initialize()
      
      if( not _initialized ) then
        dim as long _
          mode, w, h
        
        mode => screenList( 32 )
        
        do while( mode <> 0 )
          fullScreenModes.add( _
            new FullScreenModeInfo( _
              hiWord( mode ), _
              loWord( mode ), _
              32 ) )
          
          mode => screenList()
        loop
        
        _initialized => true
      end if
    end sub
    
    function _
      DisplayOps.opCreateSurface( _
        byval aWidth as integer, _
        byval aHeight as integer ) _
      as Drawing.Surface ptr
      
      return( new Drawing.Surface( _
        aWidth, aHeight ) )
    end function
    
    function _
      DisplayOps.opCreateGraphics( _
        byref aSurface as Drawing.Surface ) _
      as Graphics ptr
      
      return( FBGFX.Graphics.createFor( aSurface ) )
    end function
    
    sub _
      DisplayOps.setMeasures( _
        byval aWidth as integer, _
        byval aHeight as integer )
      
      opWidth => aWidth
      opHeight => aHeight
      opColumns => opWidth \ _fontWidth
      opRows => opHeight \ _fontHeight
      
      width opColumns, opRows
    end sub
    
    sub _
      DisplayOps.opInit( _
        byval aWidth as integer, _
        byval aHeight as integer )
      
      initialize()
      
      screenRes( _
        aWidth, aHeight, _
        32, , opFlags )
      
      setMeasures( aWidth, aHeight )
    end sub
    
    sub _
      DisplayOps.opInitFullScreen()
      
      initialize()
      
      var _
        maxRes => fullScreenModes.at( fullScreenModes.count - 1 )
      
      screenRes( _
        maxRes->width, _
        maxRes->height, _
        32, , opFlags )
      
      setMeasures( maxRes->width, maxRes->height )
    end sub
    
    sub _
      DisplayOps.opInitFullScreenLowest()
      
      initialize()
      
      var _
        minRes => fullScreenModes.at( 0 )
      
      screenRes( _
        minRes->width, _
        minRes->height, _
        32, , opFlags or Fb.GFX_FULLSCREEN )
      
      setMeasures( minRes->width, minRes->height )
    end sub
    
    sub _
      DisplayOps.opInitFullScreenHighest()
      
      initialize()
      
      var _
        maxRes => fullScreenModes.at( fullScreenModes.count - 1 )
      
      screenRes( _
        maxRes->width, _
        maxRes->height, _
        32, , opFlags or Fb.GFX_FULLSCREEN )
      
      setMeasures( maxRes->width, maxRes->height )
    end sub
    
    sub _
      DisplayOps.opInitFullScreen( _
        byval aWidth as integer, _
        byval aHeight as integer )
      
      initialize()
      
      var _
        closestRes => closestFullScreenResTo( aWidth, aHeight )
      
      screenRes( _
        closestRes->width, _
        closestRes->height, _
        32, , opFlags or Fb.GFX_FULLSCREEN )
      
      setMeasures( closestRes->width, closestRes->height )
    end sub
    
    sub _
      DisplayOps.opClear( _
        byval s as Drawing.Surface ptr )
      
      s->clear( opBackColor )
    end sub
    
    sub _
      DisplayOps.opClear( _
        byval s as Drawing.Surface ptr, _
        byref aBackColor as const Drawing.FbColor )
      
      opBackColor => aBackColor
      
      s->clear( opBackColor )
    end sub
    
    sub _
      DisplayOps.opClear( _
        byval s as Drawing.Surface ptr, _
        byref aForeColor as const Drawing.FbColor, _
        byref aBackColor as const Drawing.FbColor )
      
      opForeColor => aForeColor
      opBackColor => aBackColor
      
      s->clear( opBackColor )
    end sub
    
    sub _
      DisplayOps.opStartFrame( _
        byval s as Drawing.Surface ptr )
      
      screenLock()
    end sub
    
    sub _
      DisplayOps.opEndFrame( _
        byval s as Drawing.Surface ptr )
      
      put _
        ( 0, 0 ), _
        *s, pset
      
      screenUnlock()
      
      sleep( 1, 1 )
    end sub
    
    sub _
      DisplayOps.opTextAt( _
        byval s as Drawing.Surface ptr, _
        byval aCol as integer, _
        byval aRow as integer, _
        byref aText as const string )
      
      opTextAt( _
        s, aCol, aRow, aText, opForeColor, opBackColor )
    end sub
    
    sub _
      DisplayOps.opTextAt( _
        byval s as Drawing.Surface ptr, _
        byval aCol as integer, _
        byval aRow as integer, _
        byref aText as const string, _
        byref aForeColor as const Drawing.FbColor )
      
      opTextAt( _
        s, aCol, aRow, aText, aForeColor, opBackColor )
    end sub
    
    sub _
      DisplayOps.opTextAt( _
        byval s as Drawing.Surface ptr, _
        byval aCol as integer, _
        byval aRow as integer, _
        byref aText as const string, _
        byref aForeColor as const Drawing.FbColor, _
        byref aBackColor as const Drawing.FbColor )
      
      dim as integer _
        posX => ( aCol - 1 ) * _fontWidth, _
        posY => ( aRow - 1 ) * _fontHeight
      
      line _
        *s, _
        ( posX, posY ) - _
        ( ( posX + len( aText ) * _fontWidth ) - 1, _
          ( posY + _fontHeight - 1 ) ), _
        aBackColor, bf
      
      draw string _
        *s, _
        ( posX, posY ), _
        aText, _
        aForeColor
    end sub
  end namespace
end namespace

#endif