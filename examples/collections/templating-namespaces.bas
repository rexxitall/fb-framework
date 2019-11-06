#include once "collections.bi"

/'
  Namespace templating test
'/
namespace My
  type _
    Foo
    
    as integer _
      bar
  end type
  
  '' Templating support namespaces, too
  template( PriorityQueue, of( Foo ) )
end namespace

/'
  And of course, if you've templated a collection within a namespace,
  you'll have to qualify (or import the namespace).
'/
var _
  aList => My.PriorityQueue( of( Foo ) )

/'
  Templating from outside a namespace is a little trickier, since you can't
  qualify the symbol. However, with this little trick you can do it: simply
  type alias the class you want templated, and use the alias to template it.
  
'/
type as My.Foo _
  My_Foo

/'
  But of course you'll have to use the unqualified alias instead of the real
  name. This is quite unfortunate, but hopefully it will be solved in future
  releases of FreeBasic.
'/
template( _
  Dictionary, of( string ), of( My_Foo ) )
