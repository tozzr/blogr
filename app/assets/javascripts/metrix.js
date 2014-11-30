(function($) {
  Object.size = function(obj) {
    var size = 0, key;
    for (key in obj) {
      if (obj.hasOwnProperty(key)) {
        size++;
        if (typeof obj[key] === 'object')
          size += Object.size(obj[key]);
        else if (typeof obj[key] === 'number')
          size++;
        else
          size += obj[key].length;
      }
    }
    return size;
  };
  function recordClick(e) {
    var click = {
      location: location.pathname, 
      mouse_x: e.pageX, mouse_y: e.pageY, 
      document_w: $(document).width(), document_h: $(document).height(),
      window_w: $(window).width(), window_h: $(window).height(),
      screen_w: screen.width, screen_h: screen.height
    }
    //console.log(metrix);//, Object.size(metrix));
    $.post('/metrix/click', click);
    
    if (e.target.tagName.toLowerCase() === 'a')
      $(document).off('mousedown.metrix');
  }
  
  $(document).on('mousedown.metrix', 'body', recordClick);
})($);
