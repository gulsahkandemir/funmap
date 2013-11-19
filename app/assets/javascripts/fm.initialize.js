//= require fm.filterbox
//= require fm.map
'use strict';
$.fn.fm_initialize = function() {
	$(this).find('.js-date-range').daterangepicker({
      ranges: {
         'Today': [moment(), moment()],
         'Tomorrow': [moment(), moment().add('days',1)],
         'This Weekend': [moment().subtract('days', 1), moment().subtract('days', 1)],
         'This Month': [moment().startOf('month'), moment().endOf('month')],
      },
      startDate: moment().subtract('days', 29),
      endDate: moment()
    },
    function(start, end) {
        $('.js-date-range').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
    });
	$(this).find('.fm-filterbox').fm_filterbox();
	$(this).find('.fm-map').fm_map();
};