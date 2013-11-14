'use strict';
$.widget('fm.fm_filterbox', {
    options: {
    },
    _create: function() {
    	console.log("fm_filterbox create");
    	this.element.find(".panel-collapse.collapse.in").
    		on('hide.bs.collapse',$.proxy(this._hideCollapsable,this));
    	this.element.find(".panel-collapse.collapse").
    		on('show.bs.collapse',$.proxy(this._showCollapsable,this));

    },
    _destroy: function() {
    	console.log("fm_filterbox destroy");
    },
    _hideCollapsable: function(){
    	this.element.find(".glyphicon.glyphicon-chevron-down").
    		addClass("glyphicon-chevron-right").
    		removeClass("glyphicon-chevron-down");
    },
    _showCollapsable: function(){
    	this.element.find(".glyphicon.glyphicon-chevron-right").
    		addClass("glyphicon-chevron-down").
    		removeClass("glyphicon-chevron-right");
    },

});