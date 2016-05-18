
if(shoedata!=0){
  (function basic_bars(container, horizontal) {

    var
    horizontal = (horizontal ? true : false),
        // Show horizontal bars
        d1 = shoedata
    // Draw the graph
    Flotr.draw(
    container, [d1], {
       
        shadowSize: 11,  

        grid:{
         color: '#b4d179',
         labelMargin: 6,

         verticalLines: false,
         
        },
        bars: {
            show: true,
            horizontal: horizontal,
            shadowSize: 0,
            barWidth: 0.7
        },

        mouse: {
            relative: true
        },
        yaxis: {
          tickDecimals:0,
            min:0
           
        },
        xaxis: {
            ticks:[[1,"ǰ11��"],[2,"ǰ10��"],[3,"ǰ9��"],[4,"ǰ8��"],[5,"ǰ7��"],[6,"ǰ6��"],[7,"ǰ5��"],[8,"ǰ4��"],[9,"ǰ3��"],[10,"ǰ2��"],[11,"����"],[12,"����"]],
            color:null
           
        }
    });
})(document.getElementById("Flotr2gr"));
}