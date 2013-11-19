'use strict';
$.widget('fm.fm_filterbox', {
    options: {
    },
    eles: {
        collapseHandler: null,
        panelCollapse: null,
        moreCategoriesDiv: null,
        moreButton: null,
        searchButton: null,
        searchForm: null,
    },
    _create: function() {
        this._getUiEles();

    	this.eles.panelCollapse
    		.on('hide.bs.collapse', $.proxy(this._onHideCollapsable,this))
            .on('show.bs.collapse', $.proxy(this._onShowCollapsable,this));
    	this.eles.moreButton.on("click",$.proxy(this._onToggleMoreCategories,this));
        this.eles.searchForm.on("submit",$.proxy(this._onSearchFormSubmit,this));
        $('#daterange').daterangepicker(
              {
                ranges: {
                   'Today': [moment(), moment()],
                   'Yesterday': [moment().subtract('days', 1), moment().subtract('days', 1)],
                   'Last 7 Days': [moment().subtract('days', 6), moment()],
                   'Last 30 Days': [moment().subtract('days', 29), moment()],
                   'This Month': [moment().startOf('month'), moment().endOf('month')],
                   'Last Month': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
                },
                startDate: moment().subtract('days', 29),
                endDate: moment()
              },
              function(start, end) {
                console.log("Date time picker");
                  $('#daterange span').html(start.format('MMMM D, YYYY') + ' - ' 
                    + end.format('MMMM D, YYYY'));
              }
        );
    },
    _destroy: function() {
    },
    _getUiEles: function() {
        this.eles.collapseHandler = this.element.find(".js-collapse-handler");
        this.eles.panelCollapse = this.element.find(".panel-collapse");
        this.eles.moreCategoriesDiv = this.element.find(".js-more-categories");
        this.eles.moreButton = this.element.find(".js-more-btn");
        this.eles.searchButton = this.element.find(".js-search-btn");
        this.eles.searchForm = this.element.find(".js-search-form");

    },
    _onHideCollapsable: function() {
    	this.eles.collapseHandler
    		.addClass("glyphicon-chevron-right")
    		.removeClass("glyphicon-chevron-down");
    },
    _onShowCollapsable: function() {
    	this.eles.collapseHandler
    		.addClass("glyphicon-chevron-down")
    		.removeClass("glyphicon-chevron-right");
    },
    _onToggleMoreCategories: function() {
    	this.eles.moreCategoriesDiv.slideToggle();

        var buttonText = this.eles.moreButton.text();
        if(buttonText == "more"){
            this.eles.moreButton.text("less").blur();
        } else {
            this.eles.moreButton.text("more").blur();
        }
    },
    _onSearchFormSubmit: function(event) {
        event.preventDefault();
        console.log(this.eles.searchForm.serialize());
        
        this.eles.searchButton.blur();

        $.ajax({
          type: "GET",
          url: this.eles.searchForm.attr("action"),
          data: this.eles.searchForm.serialize(),
          success: $.proxy(this._onSearchFormSuccess, this),
          error: $.proxy(this._onSearchFormError, this)
        })
    },
    _onSearchFormSuccess: function(data, textStatus, jqXHR) {
        this._trigger("datachanged", null, {markersData: data});
    },
    _onSearchFormError: function(jqXHR, textStatus, errorThrown) {
    }

});