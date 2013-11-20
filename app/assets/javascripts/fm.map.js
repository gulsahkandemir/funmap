'use strict';
$.widget('fm.fm_map', {
    options: {
        markersData: []
    },
    gmaps: {
        markers: [],
        infoWindow: null,
        map: null
    },
    _create: function() {
        $.extend(this.options, this.element.data());

        google.maps.event.addDomListener(window, 'load', $.proxy(this._initializeMap,this));
        $(document).on("fm_filterboxdatachanged", ".fm-filterbox", $.proxy(this._filterboxDataChanged,this));
    },
    _initializeMap: function() {
        var mapOptions = {
            zoom: 12,
            center: new google.maps.LatLng(37.7577,-122.4376)
        };

        this.gmaps.map = new google.maps.Map(this.element[0], mapOptions);
        this.gmaps.infoWindow = new google.maps.InfoWindow();
        google.maps.event.addListener(this.gmaps.map, "click", $.proxy(function () { 
            this.gmaps.infoWindow.close(); 
        },this)); 

        this.gmaps.markers = this._setMarkersInMap(this.gmaps.map, this.options.markersData);
    },
    _destroy: function() {
    },
    _filterboxDataChanged: function(event, data) {
        // Delete previous markers
        for (var i = 0; i < this.gmaps.markers.length; i++) {
            this.gmaps.markers[i].setMap(null);
        };
        this.gmaps.markers = [];

        // Reset markersData 
        this.options.markersData = data.markersData;

        // Add new markers
        this.gmaps.markers = this._setMarkersInMap(this.gmaps.map, data.markersData);
    },
    _openInfoWindowForMarker: function(marker, infoWindowContent) {
        this.gmaps.infoWindow.setContent(infoWindowContent);
        this.gmaps.infoWindow.open(this.gmaps.map, marker);
    },
    _setMarkersInMap: function(map, data) {
        var markers = [];
        // Add new markers
        for (var i = 0; i < data.length; i++) {
            var position = new google.maps.LatLng(data[i]["lat"], data[i]["lng"]);
            // Build the markers and add to map
            var marker = new google.maps.Marker({
                position: position,
                map: map
            });
            markers.push(marker); 

            google.maps.event.addListener(marker, 'click', $.proxy(function(marker, i) {
                return function() {
                    this._openInfoWindowForMarker(marker, data[i]["infoWindowContent"]);
                }
            }(marker, i), this));
        }
        return markers;
    }
});