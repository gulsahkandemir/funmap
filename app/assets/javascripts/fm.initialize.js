//= require fm.filterbox
//= require fm.map
'use strict';
$.fn.fm_initialize = function() {
    $(this).find('.js-date-range').daterangepicker(
    	{
	    	ranges: {
	            'Today': [moment(), moment()],
	            'Tomorrow': [moment().add('days',1), moment().add('days',1)],
	            'This weekend': [moment().day(6), moment().day(7)],
	            'This week': [moment().startOf('week'), moment().endOf('week')],
	        },
	        startDate: moment().subtract('days', 7),
	        endDate: moment().add('days',21)
	    },
	    function(start, end) {
	    	$('.js-date-range').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
	    });
    
    $(this).find('.fm-filterbox').fm_filterbox();
    $(this).find('.fm-map').fm_map();
};