(function( $ ) {
  $.fn.pop = function() {
    var top = this.get(-1);
    this.splice(this.length-1,1);
    return top;
  };

  $.fn.shift = function() {
    var bottom = this.get(0);
    this.splice(0,1);
    return bottom;
  };
})( jQuery );
