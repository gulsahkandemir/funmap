//= require fm.filterbox
//= require fm.map
'use strict';
$.fn.fm_initialize = function() {
	$(this).find('.fm-filterbox').fm_filterbox();
	$(this).find('.fm-map').fm_map();
};