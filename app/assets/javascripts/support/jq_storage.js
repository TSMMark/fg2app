/*
 * 
 * 
 */

window.jQuery && (function(d,$){
  $.s_tmp = {};
  // r(roundtrip - bool), n(name - mixed), v(val - mixed)
  window.Stave = function(){
    var n,v; // name(required), value(optional)
    
    // if saving, refresh all elements with updated info.
    // if getting, force direct load from storage (not cache)
    var r=false; // refresh (optional)
    
    // figure out arguments
    for(i in arguments){
      var a = arguments[i];
      // if first arg is BOOL, it's r
      if(i==0 && typeof a === "boolean"){
        r = a;  continue;
      }
      // name comes first
      if(!n){
        n = a;  continue;
      }
      // value comes last
      v = a;    break;
    }
    
    // are we getting or setting?
    if(typeof(v)!=="undefined"){ // we're applying value v to name n
      localStorage.setItem(n,JSON.stringify(v));
      
      // set in tmp
      $.s_tmp[n]  = v;
    }else{ // we're getting value v of name n
      // are we skipping tmp?
      if(r || typeof $.s_tmp[n] === "undefined"){
        v = $.parseJSON(localStorage.getItem(n));
      }else{
        v = $.s_tmp[n];
      }
      // set in tmp
      $.s_tmp[n]  = v;
    }
    return v;
  }
}(window.document, window.jQuery));
