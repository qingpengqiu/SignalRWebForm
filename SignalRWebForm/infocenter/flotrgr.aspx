
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
            ticks:[[1,"前11周"],[2,"前10周"],[3,"前9周"],[4,"前8周"],[5,"前7周"],[6,"前6周"],[7,"前5周"],[8,"前4周"],[9,"前3周"],[10,"前2周"],[11,"上周"],[12,"本周"]],
            color:null
           
        }
    });
})(document.getElementById("Flotr2gr"));
}