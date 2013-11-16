'use strict';
$.widget('fm.fm_filterbox', {
    options: {
    },
    eles: {
        collapseHandler: null,
        panelCollapse: null,
        moreCategoriesDiv: null,
        moreButton: null
    },
    _create: function() {
        this._getUiEles();

    	this.eles.panelCollapse
    		.on('hide.bs.collapse', $.proxy(this._hideCollapsable,this))
            .on('show.bs.collapse', $.proxy(this._showCollapsable,this));
    	this.eles.moreButton.on("click",$.proxy(this._toggleMoreCategories,this));
    },
    _destroy: function() {
    },
    _getUiEles: function() {
        this.eles.collapseHandler = this.element.find(".js-collapse-handler");
        this.eles.panelCollapse = this.element.find(".panel-collapse");
        this.eles.moreCategoriesDiv = this.element.find(".js-more-categories");
        this.eles.moreButton = this.element.find(".js-more");
    },
    _hideCollapsable: function(){
    	this.eles.collapseHandler
    		.addClass("glyphicon-chevron-right")
    		.removeClass("glyphicon-chevron-down");
    },
    _showCollapsable: function(){
    	this.eles.collapseHandler
    		.addClass("glyphicon-chevron-down")
    		.removeClass("glyphicon-chevron-right");
    },
    _toggleMoreCategories: function(){
    	this.eles.moreCategoriesDiv.slideToggle();
        var buttonText = this.eles.moreButton.text();
        if(buttonText == "more"){
            this.eles.moreButton.text("less").blur();
        } else {
            this.eles.moreButton.text("more").blur();
        }
    }
});