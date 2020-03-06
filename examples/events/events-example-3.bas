#include once "fbfw-events.bi"

/'
  Events example 3: Inherited events
'/
type _
  SomethingHappenedEventArgs _
  extends Events.EventArgs
  
  public:
    declare constructor( _
      byref as const string )
    declare destructor() override
    
    declare property _
      instanceName() as string
    
  private:
    declare constructor()
    
    as string _
      _instanceName
end type

constructor _
  SomethingHappenedEventArgs()
end constructor

constructor _
  SomethingHappenedEventArgs( _
    byref anInstanceName as const string )
  
  _instanceName => anInstanceName
end constructor

destructor _
  SomethingHappenedEventArgs()
end destructor

property _
  SomethingHappenedEventArgs.instanceName() _
  as string
  
  return( _instanceName )
end property

type _
  BaseClass _
  extends Events.WithEvents
  
  public:
    declare constructor( _
      byref as const string )
    declare virtual destructor() override
    
    declare property _
      SomethingHappened() _
      byref as const Events.Event
    
    declare property _
      name() as string
    
    declare abstract sub _
      operation()
    
  protected:
    declare constructor()
  
  private:
    static as Events.Event _
      _EvSomethingHappened
    
    as string _
      _name
end type

dim as Events.Event _
  BaseClass._EvSomethingHappened => _
    Events.Event( "SomethingHappened" )
  
constructor _
  BaseClass()
end constructor

constructor _
  BaseClass( _
    byref aName as const string )
  
  register( _EvSomethingHappened )
  
  _name => aName
end constructor

destructor _
  BaseClass()
end destructor

property _
  BaseClass.SomethingHappened() _
  byref as const Events.Event
  
  return( _EvSomethingHappened.forInstance( @this ) )
end property

property _
  BaseClass.name() _
  as string
  
  return( _name )
end property

type _
  DerivedClass1 _
  extends BaseClass
  
  public:
    declare constructor( _
      byref as const string )
    declare virtual destructor() override
    
    declare sub _
      operation() override
    
  private:
    declare constructor()
end type

constructor _
  DerivedClass1()
end constructor

constructor _
  DerivedClass1( _
    byref aName as const string )
  
  base( aName )
end constructor

destructor _
  DerivedClass1()
end destructor

sub _
  DerivedClass1.operation()
  
  ? this.name + " is executing an operation"
  
  raiseEvent( _
    SomethingHappened, _
    SomethingHappenedEventArgs( this.name ) )
end sub

type _
  DerivedClass2 _
  extends BaseClass
  
  public:
    declare constructor( _
      byref as const string )
    declare virtual destructor() override
    
    declare sub _
      operation() override
    
  private:
    declare constructor()
end type

constructor _
  DerivedClass2()
end constructor

constructor _
  DerivedClass2( _
    byref aName as const string )
  
  base( aName )
end constructor

destructor _
  DerivedClass2()
end destructor

sub _
  DerivedClass2.operation()
  
  ? this.name + " is performing an operation"
  
  raiseEvent( _
    SomethingHappened, _
    SomethingHappenedEventArgs( this.name ) )
end sub

sub _
  operation_handler( _
    byref sender as BaseClass, _
    byref e as SomethingHappenedEventArgs )
  
  ? "Handled an event from: " + e.instanceName
end sub

var _
  d1 => DerivedClass1( "foo" ), _
  d2 => DerivedClass2( "bar" )

d1.addHandler( _
  d1.SomethingHappened, _
  asHandler( operation_handler ) )
d2.addHandler( _
  d2.SomethingHappened, _
  asHandler( operation_handler ) )

d1.operation()
d2.operation()

sleep()
