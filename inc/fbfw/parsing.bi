#ifndef __FBFW_PARSING__
#define __FBFW_PARSING__

#include once "file.bi"
#include once "fbfw-collections.bi"

/'
  Framework for common string parsing tasks.
  
  Entirely procedural, with a functional-style flavor. Its efficiency will
  of course depends on the string type used.
'/
namespace Parsing
  /'
    Alias for the string type used.
  '/
  type as string _
    StringType
  
  template( Array, of( StringType ) )
  
  enum _
    SpecialChars
    
    NullChar => 0
    Tab => 9
    Lf => 10
    Cr => 13
    Space => 32
  end enum
  
  const as StringType _
    fbCr => chr( SpecialChars.Cr ), _
    fbLf => chr( SpecialChars.Lf ), _
    fbCrLf => chr( SpecialChars.Cr, SpecialChars.Lf )
  
  namespace Strings
    /'
      Defines a string containing the chars considered whitespace
    '/
    const as StringType _
      WhiteSpace => _
        chr( SpecialChars.Tab ) + _
        chr( SpecialChars.Lf ) + _
        chr( SpecialChars.Cr ) + _
        chr( SpecialChars.Space )
    
    function _
      isWhitespace( _
        byval aChar as ubyte ) _
      as boolean
      
      return( cbool( _
        aChar = SpecialChars.Tab orElse _
        aChar = SpecialChars.Lf orElse _
        aChar = SpecialChars.Cr orElse _
        aChar = SpecialChars.Space ) )
    end function
    
    function _
      skipWhitespace( _
        byref subject as const StringType, _
        byval position as uinteger ) _
      as uinteger
      
      do while( _
        cbool( position < len( subject ) ) andAlso _
        isWhitespace( subject[ position - 1 ] ) )
        
        position +=> 1
      loop
      
      return( position )
    end function
    
    /'
      Returns whether or not the specified char is within the subject string
    '/
    function _
      within( _
        byval aChar as ubyte, _
        byref subject as const StringType ) _
      as boolean
      
      for _
        i as integer => 0 _
        to len( subject ) - 1
        
        if( aChar = subject[ i ] ) then
          return( true )
        end if
      next
      
      return( false )
    end function
    
    /'
      Splices a string and returns it trimmed, with the spliced
      string in the 'aSplice' parameter.
    '/
    function _
      splice( _
        byref subject as const StringType, _
        byref aSplice as StringType, _
        byref other as const StringType ) _
      as StringType
      
      '' Trivial rejects
      if( other = "" ) then
        aSplice => ""
        return( subject )
      end if
      
      if( subject = "" ) then
        aSplice => ""
        return( "" )
      end if
      
      dim as StringType _
        leftString, _
        rightString
      
      dim as integer _
        startPos => inStr( subject, other )
      
      if( startPos = 0 ) then
        return( subject )
      end if
      
      leftString => _
        left( subject, startPos - 1 )
      rightString => _
        right( subject, _
          len( subject ) - ( startPos + len( other ) - 1 ) )
      aSplice => _
        mid( subject, startPos, len( other ) )
      
      return( leftString + rightString )
    end function
    
    /'
      Returns whether or not a string starts with the specified
      prefix.
    '/
    function _
      startsWith( _
        byref aPrefix as const StringType, _
        byref aString as const StringType ) _
      as boolean
      
      return( cbool( left( _
        aString, len( aPrefix ) ) = aPrefix ) )
    end function
    
    /'
      Returns whether or not a string starts with any of the
      specified chars.
    '/
    function _
      startsWithAny( _
        byref chars as const StringType, _
        byref aString as const StringType ) _
      as boolean
      
      return( cbool( _
        len( aString ) > 0 andAlso _
        inStr( chr( aString[ 0 ] ), any chars ) ) )
    end function
    
    /'
      Returns whether or not a string ends with the specified
      suffix.
    '/
    function _
      endsWith( _
        byref aSuffix as const StringType, _
        byref aString as const StringType ) _
      as boolean
      
      return( cbool( right( _
        aString, len( aSuffix ) ) = aSuffix ) )
    end function
    
    /'
      Returns whether or not a string endss with any of the
      specified chars.
    '/
    function _
      endsWithAny( _
        byref chars as const StringType, _
        byref aString as const StringType ) _
      as boolean
      
      return( cbool( _
        len( aString ) > 0 andAlso _
        inStr( chr( aString[ len( aString ) - 1 ] ), any chars ) ) )
    end function
    
    /'
      Retrieves the string at the left of the specified char,
      without including it.
    '/
    function _
      leftOf( _
        byref aChar as const StringType, _
        byref aString as const StringType ) _
      as StringType
      
      return( mid( _
        aString, 1, inStr( aString, aChar ) - 1 ) )
    end function
    
    /'
      Retrieves the string at the right of the specified char,
      without including it.
    '/
    function _
      rightOf( _
        byref aChar as const StringType, _
        byref aString as const StringType ) _
      as StringType
      
      dim as uinteger _
        startPos => inStrRev( aString, aChar )
      
      return( mid( _
        aString, startPos + 1, len( aString ) - startPos ) )
    end function
    
    /'
      Returns how many characters of the specified charcode a string
      contains.
    '/
    function _
      howMany( _
        byref aCharcode as uinteger, _
        byref aString as const StringType ) _
      as integer
      
      dim as integer _
        count
      
      for _
        i as integer => 0 _
        to len( aString ) - 1
        
        count => iif( aString[ i ] = aCharcode, _
          count + 1, count )
      next
      
      return( count )
    end function
    
    /'
      Tests whether or not a string matches any string of the given set
      at the specified position. Returns the 0-based index into the set
      if a match was found, -1 if not.
    '/
    function _
      match( _
        byref subject as const StringType, _
        byref aSet as Array( of( StringType ) ), _
        byval position as uinteger ) _
      as integer
      
      dim as integer _
        result => -1
      
      for _
        i as integer => 0 _
        to aSet.count - 1
        
        if( _
          len( aSet.at( i ) ) > 0 andAlso _
          mid( _
            subject, _
            position, _
            len( aSet.at( i ) ) ) = aSet.at( i ) ) then
          
          result => i
          exit for
        end if
      next
      
      return( result )
    end function
    
    /'
      Loads a file as a string.
      
      Not exactly rocket-science, but this is a handy function to have.
    '/
    function _
      fromFile( _
        byref aPath as const StringType ) _
      as StringType
      
      dim as StringType _
        content => ""
      
      if( fileExists( aPath ) ) then
        dim as long _
          fileHandle => freeFile()
        
        open _
          aPath _
          for binary access read _
          as fileHandle
        
        '' Resize string to fit content
        content => space( lof( fileHandle ) )
        
        '' And get it all at once
        get #fileHandle, , content
        
        close( fileHandle )
      end if
      
      return( content )
    end function
    
    /'
      Writes a string to the specified file
    '/
    sub _
      toFile( _
        byref aPath as const StringType, _
        byref aString as const StringType )
      
      dim as long _
        fileHandle => freeFile()
      
      open _
        aPath _
        for output _
        as fileHandle
      
      print #fileHandle, aString
      
      close( fileHandle )
    end sub
    
    /'
      Splits a string into tokens, using the specified delimiters. The
      last optional parameter allows you to specify whether you want the
      function to retrieve the delimiters or not.
    '/
    function _
      split( _
        byref aString as StringType, _
        byref delimiters as const StringType, _
        byval retrieveDelimiters as boolean => false ) _
      as Auto_ptr( of( Array( of( StringType ) ) ) )
      
      '' Trivial reject
      if( _
        len( aString ) = 0 orElse _
        len( delimiters ) = 0 ) then
        
        return( auto_ptr( of( Array( of( StringType ) ) ) ) _
          ( new Array( of( StringType ) )() ) )
      end if
      
      '' Trivial accept, just one word
      if( inStr( _
        aString, _
        any delimiters ) = 0 andAlso _
        len( aString ) > 0 ) then
        
        var _
          a => new Array( of( StringType ) )()
        
        a->add( aString )
        
        return( auto_ptr( _
          of( Array( of( StringType ) ) ) )( a ) )
      end if
      
      dim as uinteger _
        count => 0, _
        wordCount => 0, _
        position => 0
      
      /'
        Preallocates the positions of the delimiters on the string.
        Not memory friendly, but on big strings this makes a world
        of difference.
      '/
      dim as uinteger ptr _
        positions => allocate( len( aString ) * sizeOf( uinteger ) )
      
      /'
        Tally the positions of the delimiters on the string.
        
        However naive this algorithm might look, it's actually smoking-hot fast.
        All others I have tested (including a scheme using a specialized hash
        table[!]) failed to outperform this. Reasons are, of course, the simplicity
        and linearity of the iteration (which helps the cache immensely).
      '/
      for _
        i as uinteger => 0 _
        to len( aString ) - 1
        
        for _
          char as uinteger => 0 _
          to len( delimiters ) - 1
          
          if( aString[ i ] = delimiters[ char ] ) then
            count +=> 1
            positions[ count ] => i + 1
            
            if( _
              count > 1 andAlso _
              ( i + 1 ) > positions[ count - 1 ] + 1 ) then
              
              wordCount +=> 1
            end if
            
            exit for
          end if
        next
      next
      
      /'
        If the last position tallied isn't at the end of the string, it
        means that the last token is a word, so account for it.
      '/
      if( positions[ count ] < len( aString ) ) then
        wordCount +=> 1
      end if
      
      '' Then fetch all the tokens, delimiters included
      position => 0
      
      dim as StringType _
        token
      
      '' First token is a word?
      if( positions[ position + 1 ] > 1 ) then
        token => mid( _
          aString, _
          1, _
          positions[ position + 1 ] - 1 )
        
        wordCount +=> 1
      end if
      
      dim as integer _
        tokenCount => iif( retrieveDelimiters, _
          wordCount + count, _
          wordCount )
      
      var _
        result => new Array( of( StringType ) ) _
          ( tokenCount * 2 )
      
      '' Add the first word
      if( len( token ) > 0 ) then
        result->add( token )
      end if
      
      dim as integer _
        startPos, endPos
      
      do while _
        ( position < count )
        
        position += 1
        
        '' Delimiter?
        token => mid( _
          aString, _
          positions[ position ], _
          1 )
        
        if( _
          len( token ) > 0 andAlso _
          retrieveDelimiters ) then
          
          result->add( token )
        end if
        
        '' Word?
        if( _
          positions[ position ] + 1 <> positions[ position + 1 ] andAlso _
          positions[ position ] + 1 <= len( aString ) ) then
          
          token => mid( _
            aString, _
            positions[ position ] + 1, _
            positions[ position + 1 ] - positions[ position ] - 1 )
          
          if( len( token ) > 0 ) then
            result->add( token )
          end if
        end if
      loop
      
      '' Release the preallocated buffer of positions
      deallocate( positions )
      
      '' And return an auto_ptr with the results
      return( auto_ptr( _
        of( Array( of( StringType ) ) ) )( result ) )
    end function
    
    /'
      Gets the next token in a 'subject' string, starting at 'position' and
      using 'delimiters' as token separators. Returns the position in the
      subject string after the spliced token.
      
      Note that the function works non-destructively, that is, it preserves
      the subject string and instead returns a copy of the token spliced.
      
      In a parsing context it is used like this:
      
        position => getToken( _
          subject, _
          separators, _
          position, _
          aToken )
      
      So, the new position is returned and the spliced token is returned by
      reference in the 'aToken' parameter. Not passig it a parameter can be
      used to eat a delimited block of text (such as when parsing comments).
      If it doesn't find any token (or the new position exceeds the subject
      string length) 'aToken' will contain a null string.
      
      It can also return the parsed delimiter (for parsing delimited strings)
      in the 'aDelimiter' parameter, like this:
      
        position => getToken( _
          subject, _
          separators, _
          position, _
          aToken, _
          aDelimiter )
      
      If there's no delimiter returned, then the end of the subject string has
      been reached. Also, due to how the function splices tokens, the position
      of the delimiter will be at 'position - 1'.
      
      It can also be used to 'peek' tokens: simply don't reassign the 'position'
      var, like this:
        
        getToken( _
          subject, _
          separators, _
          position, _
          peeked, _
          [delimiter] )
      
      That way, 'peeked' will contain the next token in the input stream but
      the position will not be changed.
    '/
    function _
      getToken( _
        byref subject as const StringType, _
        byref delimiters as const StringType, _
        byval position as uinteger, _
        byref aToken as StringType => "", _
        byref aDelimiter as StringType => "", _
        byref anEscapeChar as StringType => "\" ) _
      as uinteger
      
      aDelimiter => ""
      
      #define getCh( __p__ ) _
        iif( __p__ < len( subject ), _
          chr( subject[ __p__ ] ), "" )
      #define ch( __p__ ) chr( __p__ )
      #define isDelimiter( __c__, __d__ ) _
        cbool( inStr( __c__, any __d__ ) )
      
      dim as StringType _
        parsed
      dim as boolean _
        escaped
      
      do while( cbool( position <= len( subject ) ) )
        dim as StringType _
          char => getCh( position - 1 )
        
        if( char = anEscapeChar ) then
          escaped => true
        end if
        
        /'
          Collect chars while there isn't any separator
          in sight.
        '/
        if( isDelimiter( char, delimiters ) ) then
          position +=> 1
          aDelimiter => char
          exit do
        else
          if( escaped ) then
            char => getCh( position )
            position +=> 1
            escaped => false
          end if
          
          parsed +=> char
        end if
        
        position +=> 1
      loop
      
      aToken => parsed
      
      return( position )
    end function
    
    /'
      Returns a string with all the characters that match 'aChar' replaced
      with 'withChar' characters.
    '/
    function _
      replaced( _
        byval aChar as uinteger, _
        byval withChar as uinteger, _
        byref aString as const StringType ) _
      as StringType
      
      dim as StringType _
        result => aString
      
      for _
        i as integer => 0 _
        to len( result ) - 1
        
        if( result[ i ] = aChar ) then
          result[ i ] => withChar
        end if
      next
      
      return( result )
    end function
  end namespace
end namespace

#endif
