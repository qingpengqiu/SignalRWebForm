
if(rWeight != 0){
          (function basic_radar(container) {
  // Fill series s1 and s2.
  var
    s1 = {  data : [[0, rWeight], [1, rHeight], [2, rHeel], [3, rForefeet], [4, rStiffness], [5, rStability]] },
    graph, ticks;
  // Radar Labels
  ticks = [
    [0, "重量（轻－重）"],
    [1, "高度（低－高）"],
    [2, "后跟减震（弱－强）"],
    [3, "前脚掌减震（弱－强）"],
    [4, "硬度（弱－强）"],
    [5, "稳定性（弱－强）"]
  ];
  // Draw the graph.
  graph = Flotr.draw(container, [ s1], {
    fontSize: 12,

    radar : { show : true}, 
    grid  : { circular : true, minorHorizontalLines : true}, 
    yaxis : { min : 0, max : 100, minorTickFreq : 2}, 
    xaxis : { ticks : ticks}
  });
})(document.getElementById("container"));
}