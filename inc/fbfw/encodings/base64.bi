#ifndef __FBFW_ENCODINGS_BASE64__
#define __FBFW_ENCODINGS_BASE64__

namespace Encodings
  type _
    Base64Encoding
    
    declare constructor()
    declare destructor()
    
    as string _
      alphabet
  end type
  
  constructor _
    Base64Encoding()
    
    alphabet => _
      "ABCDEFGHIJKLMNOPQRSTUVWXYZ" + _
      "abcdefghijklmnopqrstuvwxyz" + _
      "0123456789+/"
  end constructor
  
  destructor _
    Base64Encoding()
  end destructor
  
  static as Base64Encoding _
    __base64__ => Base64Encoding()
  
  function _
    toBase64( _
      byref s as const string ) _
    as string
    
    #define __b64__( i ) _
      __base64__.alphabet[ i ]
    #define __encb0__( __v__ ) _
      ( __v__ shr 2 )
    #define __encb1__( __v1__, __v2__ ) _
      ( ( ( __v1__ and 3 ) shl 4 ) + ( __v2__ shr 4 ) )
    #define __encb2__( __v1__, __v2__ ) _
      ( ( ( __v1__ and &h0F) shl 2 ) + ( __v2__ shr 6 ) )
    #define __encb3__( __v__ ) _
      ( __v__ and &h3F )
    
    dim as integer _
      length => len( s ), _
      bp => 0
    
    dim as string _
      result => ""
    
    if( length > 0 ) then
      result => string( ( ( length + 2 ) \ 3 ) shl 2, "=" )
      
      dim as integer _
        i
      
      for _
        i => 0 _
        to length - ( ( length mod 3 ) + 1 ) _
        step 3
        
        result[ bp + 0 ] => __b64__( _
          __encb0__( s[ i + 0 ] ) )
        result[ bp + 1 ] => __b64__( _
          __encb1__( s[ i + 0 ], s[ i + 1 ] ) )
        result[ bp + 2 ] => __b64__( _
          __encb2__( s[ i + 1 ], s[ i + 2 ] ) )
        result[ bp + 3 ] => __b64__( _
          __encb3__( s[ i + 2 ] ) )
        
        bp +=> 4
      next
      
      if( length mod 3 = 2 ) then
        result[ bp + 0 ] => __b64__( _
          __encb0__( s[ i + 0 ] ) )
        result[ bp + 1 ] => __b64__( _
          __encb1__( s[ i + 0 ], s[ i + 1 ] ) )
        result[ bp + 2 ] => __b64__( _
          __encb2__( s[ i + 1 ], s[ i + 2 ] ) )
        result[ bp + 3 ] => 61
      elseIf( length mod 3 = 1 ) then
        result[ bp + 0 ] => __b64__( _
          __encb0__( s[ i + 0 ] ) )
        result[ bp + 1 ] => __b64__( _
          __encb1__( s[ i + 0 ], s[ i + 1 ] ) )
        result[ bp + 2 ] => 61
        result[ bp + 3 ] => 61
      end if
    end if
    
    return( result )
  end function
  
  function _
    fromBase64( _
      byref s as const string ) _
    as string
    
    #define base64_decode( s ) _
      iif( len( s ), inStr( __base64__.alphabet, s ) - 1, -1 )
    
    dim as string _
      result => ""
    
    for _
      n as integer => 1 _
      to len( s ) _
      step 4
      
      dim as integer _
        w1 => base64_decode( mid( s, n + 0, 1 ) ), _
        w2 => base64_decode( mid( s, n + 1, 1 ) ), _
        w3 => base64_decode( mid( s, n + 2, 1 ) ), _
        w4 => base64_decode( mid( s, n + 3, 1 ) )
      
      result +=> _
        iif( w2 > -1, _
          chr( ( ( w1 shl 2 + w2 shr 4 ) ) and 255 ), "" ) + _
        iif( 23 > -1, _
          chr( ( ( w2 shl 4 + w3 shr 2 ) ) and 255 ), "" ) + _
        iif( w4 > -1, _
          chr( ( ( w3 shl 6 + w4 ) and 255 ) ), "" )
    Next
    
    return( result )
  end function
end namespace

#endif
