#ifndef __FBFW_MATH_FLOAT2__
#define __FBFW_MATH_FLOAT2__

namespace Math
  /'
    2D vector
    
    | x |
    | y |
  '/
  type _
    Float2
    
    declare constructor()
    declare constructor( _
      byval as float => 0.0, _
      byval as float => 0.0 )
    declare constructor( _
      byref as Float2 )
    declare destructor()
    
    declare operator _
      let( byref as Float2 )
    declare operator _
      cast() as string
    
    '' Swizzlings
    declare function yx() as Float2
    declare function xx() as Float2
    declare function yy() as Float2
    
    '' Convenience functions
    declare function _
      sideDistance( _
        byref as const Float2, _
        byref as const Float2 ) _
      as float
    declare function _
      dot( byref as Float2 ) as float
    declare function _
      cross( byref as Float2 ) as float
    declare function _
      length() as float
    declare sub _
      setLength( byval as float )
    declare function _
      ofLength( byval as float ) as Float2
    declare function _
      squaredLength() as float
    declare function _
      normalized() as Float2
    declare sub _
      normalize()
    declare sub _
      turnLeft()
    declare function _
      turnedLeft() as Float2
    declare sub _
      turnRight()
    declare function _
      turnedRight() as Float2
    declare sub _
      rotate( byval as Math.Radians )
    declare function _
      rotated( byval as Math.Radians ) as Math.Float2
    declare function _
      angle() as Math.Radians
    declare function _
      distance( byref as Float2 ) as float
    declare function _
      squaredDistance( byref as Float2 ) as float
    declare sub _
      lookAt( byref as Float2 )
    
    as float _
      x, y
  end type
  
  constructor Float2() 
    x => 0.0
    y => 0.0
  end constructor
  
  constructor Float2( _
    byval nx as float => 0.0, _
    byval ny as float => 0.0 ) 
    
    x => nx
    y => ny
  end constructor
  
  constructor Float2( _
    byref rhs as Float2 ) 
    
    x => rhs.x
    y => rhs.y
  end constructor
  
  destructor _
    Float2()
  end destructor
  
  operator Float2.let( _
    byref rhs as Float2 ) 
    
    x => rhs.x
    y => rhs.y
  end operator
  
  operator Float2.cast() as string 
    return(	_
      "| " & str( x ) & " |" & chr( 10 ) & chr( 13 ) & _
      "| " & str( y ) & " |" & chr( 10 ) & chr( 13 ) )
  end operator
  
  '' Swizzlings
  function Float2.yx() as Float2
    return( Float2( y, x ) )
  end function
  
  function Float2.xx() as Float2
    return( Float2( x, x ) )
  end function
  
  function Float2.yy() as Float2
    return( Float2( y, y ) )
  end function
  
  '' Basic arithmetic operators
  operator + ( _
    byref lhs as Float2, _
    byref rhs as Float2 ) as Float2 
    
    return( Float2( lhs.x + rhs.x, lhs.y + rhs.y ) )
  end operator
  
  operator + ( _
    byref lhs as Float2, _
    byref rhs as float ) as Float2 
    
    return( Float2( lhs.x + rhs, lhs.y + rhs ) )
  end operator
  
  operator + ( _
    byref lhs as float, _
    byref rhs as Float2 ) as Float2 
    
    return( Float2( lhs + rhs.x, lhs + rhs.y ) )
  end operator
  
  operator - ( _
    byref lhs as Float2, _
    byref rhs as Float2 ) as Float2 
    
    return( Float2( lhs.x - rhs.x, lhs.y - rhs.y ) )
  end operator
  
  operator - ( _
    byref lhs as Float2, _
    byref rhs as float ) as Float2 
    
    return( Float2( lhs.x - rhs, lhs.y - rhs ) )
  end operator
  
  operator - ( _
    byref lhs as float, _
    byref rhs as Float2 ) as Float2 
    
    return( Float2( lhs - rhs.x, lhs - rhs.y ) )
  end operator
  
  operator - ( byref lhs as Float2 ) as Float2 
    return( Float2( -lhs.x, -lhs.y ) )
  end operator
  
  operator * ( _
    byref lhs as Float2, _
    byref rhs as Float2 ) as Float2 
    
    return( Float2( lhs.x * rhs.x, lhs.y * rhs.y ) )
  end operator
  
  operator * ( _
    byref lhs as Float2, _
    byref rhs as float ) as Float2 
    
    return( Float2( lhs.x * rhs, lhs.y * rhs ) )
  end operator
  
  operator * ( _
    byref lhs as float, _
    byref rhs as Float2 ) as Float2 
    
    return( Float2( lhs * rhs.x, lhs * rhs.y ) )
  end operator
  
  operator * ( _
    byref lhs as Float2, _
    byref rhs as integer ) as Float2 
    
    return( Float2( lhs.x * rhs, lhs.y * rhs ) )
  end operator
  
  operator * ( _
    byref lhs as integer, _
    byref rhs as Float2 ) as Float2 
    
    return( Float2( lhs * rhs.x, lhs * rhs.y ) )
  end operator
  
  operator / ( _
    byref lhs as Float2, _
    byref rhs as Float2 ) as Float2 
    
    return( Float2( lhs.x / rhs.x, lhs.y / rhs.y ) )
  end operator
  
  operator / ( _
    byref lhs as Float2, _
    byref rhs as float ) as Float2 
    
    return( Float2( lhs.x / rhs, lhs.y / rhs ) )
  end operator
  
  operator \ ( _
    byref lhs as Float2, _
    byref rhs as integer ) as Float2 
    
    return( Float2( lhs.x \ rhs, lhs.y \ rhs ) )
  end operator
  
  operator > ( _
    byref lhs as Float2, _
    byref rhs as Float2 ) as integer
    
    return( _
      lhs.x > rhs.x andAlso _
      lhs.y > rhs.y )
  end operator
  
  operator < ( _
    byref lhs as Float2, _
    byref rhs as Float2 ) as integer
    
    return( _
      lhs.x < rhs.x andAlso _
      lhs.y < rhs.y )
  end operator

  operator <= ( _
    byref lhs as Float2, _
    byref rhs as Float2 ) as integer
    
    return( _
      lhs.x <= rhs.x andAlso _
      lhs.y <= rhs.y )
  end operator
  
  operator >= ( _
    byref lhs as Float2, _
    byref rhs as Float2 ) as integer
    
    return( _
      lhs.x >= rhs.x andAlso _
      lhs.y >= rhs.y )
  end operator
  
  operator <> ( _
    byref lhs as Float2, _
    byref rhs as Float2 ) as integer
    
    return( _
      lhs.x <> rhs.x orElse _
      lhs.y <> rhs.y )
  end operator
  
  operator = ( _
    byref lhs as Float2, _
    byref rhs as Float2 ) as integer
    
    return( _
      lhs.x = rhs.x andAlso _
      lhs.y = rhs.y )
  end operator
  
  operator _
    abs( _
      byref rhs as Float2 ) _
    as Float2
    
    return( Float2( _
      abs( rhs.x ), _
      abs( rhs.y ) ) )
  end operator
  
  /'
    Returns the dot product of this vector with another
    vector v.
  '/
  function _
    Float2.dot( _
      byref v as Float2 ) _
    as float 
    
    return( x * v.x + y * v.y ) 
  end function
  
  /'
    The cross product is not defined in 2d, so this 
    function returns the z component of the cross product
    of this vector with vector v, if augmented to 3d.
  '/
  function _
    Float2.cross( _
      byref v as Float2 ) _
    as float 
    
    return( x * v.y - y * v.x )
  end function
  
  '' Returns the length of this vector
  function _
    Float2.length() _
    as float 
    
    return( sqr( x ^ 2 + y ^ 2 ) )
  end function
  
  '' Set the length for this vector
  sub _
    Float2.setLength( _
      byval value as float )
    
    dim as float _
      a => atan2( y, x )
    
    x => value * cos( a )
    y => value * sin( a )
  end sub
  
  function _
    Float2.ofLength( _
      byval value as float ) _
    as Float2
    
    var _
      v => Float2( x, y )
    
    v.setLength( value )
    
    return( v)
  end function
  
  /'
    Returns the squared length of this vector.
    
    Useful when one just want to compare two vectors to
    see which is longest, as this avoids computing the
    square root.
  '/
  function _
    Float2.squaredLength() _
    as float 
    
    return( x ^ 2 + y ^ 2 )
  end function
  
  '' Returns a normalized copy of this vector
  function _
    Float2.normalized() _
    as Float2 
    
    dim as float _
      l => sqr( x ^ 2 + y ^ 2 )
    
    l => iif( l > 0.0!, 1.0! / l, 1.0! )
    
    return( Float2( x * l, y * l ) )
  end function
  
  '' Normalizes this vector
  sub _
    Float2.normalize() 
    
    dim as float _
      l => sqr( x ^ 2 + y ^ 2 )
    
    l => iif( l > 0.0!, 1.0! / l, 1.0! )
    
    x *=> l
    y *=> l
  end sub
  
  /'
    turnLeft and turnRight rotate this vector 90 degrees to
    the left and right.
    
    Very useful to quickly find normals in 2D, as the normal
    of any vector is simply the vector rotated 90 degrees.
    So, if you want to find the normal of vector v, you can
    express it like this:
    
    n = normalized( turnLeft( v ) )
  '/
  sub _
    Float2.turnLeft() 
    
    this => Float2( y, -x )
  end sub
  
  function _
    Float2.turnedLeft() _
    as Float2
    
    return( Float2( y, -x ) )
  end function
  
  sub _
    Float2.turnRight() 
    
    this => Float2( -y, x )
  end sub
  
  function _
    Float2.turnedRight() _
    as Float2
    
    return( Float2( -y, x ) )
  end function
  
  /'
    Rotates this vector by anAngle 
  '/
  sub _
    Float2.rotate( _
      byval anAngle as Math.Radians )
    
    dim as float _
      si => sin( anAngle ), _
      co => cos( anAngle )
    
    this => Float2( _
      x * co - y * si, _
      x * si + y * co )
  end sub
  
  function _
    Float2.rotated( _
      byval anAngle as Math.Radians ) _
    as Math.Float2
    
    dim as float _
      si => sin( anAngle ), _
      co => cos( anAngle )
    
    return( Float2( _
      x * co - y * si, _
      x * si + y * co ) )
  end function
  
  '' Returns the angle that this vector points to
  function _
    Float2.angle() _
    as Math.Radians
    
    return( atan2( y, x ) )
  end function
  
  '' Returns the distance between this vector and another one
  function _
    Float2.distance( _
      byref v as Float2 ) _
    as float
    
    return( ( this - v ).length )
  end function
  
  /'
    Returns the squared distance to another vector. Useful to
    compare distances.
  '/
  function _
    Float2.squaredDistance( _
      byref v as Float2 ) _
    as float
    
    return( _
      ( x - v.x ) ^ 2 + _
      ( y - v.y ) ^ 2 )
  end function
  
  /'
    Returns the distance of this Float2 from the half-space
    defined by p1 -> p2.
  '/
  function _
    Float2.sideDistance( _
      byref p1 as const Float2, _
      byref p2 as const Float2 ) _
    as float
    
    return( _
      ( p1.x - x ) * ( p2.y - y ) - _
      ( p2.x - x ) * ( p1.y - y ) )
  end function
  
  sub _
    Float2.lookAt( _
      byref another as Float2 )
    
    dim as float _
      l => length, _
      nl => 1.0 / l
    
    x => ( ( another.x - x ) * nl ) * l
    y => ( ( another.y - y ) * nl ) * l
  end sub
  
  function _
    vMax overload( _
      byref p as Float2, _
      byval v as float ) _
    as Float2
    
    return( Float2( _
      fMax( p.x, v ), _
      fMax( p.y, v ) ) )
  end function
  
  function _
    vMin overload( _
      byref p as Float2, _
      byval v as float ) _
    as Float2
    
    return( Float2( _
      fMin( p.x, v ), _
      fMin( p.y, v ) ) )
  end function
end namespace

#endif
