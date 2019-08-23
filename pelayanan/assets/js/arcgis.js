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
    // Start service locator untuk mencari alamat yang akurat
    var locatorTask = new Locator({
      url: "https://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer",
      allPlaceholder : "Cari Alamat",
    });
    // End Locator

    // Setting layer yang akan di tampilkan , jika maps di bawah pakai tampilan maps jakarta saja silakan pakai ini jika tidak mohon di matikan

   //  var layer = new TileLayer({
   //   url: "https://jakartasatu.jakarta.go.id/server/rest/services/DCKTRP/Peta_Struktur_2018/MapServer"
   // });

   //  var myBasemap = new Basemap({
   //    baseLayers: [layer],
   //    thumbnailUrl: "https://www.example.com/images/thumbnail_2014-11-25_61051.png",
   //    title: "Custom Basemap",
   //    id: "myMap"
   //  });
    // End Setting layer

    // Pilih Maps yang di pakai
    var map = new Map({
      basemap: "hybrid"
    });

    // hanya tampil maps jakarta tampilan sederhana
    // var map = new Map({
    //   basemap: myBasemap,
    // });

    // Start setting maps
    var view = new MapView({
      container: "maps",
      map: map,
      center: [106.827130, -6.175876],
      zoom: 17
    });
    // end Setting maps

    // Start symbol , setting jika ingin mengganti Simbol
    var makerSymbol = {
      type: "simple-marker",
      color: [226, 119, 40],
      outline:{
        color: [255, 255, 255],
        width: 2
      }
    };
    // End Untuk mengganti Symbol

    // Start Template Popup
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
    //End Template Popup tadi di pakai sekarang tidak , tapi lebih baik buat kenangan


    // Fungsinya untuk menempelkan layer pada maps
    var parksLayer = new FeatureLayer({
     url: "https://tataruang.jakarta.go.id/server/rest/services/peta_operasional/Peta_Ops_V2_View/FeatureServer/3",
     // Testing Jika Tata ruang lama di buka
     // definitionExpression : "KECAMATAN = 'GAMBIR'",
     popupTemplate : template,
     opacity : 0.3,
   });

    map.add(parksLayer);
    // End menempelkan

    // Start membuat tombol locate
    var locateBtn = new Locate({
      view: view
    });
    // End tombol locate

    // Untuk Mengatur Tombol locate
    view.ui.add(locateBtn, {
      position:"top-left"
    });
    // End Setting tombol locate

    // Mulai action jika menekan tombol locate
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
      view.popup.open({
        // Di matikan Karena title sekarang pakai alamat
        // title: "Koordinat : [" + evt.position.coords.latitude +" , "+ evt.position.coords.longitude +" ] ",
        location : locateBtn.graphic.geometry
      });

      $("#lat").val(evt.position.coords.latitude);
      $("#lon").val(evt.position.coords.longitude);
        var asasa = {
          x: evt.target.graphic.geometry.x,
          y: evt.target.graphic.geometry.y,
          spatialReference:{
            wkid: evt.target.graphic.geometry.spatialReference.wkid,
          }
        };
        var coba = view.toScreen(asasa);
        view.hitTest(coba).then(({ results }) => {
          clickpoint(results);
        }).catch(function(error) {
          view.popup.title = "Alamat Tidak di Temukan";
          view.popup.content = 'Zona tidak di ketahui , Silakan pilih lokasi terdekat';
          $("#zona").val("");
          $("#subzona").val("");
          var availableTags = [''];
          $( "#fungsi_bangunan" ).autocomplete({
            source: function(request, response) {
              var results = $.ui.autocomplete.filter(availableTags, request.term);

              response(results.slice(0, 3));
            }
          });
        });
      locatorTask.locationToAddress(locateBtn.graphic.geometry).then(function(response){
        // Di matikan Karena blm ada permintaan / kecamatan
        // view.popup.title = response.address;
        parksLayer.definitionExpression = "KECAMATAN = '"+response.attributes.City.toUpperCase()+"'";
        // map.add(parksLayer);
        $("#alamat").val(response.address);
      }).catch(function(err) {
        view.popup.content =
        "Tidak ada lokasi yang ditemukan";
      });
      view.graphics.add(pointGraphic);
      var points = [
      [evt.position.coords.longitude, evt.position.coords.latitude]
      ];

      arrayUtils.forEach(points, function(point) {
       var graphic = new Graphic(new Point(point), makerSymbol);
         view.graphics.add(graphic);
         view.on("drag",(event) => {
          dragpoint(event);
        });
       });
    });
    // End Action Tombol Locate

    //Untuk Menampilkan widget Search
    var searchWidget = new Search({
      view: view,
      placeholder: "Cari Alamat",
    });

    //Untuk Mengatur Widget search
    view.ui.add(searchWidget, {
      position: "top-right",
      index: 2
    });
    // End Widget

    // Mulai Action Jika search sudah di klik
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
        symbol: makerSymbol,
        popupTemplate: template,
      })
      view.popup.open({
        // Di matikan Karena title sekarang pakai alamat
        // title: "Koordinat : [" + lat +" , "+ lon +" ] ",
        location : event.result.feature.geometry,

      });
      view.whenLayerView(parksLayer).then(function(layerView) {
        view.graphics.add(pointGraphic);
        var asasa = {
          x: layerView.view.graphics.items[0].geometry.x,
          y: layerView.view.graphics.items[0].geometry.y,
          spatialReference:{
            wkid: layerView.view.graphics.items[0].geometry.spatialReference.wkid,
          }
        };
        var coba = view.toScreen(asasa);
        view.hitTest(coba).then(({ results }) => {
          clickpoint(results);
        }).catch(function(error) {
          view.popup.title = "Alamat Tidak di Temukan";
          view.popup.content = 'Zona tidak di ketahui , Silakan pilih lokasi terdekat';
          $("#zona").val("");
          $("#subzona").val("");          
          var availableTags = [''];
          $( "#fungsi_bangunan" ).autocomplete({
            source: function(request, response) {
              var results = $.ui.autocomplete.filter(availableTags, request.term);

              response(results.slice(0, 3));
            }
          });
        });
      }).catch(function(error) {
        console.log(error);
      });


      locatorTask.locationToAddress(event.result.feature.geometry).then(function(response){
            // Di matikan Karena blm ada permintaan / kecamatan
            // view.popup.content = response.address;
            parksLayer.definitionExpression = "KECAMATAN = '"+response.attributes.City.toUpperCase()+"'";
            // map.add(parksLayer);
            $("#alamat").val(response.address);
            view.popup.title = response.address;
          }).catch(function(err) {
            view.popup.content =
            "Tidak ada lokasi yang ditemukan";
          });

          var points = [
          [lon, lat]
          ];

          arrayUtils.forEach(points, function(point) {
            var graphic = new Graphic(new Point(point), makerSymbol);
            view.on("drag",(event) => {
              dragpoint(event)
            });
          });
        });
      // End Search Location

    // Start jika maps di klik
    view.on("click", function(event) {
      view.graphics.removeAll();
      var lat = Math.round(event.mapPoint.latitude * 1000000) / 1000000;
      var lon = Math.round(event.mapPoint.longitude * 1000000) / 1000000;

      $("#lat").val(lat);
      $("#lon").val(lon);
      view.popup.open({
        // Di matikan Karena title sekarang pakai alamat
        // title: "Koordinat [" + lat + ", " + lon + "]",
        location: event.mapPoint
      });

      view.hitTest(event.screenPoint).then(({ results }) => {
        clickpoint(results);
        locatorTask.locationToAddress(event.mapPoint).then(function(
          response) {
          $("#alamat").val(response.address);
          view.popup.title = response.address;
          // Di matikan Karena blm ada permintaan / kecamatan
          // parksLayer.definitionExpression = "KECAMATAN = '"+response.attributes.City.toUpperCase()+"'";
          // map.add(parksLayer);
        }).catch(function(err) {
          view.popup.content =
          "Tidak ada lokasi yang ditemukan";
        });
      }).catch(function(error) {
        view.popup.content = 'Zona tidak di ketahui , Silakan pilih lokasi terdekat';
        $("#zona").val("");
        $("#subzona").val("");          
        var availableTags = [''];
          $( "#fungsi_bangunan" ).autocomplete({
            source: function(request, response) {
              var results = $.ui.autocomplete.filter(availableTags, request.term);

              response(results.slice(0, 3));
            }
          });
      });
      var points = [
      [lon, lat]
      ];

      arrayUtils.forEach(points, function(point) {
       var graphic = new Graphic(new Point(point), makerSymbol);
       view.graphics.add(graphic);
      //  view.on("drag",(event) => {
      //   dragpoint(event);
      // });
     });
    });
    // End klik maps
    function dragpoint(event) {
      var screenPoint = {
        x: event.x,
        y: event.y
      };
      view.hitTest(screenPoint).then(({ results }) => {
        const graphic = results[0].graphic;
        event.stopPropagation();
        view.graphics.removeAll();
        const g = graphic.clone();
        const pt = view.toMap(event);
        g.geometry = pt;
        var mp = webMercatorUtils.webMercatorToGeographic(pt);
        var lat = mp.y.toFixed(6);
        var lon =mp.x.toFixed(6);
        view.popup.open({
          // Di matikan Karena title sekarang pakai alamat
          // title: "Koordinat: [" + lat + ", " + lon + "]",
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
           $("#zona").val(results[1].graphic.attributes['ZONA']);
           $("#subzona").val(results[1].graphic.attributes['SUB_ZONA']);
           var izinkan = results[1].graphic.attributes['DIIZINKAN'].split(',');
           var b_syarat = results[1].graphic.attributes['BERSYARAT'].split(',');
           var t_batas = results[1].graphic.attributes['TERBATAS'].split(',');
           var t_bersyarat = results[1].graphic.attributes['TERBATAS_BERSYARAT'].split(',');
           var a = 0;
           var i = 0;
           var u = 0;
           var e = 0;
           var hasil = "";
            for (a; a< izinkan.length; a++) {
              hasil += izinkan[a] +"(Perizinan Yang di Perbolehkan),";
            }
            for (i; i< b_syarat.length; i++) {
              hasil += b_syarat[i] +"(Perizinan Bersyarat),";
            }
            for (u; u< t_batas.length; u++) {
              hasil += t_batas[u] +"(Perizinan Terbatas),";
            }
            for (e; e< t_bersyarat.length; e++) {
              hasil += t_bersyarat[e] +"(Perizinan Terbatas Bersyarat),";
            }
            var availableTags = hasil.split(',');
            $( "#fungsi_bangunan" ).autocomplete({
              source: function(request, response) {
                var results = $.ui.autocomplete.filter(availableTags, request.term);

                response(results.slice(0, 3));
              }
            });
         }else{
           view.popup.content = '<table class="esri-widget__table" summary="List of attributes and values"><tbody><tr><th class="esri-feature__field-header">Kecamatan</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['KECAMATAN']+'</td></tr><tr><th class="esri-feature__field-header">Kelurahan</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['KELURAHAN']+'</td></tr><tr><th class="esri-feature__field-header">Sublok</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['SUB_BLOK']+'</td></tr><tr><th class="esri-feature__field-header">Zona</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['ZONA']+'</td></tr><tr><th class="esri-feature__field-header">Sub Zona</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['SUB_ZONA']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Bersyarat</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['BERSYARAT']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Dizinkan</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['DIIZINKAN']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Terbatas</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['TERBATAS']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Terbatas Bersyarat</th><td class="esri-feature__field-data">' + results[0].graphic.attributes['TERBATAS_BERSYARAT']+'</td></tr></tbody></table>';
           $("#zona").val(results[0].graphic.attributes['ZONA']);
           $("#subzona").val(results[0].graphic.attributes['SUB_ZONA']);
           var izinkan = results[0].graphic.attributes['DIIZINKAN'].split(',');
           var b_syarat = results[0].graphic.attributes['BERSYARAT'].split(',');
           var t_batas = results[0].graphic.attributes['TERBATAS'].split(',');
           var t_bersyarat = results[0].graphic.attributes['TERBATAS_BERSYARAT'].split(',');
           var a = 0;
           var i = 0;
           var u = 0;
           var e = 0;
           var hasil = "";
            for (a; a< izinkan.length; a++) {
              hasil += izinkan[a] +"(Perizinan Yang di Perbolehkan),";
            }
            for (i; i< b_syarat.length; i++) {
              hasil += b_syarat[i] +"(Perizinan Bersyarat),";
            }
            for (u; u< t_batas.length; u++) {
              hasil += t_batas[u] +"(Perizinan Terbatas),";
            }
            for (e; e< t_bersyarat.length; e++) {
              hasil += t_bersyarat[e] +"(Perizinan Terbatas Bersyarat),";
            }
            var availableTags = hasil.split(',');
            $( "#fungsi_bangunan" ).autocomplete({
              source: function(request, response) {
                var results = $.ui.autocomplete.filter(availableTags, request.term);

                response(results.slice(0, 3));
              }
            });
         }
         locatorTask.locationToAddress(g.geometry).then(function(response) {
            // Di matikan Karena blm ada permintaan / kecamatan
            // parksLayer.definitionExpression = "KECAMATAN = '"+response.attributes.City.toUpperCase()+"'";
            // map.add(parksLayer);
            view.popup.title = response.address;
            $("#alamat").val(response.address);
          }).catch(function(err) {
            view.popup.content =
            "Tidak ada lokasi yang ditemukan";
          });
        }
      }).catch(function(err) {
        console.log(err);
        view.popup.title = "Alamat Tidak di Temukan";
        view.popup.content = 'Zona tidak di ketahui , Silakan pilih lokasi terdekat';
        // $("#idapa").val()
        $("#zona").val("");
        $("#subzona").val("");
        var availableTags = [''];
          $( "#fungsi_bangunan" ).autocomplete({
            source: function(request, response) {
              var results = $.ui.autocomplete.filter(availableTags, request.term);

              response(results.slice(0, 3));
            }
          });
        $("#izinkan").val("");
      });
    }
    //end Function Drag marker

    // Start Function Jika maps di klik, search dan locate button
    function clickpoint(evt) {
      if (evt[0].graphic.attributes == null) {
       view.popup.content = '<table class="esri-widget__table" summary="List of attributes and values"><tbody><tr><th class="esri-feature__field-header">Kecamatan</th><td class="esri-feature__field-data">' + evt[1].graphic.attributes['KECAMATAN']+'</td></tr><tr><th class="esri-feature__field-header">Kelurahan</th><td class="esri-feature__field-data">' + evt[1].graphic.attributes['KELURAHAN']+'</td></tr><tr><th class="esri-feature__field-header">Sublok</th><td class="esri-feature__field-data">' + evt[1].graphic.attributes['SUB_BLOK']+'</td></tr><tr><th class="esri-feature__field-header">Zona</th><td class="esri-feature__field-data">' + evt[1].graphic.attributes['ZONA']+'</td></tr><tr><th class="esri-feature__field-header">Sub Zona</th><td class="esri-feature__field-data">' + evt[1].graphic.attributes['SUB_ZONA']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Bersyarat</th><td class="esri-feature__field-data">' + evt[1].graphic.attributes['BERSYARAT']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Dizinkan</th><td class="esri-feature__field-data">' + evt[1].graphic.attributes['DIIZINKAN']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Terbatas</th><td class="esri-feature__field-data">' + evt[1].graphic.attributes['TERBATAS']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Terbatas Bersyarat</th><td class="esri-feature__field-data">' + evt[1].graphic.attributes['TERBATAS_BERSYARAT']+'</td></tr></tbody></table>';
       $("#zona").val(evt[1].graphic.attributes['ZONA']);
       $("#subzona").val(evt[1].graphic.attributes['SUB_ZONA']);
        var izinkan = evt[1].graphic.attributes['DIIZINKAN'].split(',');
       var b_syarat = evt[1].graphic.attributes['BERSYARAT'].split(',');
       var t_batas = evt[1].graphic.attributes['TERBATAS'].split(',');
       var t_bersyarat = evt[1].graphic.attributes['TERBATAS_BERSYARAT'].split(',');
           var a = 0;
           var hasil = "";
           for (a; a< izinkan.length; a++) {
              hasil += izinkan[a] +"(Perizinan Yang di Perbolehkan),";
           }
           var i = 0;
           for (i; i< b_syarat.length; i++) {
              hasil += b_syarat[i] +"(Perizinan Bersyarat),";
           }
           var u = 0;
           for (u; u< t_batas.length; u++) {
              hasil += t_batas[u] +"(Perizinan Terbatas),";
           }
           var e = 0;
           for (e; e< t_bersyarat.length; e++) {
              hasil += t_bersyarat[e] +"(Perizinan Terbatas Bersyarat),";
           }

       var availableTags = hasil.split(',');
       // console.log([availableTags])
        $("#fungsi_bangunan").val("");
        $( "#fungsi_bangunan" ).autocomplete({
          source: function(request, response) {
            var results = $.ui.autocomplete.filter(availableTags, request.term);

            response(results.slice(0, 3));
          }
        });

     }else{
       view.popup.content = '<table class="esri-widget__table" summary="List of attributes and values"><tbody><tr><th class="esri-feature__field-header">Kecamatan</th><td class="esri-feature__field-data">' + evt[0].graphic.attributes['KECAMATAN']+'</td></tr><tr><th class="esri-feature__field-header">Kelurahan</th><td class="esri-feature__field-data">' + evt[0].graphic.attributes['KELURAHAN']+'</td></tr><tr><th class="esri-feature__field-header">Sublok</th><td class="esri-feature__field-data">' + evt[0].graphic.attributes['SUB_BLOK']+'</td></tr><tr><th class="esri-feature__field-header">Zona</th><td class="esri-feature__field-data">' + evt[0].graphic.attributes['ZONA']+'</td></tr><tr><th class="esri-feature__field-header">Sub Zona</th><td class="esri-feature__field-data">' + evt[0].graphic.attributes['SUB_ZONA']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Bersyarat</th><td class="esri-feature__field-data">' + evt[0].graphic.attributes['BERSYARAT']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Dizinkan</th><td class="esri-feature__field-data">' + evt[0].graphic.attributes['DIIZINKAN']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Terbatas</th><td class="esri-feature__field-data">' + evt[0].graphic.attributes['TERBATAS']+'</td></tr><tr><th class="esri-feature__field-header">Perizinan Terbatas Bersyarat</th><td class="esri-feature__field-data">' + evt[0].graphic.attributes['TERBATAS_BERSYARAT']+'</td></tr></tbody></table>';
       $("#zona").val(evt[0].graphic.attributes['ZONA']);
       $("#subzona").val(evt[0].graphic.attributes['SUB_ZONA']);
       var izinkan = evt[0].graphic.attributes['DIIZINKAN'].split(',');
       var b_syarat = evt[0].graphic.attributes['BERSYARAT'].split(',');
       var t_batas = evt[0].graphic.attributes['TERBATAS'].split(',');
       var t_bersyarat = evt[0].graphic.attributes['TERBATAS_BERSYARAT'].split(',');
           var a = 0;
           var hasil = "";
           for (a; a< izinkan.length; a++) {
              hasil += izinkan[a] +"(Perizinan Yang di Perbolehkan),";
           }
            var i = 0;
           for (i; i< b_syarat.length; i++) {
              hasil += b_syarat[i] +"(Perizinan Bersyarat),";
           }
           var u = 0;
           for (u; u< t_batas.length; u++) {
              hasil += t_batas[u] +"(Perizinan Terbatas),";
           }
           var e = 0;
           for (e; e< t_bersyarat.length; e++) {
              hasil += t_bersyarat[e] +"(Perizinan Terbatas Bersyarat),";
           }

       var availableTags = hasil.split(',');
       // console.log([availableTags])
        $("#fungsi_bangunan").val("");
        $( "#fungsi_bangunan" ).autocomplete({
          source: function(request, response) {
            var results = $.ui.autocomplete.filter(availableTags, request.term);

            response(results.slice(0, 3));
          }
        });
     }
   }
   // End Function Klik
});
