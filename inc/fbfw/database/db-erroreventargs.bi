#ifndef __FBFW_DATABASE_ERROREVENTARGS__
#define __FBFW_DATABASE_ERROREVENTARGS__

type _
  DatabaseErrorEventArgs _
  extends Events.EventArgs
  
  public:
    declare constructor( _
      byref as const string, _
      byval as long )
    declare destructor() override
    
    declare property _
      errorCode() as long
    declare property _
      errorMessage() as string
    
  private:
    declare constructor()
    
    as string _
      _errorMessage
    as long _
      _errorCode
end type

constructor _
  DatabaseErrorEventArgs()
end constructor

constructor _
  DatabaseErrorEventArgs( _
    byref anErrorMessage as const string, _
    byval anErrorCode as long )
  
  _errorMessage => anErrorMessage
  _errorCode => anErrorCode
end constructor

destructor _
  DatabaseErrorEventArgs()
end destructor

property _
  DatabaseErrorEventArgs.errorCode() _
  as long
  
  return( _errorCode )
end property

property _
  DatabaseErrorEventArgs.errorMessage() _
  as string
  
  return( _errorMessage )
end property

#endif
