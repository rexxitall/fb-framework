#include once "fbfw-math.bi"

using Math

dim as integer _
  XRes => 800, _
  YRes => 600

screenRes( XRes, YRes, 32 )

var _
  T => Mat3.translation( Float2( -XRes / 2, -YRes / 2 ) ), _
  R => Mat3.rotation( 30.0 )

var _
  boxExtents => Float2( 50.0, 30.0 )

dim as ulong ptr _
  px => screenPtr()

dim as double _
  ft, sum
dim as uinteger _
  count

do
  ft => timer()
  
  screenLock()
    cls()
    
    for _
      y as integer => 0 _
      to YRes - 1
      
      for _
        x as integer => 0 _
        to XRes - 1
        
        var _
          p => R * T * Float2( x, y )
        
        dim as single _
          dist => udBox( p, boxExtents )
        
        if( dist <= 1 ) then
          px[ y * XRes + x ] => rgba( 255, 0, 0, 255 )
        end if
      next
    next
  screenUnlock()
  
  ft => timer() - ft
  sum +=> ft
  count +=> 1
  
  windowTitle( "FPS: " & int( 1.0! / ( sum / count ) ) )
  
  sleep( 1, 1 )
loop until( len( inkey() ) )
