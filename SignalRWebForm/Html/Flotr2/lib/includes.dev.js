yepnope([
  // Libs
  '/Html/Flotr2/lib/bean-min.js',
  '/Html/Flotr2/lib/underscore-min.js',
  {
  test : (navigator.appVersion.indexOf("MSIE") != -1  && parseFloat(navigator.appVersion.split("MSIE")[1]) < 9),
    // Load for IE < 9
    yep : [
      '/Html/Flotr2/lib/excanvas.js',
      '/Html/Flotr2/lib/base64.js',
      '/Html/Flotr2/lib/canvastext.js'
    ]
  },
  '/Html/Flotr2/js/Flotr.js',
  '/Html/Flotr2/js/DefaultOptions.js',
  '/Html/Flotr2/js/Color.js',
  '/Html/Flotr2/js/Date.js',
  '/Html/Flotr2/js/DOM.js',
  '/Html/Flotr2/js/EventAdapter.js',
  '/Html/Flotr2/js/Text.js',
  '/Html/Flotr2/js/Graph.js',
  '/Html/Flotr2/js/Axis.js',
  '/Html/Flotr2/js/Series.js',
  '/Html/Flotr2/js/types/lines.js',
  '/Html/Flotr2/js/types/bars.js',
  '/Html/Flotr2/js/types/points.js',
  '/Html/Flotr2/js/types/pie.js',
  '/Html/Flotr2/js/types/candles.js',
  '/Html/Flotr2/js/types/markers.js',
  '/Html/Flotr2/js/types/radar.js',
  '/Html/Flotr2/js/types/bubbles.js',
  '/Html/Flotr2/js/types/gantt.js',
  '/Html/Flotr2/js/types/timeline.js',
  '/Html/Flotr2/js/plugins/download.js',
  '/Html/Flotr2/js/plugins/selection.js',
  '/Html/Flotr2/js/plugins/spreadsheet.js',
  '/Html/Flotr2/js/plugins/grid.js',
  '/Html/Flotr2/js/plugins/hit.js',
  '/Html/Flotr2/js/plugins/crosshair.js',
  '/Html/Flotr2/js/plugins/labels.js',
  '/Html/Flotr2/js/plugins/legend.js',
  '/Html/Flotr2/js/plugins/titles.js',

  // Examples

  '/infocenter/basic-bars.aspx',
  '/infocenter/flotrgr.aspx'

]);
