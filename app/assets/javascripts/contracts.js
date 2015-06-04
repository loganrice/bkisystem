var ready;
ready = function() {
  $('#varieties').DataTable({});
  pageSetUp();
};

$(document).ready(ready);
$(document).on('page:load', ready);
$(document).on('page:change', ready);
