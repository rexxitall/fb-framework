#ifndef __FBFW_DRAWING_IMAGING__
#define __FBFW_DRAWING_IMAGING__

#include once "fbgfx.bi"
#include once "file.bi"

namespace Drawing
  namespace Imaging
    /'
    	TGA file format header
    '/
    type _
      TGAHeader _
      field => 1
    
      as ubyte _
        idLength, _
        colorMapType, _
        dataTypeCode
      as short _
        colorMapOrigin, _
        colorMapLength
      as ubyte _
        colorMapDepth
      as short _
        x_origin, _
        y_origin, _
        width, _
        height
      as ubyte _
        bitsPerPixel, _
        imageDescriptor
    end type
    
    function _
      loadBMP( _
        byref aPath as const string ) _
      as Fb.Image ptr
      
      dim as Fb.Image ptr _
        image
      
      dim as long _
        fileHandle => freeFile()
      
      '' Open file
      dim as integer _
        result => open( _
          aPath _
          for binary _
          access read _
          as fileHandle )
        
      if( result = 0 ) then
        dim as long _
          bw, bh
        
        get #fileHandle, 19, bw
        get #fileHandle, 23, bh
        
        close( fileHandle )
        
        image => imageCreate( _
          bw, bh, rgba( 0, 0, 0, 0 ) )
        
        bload( aPath, image )
      end if
      
      return( image )
    end function
    
    /'
      Loads a TGA image info a Fb.Image buffer.
      
      Currently this loads only 32-bit uncompressed TGA files.		
    '/
    function _
      loadTGA( _
        byref aPath as const string ) _
      as Fb.Image ptr
      
      dim as long _
        fileHandle => freeFile()
      
      dim as Fb.Image ptr _
        image
      
      '' Open file
      dim as integer _
        result => open( _
          aPath _
          for binary _
          access read _
          as fileHandle )
        
      if( result = 0 ) then
        '' Retrieve header
        dim as TGAHeader _
          h
        
        get #fileHandle, , h
        
        /'
          Only 32-bit, uncompressed TGA files are supported
        '/
        if( _
          h.dataTypeCode = 2 andAlso _
          h.bitsPerPixel = 32 ) then
        
          '' Create a ZSprite
          image => imageCreate( _
            h.width, h.height, rgba( 0, 0, 0, 0 ) )
          
          '' Pointer to pixel data				
          dim as ulong ptr _
            pix => cptr( ulong ptr, image ) + _
              sizeOf( Fb.Image ) \ sizeOf( ulong )
          
          /'
            Get size of padding, as FB aligns the width of its images
            to the paragraph (16 bytes) boundary.
          '/
          dim as integer _
            padd => image->pitch \ sizeOf( ulong )
          
          '' Allocate temporary buffer to hold pixel data
          dim as ulong ptr _
            buffer => allocate( _
              ( h.width * h.height ) * sizeOf( ulong ) )
            
          '' Read pixel data from file
          get #fileHandle, , *buffer, h.width * h.height
          
          close( fileHandle )
          
          '' Load pixel data onto image
          for _
            y as integer => 0 _
            to h.height - 1
            
            for _
              x as integer => 0 _
              to h.width - 1
              
              dim as integer _
                yy => iif( h.y_origin = 0, _
                  ( h.height - 1 ) - y, y )
                
              pix[ yy * padd + x ] => buffer[ y * h.width + x ]
            next
          next
          
          deallocate( buffer )
        end if
      end if
      
      return( image )
    end function
  end namespace
end namespace

#endif
