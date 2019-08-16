require([
  "esri/tasks/Locator",
  "esri/layers/TileLayer",
  "esri/Basemap",
  "esri/Map",
  "esri/views/MapView",
  "esri/symbols/SimpleMarkerSymbol",
  "esri/symbols/SimpleLineSymbol",
  "esri/Color",
  "esri/widgets/Locate",
  "esri/widgets/Search",
  "esri/Graphic",
  "esri/geometry/support/webMercatorUtils",
  "dojo/_base/array",
  "esri/geometry/Point",
  "esri/widgets/Sketch/SketchViewModel",
  "esri/layers/GraphicsLayer",
  "esri/layers/FeatureLayer",
  "esri/PopupTemplate",
  "dojo/domReady!",
  ], function(
    Locator,
    TileLayer, 
    Basemap,
    Map,
    MapView,
    SimpleMarkerSymbol, 
    SimpleLineSymbol,
    Color,
    Locate,
    Search,
    Graphic,
    webMercatorUtils,
    arrayUtils,
    Point,
    SketchViewModel,
    GraphicsLayer,
    FeatureLayer,
    PopupTemplate,
    ) {

    var locatorTask = new Locator({
      url: "https://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer"
    });

    var layer = new TileLayer({
     url: "https://jakartasatu.jakarta.go.id/server/rest/services/DCKTRP/Peta_Struktur_2018/MapServer"
   });

    var myBasemap = new Basemap({
      baseLayers: [layer],
      thumbnailUrl: "https://www.example.com/images/thumbnail_2014-11-25_61051.png",
      title: "Custom Basemap",
      id: "myMap"
    });

    var map = new Map({
      basemap: "hybrid"
    });

    var view = new MapView({
      container: "maps",
      map: map,
      center: [106.827130, -6.175876],
      zoom: 17
    });
    var makerSymbol = {
      type: "simple-marker",
      color: [226, 119, 40],
      outline:{
        color: [255, 255, 255],
        width: 2
      }
    };
    var template = {
      // title: "{KECAMATAN} dan {KELURAHAN}",
      content: [
      {
        type: "fields",
        fieldInfos: [
        {
          fieldName: "KECAMATAN", // The field whose values you want to format
          label: "Kecamatan",
        },
        {
          fieldName: "KELURAHAN", // The field whose values you want to format
          label: "Kelurahan",
          format: {
            digitSeparator: true, // Uses a comma separator in numbers >999
            places: 0 // Sets the number of decimal places to 0 and rounds up
          }
        },
        {
          fieldName: "SUB_BLOK", // The field whose values you want to format
          label: "Id Sublok",
          format: {
            digitSeparator: true, // Uses a comma separator in numbers >999
            places: 0 // Sets the number of decimal places to 0 and rounds up
          }
        },
        {
          fieldName: "ZONA", // The field whose values you want to format
          label: "Zona",
          format: {
            digitSeparator: true, // Uses a comma separator in numbers >999
            places: 0 // Sets the number of decimal places to 0 and rounds up
          }
        },
        {
          fieldName: "SUB_ZONA", // The field whose values you want to format
          label: "Sub Zona",
          format: {
            digitSeparator: true, // Uses a comma separator in numbers >999
            places: 0 // Sets the number of decimal places to 0 and rounds up
          }
        },
        {
          fieldName: "BERSYARAT", // The field whose values you want to format
          label: "Perizinan Bersyarat",
          format: {
            digitSeparator: true, // Uses a comma separator in numbers >999
            places: 0 // Sets the number of decimal places to 0 and rounds up
          }
        },
        {
          fieldName: "DIIZINKAN", // The field whose values you want to format
          label: "Perizinan di Izinkan",
          format: {
            digitSeparator: true, // Uses a comma separator in numbers >999
            places: 0 // Sets the number of decimal places to 0 and rounds up
          }
        },
        {
          fieldName: "TERBATAS", // The field whose values you want to format
          label: "Perizinan Terbatas",
          format: {
            digitSeparator: true, // Uses a comma separator in numbers >999
            places: 0 // Sets the number of decimal places to 0 and rounds up
          }
        },
        {
          fieldName: "TERBATAS_BERSYARAT", // The field whose values you want to format
          label: "Perizinan Terbatas Bersyarat",
          format: {
            digitSeparator: true, // Uses a comma separator in numbers >999
            places: 0 // Sets the number of decimal places to 0 and rounds up
          }
        }
        ]
      }
      ]
    };
    var parksLayer = new FeatureLayer({
     url: "https://tataruang.jakarta.go.id/server/rest/services/peta_operasional/Peta_Ops_V2_View/FeatureServer/3",
     // definitionExpression : "KECAMATAN = 'GAMBIR'",
     popupTemplate : template,
     opacity : 0.3,
   });
    map.add(parksLayer);



    var locateBtn = new Locate({
      view: view
    });

    view.ui.add(locateBtn, {
      position:"top-left"
    });

    locateBtn.on("locate", function(evt){
      var point = {
        type: "point",
        longitude: evt.position.coords.longitude ,
        latitude: evt.position.coords.latitude
      };

      var pointGraphic = new Graphic({
        geometry: point,
        symbol: makerSymbol,
        popupTemplate: template,
      })
      view.graphics.removeAll();
      // console.log(evt);
      view.popup.open({
        title: "Koordinat : [" + evt.position.coords.latitude +" , "+ evt.position.coords.longitude +" ] ",
        location : locateBtn.graphic.geometry
      });

      $("#lat").val(evt.position.coords.latitude);
      $("#lon").val(evt.position.coords.longitude);

      locatorTask.locationToAddress(locateBtn.graphic.geometry).then(function(response){
        view.popup.content = response.address; 
        // parksLayer.definitionExpression = "KECAMATAN = '"+response.attributes.City.toUpperCase()+"'";
        // map.add(parksLayer);
        $("#alamat").val(response.address);
      }).catch(function(err) {
        view.popup.content =
        "Tidak ada lokasi yang ditemukan";
      });
      view.graphics.add(pointGraphic);
      var points = [
      [lon, lat]
      ];

      arrayUtils.forEach(points, function(point) {
       var graphic = new Graphic(new Point(point), makerSymbol);
         // console.log(graphic);
         view.graphics.add(graphic);
         view.on("drag",(event) => {
          var screenPoint = {
            x: event.x,
            y: event.y
          };
          view.hitTest(screenPoint).then(({ results }) => {
            const graphic = results[0].graphic;
            event.stopPropagation();
            view.graphics.removeAll();
            // console.log(event)
            const g = graphic.clone();
            const pt = view.toMap(event);
            g.geometry = pt;
            var mp = webMercatorUtils.webMercatorToGeographic(pt);
            // console.log(mp);
            // if (event.action == 'end') {

              var lat = mp.y.toFixed(6);
              var lon =mp.x.toFixed(6);
              view.popup.open({
                title: "Koordinat: [" + lat + ", " + lon + "]",
                location: g.geometry 
              });
              var point = {
                type: "point",
                longitude: lon ,
                latitude: lat
              };

              var pointGraphic = new Graphic({
                geometry: point,
                symbol: makerSymbol
              })
              view.graphics.add(pointGraphic);
              $('#lat').val(lat);
              $('#lon').val(lon);
              if (event.action == 'end') {
                if (results[0].graphic.attributes == null) {
                 view.popup.content = '<table class="esri-widget__table" summary="List of attributes and values"><tbody><tr><th class="esri-feature__field-header">Kecamatan</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['KECAMATAN']+'</td></tr><tr><th class="esri-feature__field-header">Kelurahan</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['KELURAHAN']+'</td></tr><tr><th class="esri-feature__field-header">Sublok</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['SUB_BLOK']+'</td></tr><tr><th class="esri-feature__field-header">Zona</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['ZONA']+'</td></tr><tr><th class="esri-feature__field-header">Sub Zona</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['SUB_ZONA']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Bersyarat</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['BERSYARAT']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Dizinkan</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['DIIZINKAN']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Terbatas</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['TERBATAS']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Terbatas Bersyarat</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['TERBATAS_BERSYARAT']+'</td></tr></tbody></table>';
               }else{
                 view.popup.content = '<table class="esri-widget__table" summary="List of attributes and values"><tbody><tr><th class="esri-feature__field-header">Kecamatan</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['KECAMATAN']+'</td></tr><tr><th class="esri-feature__field-header">Kelurahan</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['KELURAHAN']+'</td></tr><tr><th class="esri-feature__field-header">Sublok</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['SUB_BLOK']+'</td></tr><tr><th class="esri-feature__field-header">Zona</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['ZONA']+'</td></tr><tr><th class="esri-feature__field-header">Sub Zona</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['SUB_ZONA']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Bersyarat</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['BERSYARAT']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Dizinkan</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['DIIZINKAN']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Terbatas</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['TERBATAS']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Terbatas Bersyarat</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['TERBATAS_BERSYARAT']+'</td></tr></tbody></table>';
               }
               locatorTask.locationToAddress(g.geometry).then(function(response) {
                // parksLayer.definitionExpression = "KECAMATAN = '"+response.attributes.City.toUpperCase()+"'";
                // map.add(parksLayer);
                $("#alamat").val(response.address);
              }).catch(function(err) {
                view.popup.content =
                "Tidak ada lokasi yang ditemukan";
              });
            }
            // }

          });
});
});
});

var searchWidget = new Search({
  view: view, 
  placeholder: "Cari Alamat Anda",
  allPlaceholder: "Cari Alamat Anda",
});

view.ui.add(searchWidget, {
  position: "top-right",
  placeholder: "Cari Alamat Anda",
  allPlaceholder: "Cari Alamat Anda",
  index: 2
});

searchWidget.on("select-result", function(event){
  view.graphics.removeAll();
      // event.stopPropagation(); 
      var lat = Math.round(event.result.feature.geometry.latitude * 1000000)/ 1000000;
      var lon = Math.round(event.result.feature.geometry.longitude * 1000000)/ 1000000;

      $("#lon").val(lon);
      $("#lat").val(lat);

      var point = {
        type: "point",
        longitude: lon ,
        latitude: lat
      };

      var pointGraphic = new Graphic({
        geometry: point,
        symbol: makerSymbol
      })

      view.popup.open({
        title: "Koordinat : [" + lat +" , "+ lon +" ] ",
        location : event.result.feature.geometry,

      });
      locatorTask.locationToAddress(event.result.feature.geometry).then(function(response){
        view.popup.content = response.address;
            // parksLayer.definitionExpression = "KECAMATAN = '"+response.attributes.City.toUpperCase()+"'";
            // map.add(parksLayer);
            $("#alamat").val(response.address);
          }).catch(function(err) {
            view.popup.content =
            "Tidak ada lokasi yang ditemukan";
          });
          view.graphics.add(pointGraphic);

          var points = [
          [lon, lat]
          ];

          arrayUtils.forEach(points, function(point) {
           var graphic = new Graphic(new Point(point), makerSymbol);
         // console.log(graphic);
         view.graphics.add(graphic);
         view.on("drag",(event) => {
          var screenPoint = {
            x: event.x,
            y: event.y
          };
          view.hitTest(screenPoint).then(({ results }) => {
            const graphic = results[0].graphic;
            event.stopPropagation();
            view.graphics.removeAll();
            // console.log(event)
            const g = graphic.clone();
            const pt = view.toMap(event);
            g.geometry = pt;
            var mp = webMercatorUtils.webMercatorToGeographic(pt);
            // console.log(mp);
            // if (event.action == 'end') {

              var lat = mp.y.toFixed(6);
              var lon =mp.x.toFixed(6);
              view.popup.open({
                title: "Koordinat: [" + lat + ", " + lon + "]",
                location: g.geometry 
              });
              var point = {
                type: "point",
                longitude: lon ,
                latitude: lat
              };

              var pointGraphic = new Graphic({
                geometry: point,
                symbol: makerSymbol
              })
              view.graphics.add(pointGraphic);
              $('#lat').val(lat);
              $('#lon').val(lon);
              if (event.action == 'end') {
                if (results[0].graphic.attributes == null) {
                 view.popup.content = '<table class="esri-widget__table" summary="List of attributes and values"><tbody><tr><th class="esri-feature__field-header">Kecamatan</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['KECAMATAN']+'</td></tr><tr><th class="esri-feature__field-header">Kelurahan</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['KELURAHAN']+'</td></tr><tr><th class="esri-feature__field-header">Sublok</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['SUB_BLOK']+'</td></tr><tr><th class="esri-feature__field-header">Zona</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['ZONA']+'</td></tr><tr><th class="esri-feature__field-header">Sub Zona</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['SUB_ZONA']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Bersyarat</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['BERSYARAT']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Dizinkan</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['DIIZINKAN']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Terbatas</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['TERBATAS']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Terbatas Bersyarat</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['TERBATAS_BERSYARAT']+'</td></tr></tbody></table>';
               }else{
                 view.popup.content = '<table class="esri-widget__table" summary="List of attributes and values"><tbody><tr><th class="esri-feature__field-header">Kecamatan</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['KECAMATAN']+'</td></tr><tr><th class="esri-feature__field-header">Kelurahan</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['KELURAHAN']+'</td></tr><tr><th class="esri-feature__field-header">Sublok</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['SUB_BLOK']+'</td></tr><tr><th class="esri-feature__field-header">Zona</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['ZONA']+'</td></tr><tr><th class="esri-feature__field-header">Sub Zona</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['SUB_ZONA']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Bersyarat</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['BERSYARAT']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Dizinkan</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['DIIZINKAN']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Terbatas</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['TERBATAS']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Terbatas Bersyarat</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['TERBATAS_BERSYARAT']+'</td></tr></tbody></table>';
               }
               locatorTask.locationToAddress(g.geometry).then(function(response) {
                // parksLayer.definitionExpression = "KECAMATAN = '"+response.attributes.City.toUpperCase()+"'";
                // map.add(parksLayer);
                $("#alamat").val(response.address);
              }).catch(function(err) {
                view.popup.content =
                "Tidak ada lokasi yang ditemukan";
              });
            }
            // }

          });
});
});
});


      // ------------------------------------------------------Ketika Klik dapat Lokasi
      view.on("click", function(event) {
        // event.stopPropagation(); 
        view.graphics.removeAll();
        var lat = Math.round(event.mapPoint.latitude * 1000000) / 1000000;
        var lon = Math.round(event.mapPoint.longitude * 1000000) / 1000000;

        $("#lat").val(lat);
        $("#lon").val(lon);
        view.popup.open({
          title: "Koordinat [" + lat + ", " + lon + "]",
          location: event.mapPoint 
        });

        locatorTask.locationToAddress(event.mapPoint).then(function(
          response) {
          $("#alamat").val(response.address);
          // parksLayer.definitionExpression = "KECAMATAN = '"+response.attributes.City.toUpperCase()+"'";
          // map.add(parksLayer);
        }).catch(function(err) {
          view.popup.content =
          "Tidak ada lokasi yang ditemukan";
        });

        var points = [
        [lon, lat]
        ];

        arrayUtils.forEach(points, function(point) {
         var graphic = new Graphic(new Point(point), makerSymbol);
         // console.log(graphic);
         view.graphics.add(graphic);
         view.on("drag",(event) => {
          var screenPoint = {
            x: event.x,
            y: event.y
          };
          view.hitTest(screenPoint).then(({ results }) => {
            const graphic = results[0].graphic;
            event.stopPropagation();
            view.graphics.removeAll();
            // console.log(event)
            const g = graphic.clone();
            const pt = view.toMap(event);
            g.geometry = pt;
            var mp = webMercatorUtils.webMercatorToGeographic(pt);
            // console.log(mp);
            // if (event.action == 'end') {

              var lat = mp.y.toFixed(6);
              var lon =mp.x.toFixed(6);
              view.popup.open({
                title: "Koordinat: [" + lat + ", " + lon + "]",
                location: g.geometry 
              });
              var point = {
                type: "point",
                longitude: lon ,
                latitude: lat
              };

              var pointGraphic = new Graphic({
                geometry: point,
                symbol: makerSymbol
              })
              view.graphics.add(pointGraphic);
              $('#lat').val(lat);
              $('#lon').val(lon);
              if (event.action == 'end') {
                if (results[0].graphic.attributes == null) {
                 view.popup.content = '<table class="esri-widget__table" summary="List of attributes and values"><tbody><tr><th class="esri-feature__field-header">Kecamatan</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['KECAMATAN']+'</td></tr><tr><th class="esri-feature__field-header">Kelurahan</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['KELURAHAN']+'</td></tr><tr><th class="esri-feature__field-header">Sublok</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['SUB_BLOK']+'</td></tr><tr><th class="esri-feature__field-header">Zona</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['ZONA']+'</td></tr><tr><th class="esri-feature__field-header">Sub Zona</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['SUB_ZONA']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Bersyarat</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['BERSYARAT']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Dizinkan</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['DIIZINKAN']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Terbatas</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['TERBATAS']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Terbatas Bersyarat</th><td class="esri-feature__field-data">' + results[1].graphic.attributes['TERBATAS_BERSYARAT']+'</td></tr></tbody></table>';
               }else{
                 view.popup.content = '<table class="esri-widget__table" summary="List of attributes and values"><tbody><tr><th class="esri-feature__field-header">Kecamatan</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['KECAMATAN']+'</td></tr><tr><th class="esri-feature__field-header">Kelurahan</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['KELURAHAN']+'</td></tr><tr><th class="esri-feature__field-header">Sublok</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['SUB_BLOK']+'</td></tr><tr><th class="esri-feature__field-header">Zona</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['ZONA']+'</td></tr><tr><th class="esri-feature__field-header">Sub Zona</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['SUB_ZONA']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Bersyarat</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['BERSYARAT']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Dizinkan</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['DIIZINKAN']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Terbatas</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['TERBATAS']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Terbatas Bersyarat</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['TERBATAS_BERSYARAT']+'</td></tr></tbody></table>';
               }
               locatorTask.locationToAddress(g.geometry).then(function(response) {
                // parksLayer.definitionExpression = "KECAMATAN = '"+response.attributes.City.toUpperCase()+"'";
                // map.add(parksLayer);
                $("#alamat").val(response.address);
              }).catch(function(err) {
                view.popup.content =
                "Tidak ada lokasi yang ditemukan";
              });
            }
            // }

          });
});
});
});
});