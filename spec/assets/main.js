//
//
//= require lib/module1.js

	//=	require ./lib/module2.js

///////////////////////////////////////
//
// The Big Document Ready Guard with the main implementation
//
$( document ).ready(function() {

  // actuall do stuff

}); // document ready

// This is confusing and stupid, since it nevertheless will be
// put to the top:
//= require lib/fu.js
