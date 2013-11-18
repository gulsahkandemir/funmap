'use strict';
$.widget('fm.fm_map', {
    options: {
    	markersData: []
    },
    gmaps: {
		handler: null,
		markers: []
    },
    _create: function() {
    	$.extend(this.options, this.element.data());

    	var mapId = "map" + Math.floor(Math.random()*11);
	    this.element.attr("id", mapId);

	    this.gmaps.handler = Gmaps.build("Google");
	  	this.gmaps.handler.buildMap(
		  	{
		  		provider: {
		  			zoom: 11,
		  			center: new google.maps.LatLng(37.7577,-122.4376)
			    },
			    internal: {
			    	id: mapId
			    }
			},
			$.proxy(this._onMapLoad, this)
		);

		$(document).on("fm_filterboxdatachanged", ".fm-filterbox", $.proxy(this._filterboxDataChanged,this));

    },
    _destroy: function() {
    },
    _filterboxDataChanged: function(event, data) {
    	this.gmaps.handler.removeMarkers(this.gmaps.markers);
    	this.gmaps.markers = this.gmaps.handler.addMarkers(data.markersData);
    },
    _onMapLoad: function() {
		this.gmaps.markers = this.gmaps.handler.addMarkers(this.options.markersData);
    }

});