'use strict';
$.widget('fm.fm_map', {
    options: {
    	markers: []
    },
    _create: function() {
    	$.extend(this.options, this.element.data());

    	var mapId = "map";
	    this.element.attr("id", mapId);

	    var gmaps = Gmaps.build("Google");
	  	gmaps.buildMap(
	  	{
	  		provider: {
	  			zoom: 11,
	  			center: new google.maps.LatLng(37.7577,-122.4376)
		    },
		    internal: {
		    	id: mapId
		    }
		},
		$.proxy(function() {
			gmaps.addMarkers(this.options.markers);
		}, this));

    },
    _destroy: function() {
    }
});