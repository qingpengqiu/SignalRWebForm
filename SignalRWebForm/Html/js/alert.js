/*-------------------------------------------------------------------------------------------
功能：通过XML中的ID节点text返回提示信息
参数：tipId表示XML中ID节点的text
---------------------------------------------------------------------------------------------*/
function getTip(tipId) {
    var returnVal = "";
    $.ajax({
        url: 'xml/tip.xml',
        type: 'get',
        dataType: 'xml',
        timeout: 1000,
        cache: true,
        async: false,
        error: function(xml) {
            returnVal = 'Loading Error!';
        },
        success: function(xml) {
            var language = $(xml).find('language:first').children("value").text();
            $(xml).find("alerttip").each(function(i) {
                var idVal = $(this).children("id").text();
                if (idVal == tipId) {
                    returnVal = $(this).children(language).text();
                    return false;
                }
            });
        }
    });
    return returnVal;
}

/*-------------------------------------------------------------------------------------------
功能：Windows弹框，通过传入XML文件中ID节点的text查找提示正文
参数：tipId表示XML中ID节点的text
---------------------------------------------------------------------------------------------*/
function alertXml(tipId) {
    alert(getTip(tipId));
}

/*-------------------------------------------------------------------------------------------
功能：Windows弹框，通过传入提示正文
参数：tips表示提示正文
destUrl表示要跳转的目的路径
---------------------------------------------------------------------------------------------*/
function alertGo(tips, destUrl) {
    alert(tips);
    location.href = destUrl;
}

/*-------------------------------------------------------------------------------------------
功能：Windows弹框，通过传入XML文件中ID节点的text查找提示正文
参数：tipId表示XML中ID节点的text
destUrl表示要跳转的目的页面路径
---------------------------------------------------------------------------------------------*/
function alertGoXml(tipId, destUrl) {
    alertGo(getTip(tipId), destUrl);
}

/*-------------------------------------------------------------------------------------------
功能：BlockUI弹框，提示正文直接由参数传入
参数：tips表示提示正文
---------------------------------------------------------------------------------------------*/
function alertBlockUi(tips) {
    $.blockUI({ message: '<br/><h1>' + tips + '</h1><br/>', css: { width: '600px' }, timeout: 2000 });
}

/*-------------------------------------------------------------------------------------------
功能：BlockUI弹框，通过传入XML文件中ID节点的text查找提示正文
参数：tipId表示XML中ID节点的text
---------------------------------------------------------------------------------------------*/
function alertBlockUiXml(tipId) {
    alertBlockUi(getTip(tipId));
}

/*-------------------------------------------------------------------------------------------
功能：BlockUI弹框并跳转，提示正文直接由参数传入
参数：tips表示提示正文
             destUrl表示要跳转的目的页面路径
---------------------------------------------------------------------------------------------*/
function alertBlockUiGo(tips, destUrl) {
    $.blockUI({ message: '<br/><h1>' + tips + '</h1><br/>', css: { width: '600px' }, timeout: 2000 });
    setTimeout(function() { $.unblockUI({ onUnblock: function() { location.href = destUrl; } }); }, 2000);
}

/*-------------------------------------------------------------------------------------------
功能：BlockUI弹框并跳转，通过传入XML文件中ID节点的text查找提示正文
参数：tipId表示XML中ID节点的text
             destUrl表示要跳转的目的页面路径
---------------------------------------------------------------------------------------------*/
function alertBlockUiGoXml(tipId, destUrl) {
    alertBlockUiGo(getTip(tipId), destUrl);
}