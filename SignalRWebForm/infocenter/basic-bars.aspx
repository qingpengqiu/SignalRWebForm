
if(rWeight != 0){
          (function basic_radar(container) {
  // Fill series s1 and s2.
  var
    s1 = {  data : [[0, rWeight], [1, rHeight], [2, rHeel], [3, rForefeet], [4, rStiffness], [5, rStability]] },
    graph, ticks;
  // Radar Labels
  ticks = [
    [0, "�������ᣭ�أ�"],
    [1, "�߶ȣ��ͣ��ߣ�"],
    [2, "�����������ǿ��"],
    [3, "ǰ���Ƽ�������ǿ��"],
    [4, "Ӳ�ȣ�����ǿ��"],
    [5, "�ȶ��ԣ�����ǿ��"]
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