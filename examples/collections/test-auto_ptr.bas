#include once "collections.bi"
#include "bi/person-type.bi"

template( List, of( Person ) )
template( Auto_ptr, of( Person ) )

#include once "bi/person-predicates.bi"
#include once "bi/person-actions.bi"

/'
  Some simple use cases for Auto_ptrs
'/
function _
  doSomething( _
    byval aList as List( of( Person ) ) ptr ) _
  as auto_ptr( of( List( of( Person ) ) ) )
  
  return( aList->selectAll( PersonsBelowAge( 2 ) ) )
end function

scope
  var _
    aList => List( of( Person ) )()
    
  with aList
    .add( new Person( "Paul Doe", 1 ) )
    .add( new Person( "Janet Doe", 2 ) )
    .add( new Person( "Shaiel Doe", 3 ) )
    .add( new Person( "John Doe", 4 ) )
  end with
  
  /'
    As you can see, here we pass the result of the selectAll() method
    directly to a function that expects a List( of Person ). This
    function, in turn, returns another auto_ptr for the List.
  '/
  var _
    result => doSomething( _
      aList.selectAll( PersonsBelowAge( 3 ) ) )
  
  ? "Results: "
  '' Or arternatively: ( *result ).forEach( ShowPerson() )
  result->forEach( ShowPerson() )
end scope

/'
  Now, this illustrates the semantics for the copy constructor: p1 is initially
  owning the pointer to Person, but after the assignment, p2 is the owner of it.
  While you can use both of them as pointers, only one will collect it (in this
  case, p2).
'/
scope
  var _
    p1 => auto_ptr( of( Person ) )( new Person( "Foo", 3 ) ), _
    p2 => p1
  
  ? p1->name
  ? p2->name
end scope

/'
  The following code will fail miserably because passing the auto_ptr byval will
  effectively give the ownership of the reference TO THE SUB it is passed. So, if 
  you later try to dereference the auto_ptr, you'll crash the app (you're
  dereferencing a deallocated pointer):
  
  sub _
    wrongWay( _
      byval aPtr as auto_ptr( of( Person ) ) )
    
    ? *aPtr
  end sub
  
  scope
    var _
      p1 => auto_ptr( of( Person ) )( new Person( "I will die young", 3 ) )
    
    wrongWay( p1 )
    
    ? *p1
  end scope
'/

/'
  This is the correct way of doing the above: passing the auto_ptr to the function
  that needs it BYREF. 
'/
sub _
  correctWay( _
    byref aPtr as auto_ptr( of( Person ) ) )
  
  ? *aPtr
end sub

scope
  var _
    p1 => auto_ptr( of( Person ) )( new Person( "I will NOT die young", 3 ) )
  
  correctWay( p1 )
  
  ? *p1
end scope

function _
  changeNameOf( _
    byref aPerson as auto_ptr( of( Person ) ), _
    byref aNewName as const string ) _
  byref as auto_ptr( of( Person ) )
  
  ? aPerson->name & " changes its name to " & aNewName
  aPerson->name => aNewName
  
  return( aPerson )
end function

function _
  changeAgeOf( _
    byref aPerson as auto_ptr( of( Person ) ), _
    byval aNewAge as integer ) _
  byref as auto_ptr( of( Person ) )
  
  ? aPerson->name & " lies about its age: " & aNewAge
  
  aPerson->age => aNewAge
  
  return( aPerson )
end function

/'
  Naturally, you may indeed want to pass the auto_ptr byval to the function if it
  is, say, a closure such as the function below; so after the function finishes,
  the Auto_ptr will get collected.
'/
sub _
  dateServiceProfile( _
    byval aPerson as auto_ptr( of( Person ) ) )
  
  ?
  ? "** MyHotDate user profile **"
  ?
  ? "Personal data for " & aPerson->name & ":"
  ? *aPerson
end sub

/'
  And then, you can use them in expressions like this, functional-style:
'/
?
dateServiceProfile( _
  changeNameOf( _
    changeAgeOf( _
      new Person( "Joe", 40 ), _
      18 ), _
    "Mary" ) )

sleep()
