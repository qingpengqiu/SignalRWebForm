;(function(win, doc){
 
win.cellphoneRegex = new RegExp(/^1[345678][\d]{9}$/);
win.log = win.clog = function(m){ if( win.console){ win.console.log( m);} }
;(function(){
  if(!!navigator.userAgent.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/)){
      var style = doc.createElement("style");
      style.type = "text/css";
      style['textContent'] = '.ofa{overflow: auto;-webkit-overflow-scrolling: touch; }';
      doc.getElementsByTagName("HEAD").item(0).appendChild(style);
  }
})();
/**
 * 收集与域名有关的数据。
 */
win.__DOMAIN = { 
    host : null, 
    isHttps: false, 

    isOnline: true, 
    // i0域名下，i0与yongche这两字符串间的分隔符。内网是-，外网是.
    spChar: '.'
};

if( __DOMAIN.host == null){
    /*
     * 因为js/css的域名和网站域名不一致，所以需要从do.js/do.src.js文件中读取
     * 域名信息。
     * 因为js/css的域名使用了四个分流口，所以所得域名前的i1字样要去除。分流口
     * 的使用还取决于域名的协议号。
     */
    var scripts = doc.getElementsByTagName('script');
    for( var i = 0; i < scripts.length; i ++) {
        var path = scripts[i].src;
        if( /\/do\.js|\/do\.all(\.src)?\.js/.exec(path) != null ){
            var exc = /^http(s?):\/\/([a-zA-Z0-9\-\.]+yongche\.(?:org|com|name|cn))\//.exec( path);
            if( exc != null ){
                __DOMAIN.host = exc[2];
                __DOMAIN.isOnline = exc[2].indexOf('yongche.name') != -1;
                 
                if(!__DOMAIN.isOnline) {
                    __DOMAIN.spChar = '-';
                }
                __DOMAIN.isHttps = 's' == exc[1];
                break;
            }
        }
    }
}
var cLib = (__DOMAIN.isHttps ? 'https://' : 'http://') + __DOMAIN.host;

//只在H5页面引用zepto
var is_wap = win.location.pathname.indexOf('/touch') == 0;
cLib += is_wap ? 'zepto_1.1.6.js' : 'jquery-1.7.2.min.js';

// 已加载模块
var loaded = {},

// 已加载列表
loadList = {},

// 加载中的模块
loadingFiles = {},

// 内部配置文件
config = {
    // 是否自动加载核心库
    autoLoad: true,

    // 加载延迟
    timeout: 6000,

    // 核心库
    coreLib: [ cLib],

    /* 模块依赖
     * {
     *  moduleName: {
     *      path: 'URL',
     *      type:'js|css',
     *      requires:['moduleName1', 'fileURL']
     *  }
     * }
     */
    mods: {}
},

jsSelf = (function() { 
  var files = doc.getElementsByTagName('script'); 
  return files[files.length - 1];
})(),

// 全局模块
globalList = [],

// 外部参数
extConfig,

// domready回调堆栈
readyList = [],

// DOM Ready
isReady = false,

// 模块间的公共数据 
publicData = {},

// 公共数据回调堆栈 
publicDataStack = {},

isArray = function(e) { 
  return e.constructor === Array; 
},

getMod = function(e) {
 var mods = config.mods, mod; 
 if (typeof e === 'string') {
   mod = (mods[e])? mods[e] : { path: e };
 } else {
   mod = e;
 }
 return mod;
},

load = function(url, type, charset, cb) {
    var wait, n, t, img, 

    done = function() {
      loaded[url] = 1;
      cb && cb(url);
      cb = null;
      win.clearTimeout(wait);
    };

    if (!url) {
        return;
    }

    if (loaded[url]) {
        loadingFiles[url] = false;
        if (cb) {
            cb(url);
        }
        return;
    }

    if (loadingFiles[url]) {
        setTimeout(function() {
            load(url, type, charset, cb);
        }, 10);
        return;
    }

    loadingFiles[url] = true;

    wait = win.setTimeout(function() {
    /* 目前延时回调处理，超时后如果有延时回调，执行回调，然后继续等
     * 延时回调的意义是log延时长的URI，这个处理不属于加载器本身的功能移到外部
     * 没有跳过是为了避免错误。
     */
      if (config.timeoutCallback) {
        try {
          config.timeoutCallback(url); 
        } catch(ex) {}
      }
    }, config.timeout);

    t =  type || url.toLowerCase().split(/\./).pop().replace(/[\?#].*/, '');

    if (t === 'js') {
      n = doc.createElement('script');
      n.setAttribute('type', 'text/javascript');
      n.setAttribute('src', url);
      n.setAttribute('async', true);
    } else if (t === 'css') {
      n = doc.createElement('link');
      n.setAttribute('type', 'text/css');
      n.setAttribute('rel', 'stylesheet');
      n.setAttribute('href', url);
    }

    if (charset) {
      n.charset = charset;
    }

    if (t === 'css') {
      // 暂不判断css错误
      // img = new Image();
      // img.onerror = function() {
      //   done();
      //   img.onerror = null;
      //   img = null;
      // }
      // img.src = url;
      setTimeout(function(){
        done();
      },0);
    } else {
    //if (t === 'js') {
      // firefox, safari, chrome, ie9下加载失败触发
      // 如果文件是404, 会比timeout早触发onerror。目前不处理404，只处理超时
      n.onerror = function() {
        done();
        n.onerror = null;
      };

      // ie6~8通过创建vbscript可以识别是否加载成功。
      // 但这样需先测试性加载再加载影响性能。即使没成功加载而触发cb，顶多报错，没必要杜绝这种报错

      // ie6~9下加载成功或失败，firefox, safari, opera下加载成功触发
      n.onload = n.onreadystatechange = function() {
        var url;
        if (!this.readyState ||
            this.readyState === 'loaded' ||
            this.readyState === 'complete') {
          setTimeout(function(){
            done();
          },0);
          n.onload = n.onreadystatechange = null;
        }
      };
    }

    jsSelf.parentNode.insertBefore(n, jsSelf);
},

  // 加载依赖论文件(顺序)
  loadDeps = function(deps, cb) {
    var mods = config.mods, 
    id, m, mod, i = 0, len;

    id = deps.join('');
    len = deps.length;

    if (loadList[id]) {
      cb();
      return;
    }

    function callback() {
      if(!--len) {
        loadList[id] = 1;
        cb();
      }
    }

    for (; m = deps[i++]; ) {
      mod = getMod(m);
      if (mod.requires) {
        loadDeps(mod.requires, (function(mod){
          return function(){
            load(mod.path, mod.type, mod.charset, callback);
          };
        })(mod));
      } else {
        load(mod.path, mod.type, mod.charset, callback);
      }
    }
  },

  /*!
   * contentloaded.js
   *
   * Author: Diego Perini (diego.perini at gmail.com)
   * Summary: cross-browser wrapper for DOMContentLoaded
   * Updated: 20101020
   * License: MIT
   * Version: 1.2
   *
   * URL:
   * http://javascript.nwbox.com/ContentLoaded/
   * http://javascript.nwbox.com/ContentLoaded/MIT-LICENSE
   *
   */

  // @win window reference
  // @fn function reference
  contentLoaded = function(fn) {
    var done = false, top = true, 
    doc = win.document, 
    root = doc.documentElement,
    add = doc.addEventListener ? 'addEventListener' : 'attachEvent',
    rem = doc.addEventListener ? 'removeEventListener' : 'detachEvent',
    pre = doc.addEventListener ? '' : 'on',

    init = function(e) {
      if (e.type == 'readystatechange' && doc.readyState != 'complete') return;
      (e.type == 'load' ? win : doc)[rem](pre + e.type, init, false);
      if (!done && (done = true)) fn.call(win, e.type || e);
    },

    poll = function() {
      try { root.doScroll('left'); } catch(e) { setTimeout(poll, 50); return; }
      init('poll');
    };

    if (doc.readyState == 'complete') fn.call(win, 'lazy');
    else {
      if (doc.createEventObject && root.doScroll) {
        try { top = !win.frameElement; } catch(e) { }
        if (top) {
          poll();
        }
      }
      doc[add](pre + 'DOMContentLoaded', init, false);
      doc[add](pre + 'readystatechange', init, false);
      win[add](pre + 'load', init, false);
    }
  },

  fireReadyList = function() {
    var list;
    while (list = readyList.shift()) {
      d.apply(null, list);
    }
  },

  d = function() {
    var args = [].slice.call(arguments), fn, id;

    // 加载核心库
    if (config.autoLoad &&
        config.coreLib.length &&
        !loadList[config.coreLib.join('')]) {
      loadDeps(config.coreLib, function(){
        d.apply(null, args);
      });
      return;
    }

    // 加载全局库
    if (globalList.length &&
        !loadList[globalList.join('')]) {
      loadDeps(globalList, function(){
        d.apply(null, args);
      });
      return;
    }

    if (typeof args[args.length - 1] === 'function' ) {
      fn = args.pop();
    }

    id = args.join('');

    if ((args.length === 0 || loadList[id]) && fn) {
      fn();
      return;
    }

    loadDeps(args, function() {
      loadList[id] = 1;
      fn && fn();
    });
  };

// 保证线上连接的是压缩后的js脚本
var isOnline = window.location.hostname.indexOf('yongche.com') >= 0 ;
var srcReg = /(.*)\.src(\.js.*)/;
//
d.add = d.define = function(sName, oConfig) {
  if (!sName || !oConfig || !oConfig.path) {
    return;
  }
  if( isOnline && srcReg.test(oConfig.path)){
      oConfig.path = oConfig.path.replace( srcReg, '$1$2');
  }
  config.mods[sName] = oConfig;
};

d.delay = function() {
  var args = [].slice.call(arguments), delay = args.shift();
  win.setTimeout(function() {
      d.apply(this, args);
      }, delay);
};

d.global = function() {
  var args = isArray(arguments[0])? arguments[0] : [].slice.call(arguments);
  globalList = globalList.concat(args);
};

d.ready = function() {
  var args = [].slice.call(arguments);
  if (isReady) {
    return d.apply(this, args);
  }
  readyList.push(args);
};

d.css = function(s) {
  var css = doc.getElementById('do-inline-css');
  if (!css) {
    css = doc.createElement('style');
    css.type = 'text/css';
    css.id = 'do-inline-css';
    jsSelf.parentNode.insertBefore(css, jsSelf);
  }

  if (css.styleSheet) {
    css.styleSheet.cssText = css.styleSheet.cssText + s;
  } else {
    css.appendChild(doc.createTextNode(s));
  }
};

d.setData = d.setPublicData = function(prop, value) {
  var cbStack = publicDataStack[prop];

  publicData[prop] = value;

  if (!cbStack) {
    return;
  }

  while (cbStack.length > 0) {
    (cbStack.pop()).call(this, value);
  }
};

d.getData = d.getPublicData = function(prop, cb) {
  if (publicData[prop]) {
    cb(publicData[prop]);
    return;
  } 

  if (!publicDataStack[prop]) {
    publicDataStack[prop] = [];
  }

  publicDataStack[prop].push(function(value){
      cb(value);
      });
};

d.setConfig = function(n, v) {
  config[n] = v;
  return d;
};

d.getConfig = function(n) {
  return config[n];
};


// 初始外部配置
extConfig = jsSelf.getAttribute('data-cfg-autoload');
if (extConfig) {
  config.autoLoad = (extConfig.toLowerCase() === 'true') ? true : false;
}

extConfig = jsSelf.getAttribute('data-cfg-corelib');
if (extConfig) {
  config.coreLib = extConfig.split(',');
}

if (typeof Do !== 'undefined') {
  globalList = Do.global.mods;
  config.mods = Do.mods;
  //readyList = Do.actions;
  var act;
  while (act = Do.actions.shift()) {
    d.apply(null, act);
  }
  delete Do;
}

win.Do = d;

contentLoaded(function() {
  isReady = true;
  fireReadyList();
});

})(window, document);
(function(win, doc){
     
    // 每个资源的路径都有规律可寻，而且又有些不同，所以用数组来组装数据
    // 然后再循环增加Do.mod，省时省力。
    // 因为有资源的域名有i0-i3四个分流口，所以用自增变量DOMAIN_COUNT来记录，
    // 保证在不更改资源列表排列的情况下，每个资源都分配到统一的分流口。

    var domain_count = 0,
        rand = "",
        url = '',
        scripts = doc.getElementsByTagName("script");

    for (var i = 0, len = scripts.length; i < len; i ++) {
        url = scripts[i].src;
        if(url.indexOf("do.all") != -1) {
            rand = url.substr(url.indexOf("?") + 1);
            break;
        }
    }

    function prependPath(res, path, isHttps) { // isHttps :是否是https的域名，该域名专用i0分流口，http用i1-i3
        res = res || [];
        path = path || '';

        var file = "";
        for(var i = 0; i < res.length; i ++) {
            var paths = res[i];
            if(paths.length >= 2) {
                var numprefix = 'i' + ((domain_count ++ % 3) + 1);
                var prefix = isHttps ? ('https://' + path) : ('http://' + (/^i\d/.test(path) ? numprefix + path.substr(2) : path));
                res[i][1] = prefix + paths[1];
            }
        }

        return res;
    }

    win.PREPENDPATH = prependPath;

    var jss = [
        ['j.alerts.css', 'jquery.alerts/jquery.alerts-1.1.src.css'],
        ['j.alerts', 'jquery.alerts/jquery.alerts-1.1.src.js', ['j.alerts.css']],

        ['j.idTabs', 'jquery.idTabs/jquery.idTabs-2.2.js'],
        ['j.idTabs.hover', 'jquery.idTabs/jquery.idTabs.hover-2.2.js'],

        ['j.cookie', 'jquery.cookie/jquery.cookie.src.js'],
        ['j.json', 'jquery.json/jquery.json-2.3.js'],
        ['j.loopedSlider', 'jquery.loopedSlider/jquery.loopedSlider.src.js'],
        ['j.placeholder', 'jquery.placeholder/jquery.placeholder.src.js?2'],
        ['j.pngFix', 'jquery.pngFix/jquery.pngFix-1.2.src.js'],
         
        ['j.poshytip.css', 'jquery.poshytip/css/tip-yellow/tip-yellow.src.css'],
        ['j.poshytip', 'jquery.poshytip/jquery.poshytip-1.1.src.js', [ 'j.poshytip.css']],
         
        ['j.swfobject', 'jquery.swfobject/jquery.swfobject-1.1.js'],
        ['j.tmpl', 'jquery.tmpl/jquery.tmpl-1.0.js'],
        ['j.tooltip', 'jquery.tooltip/jquery.tooltip-1.2.4.js' ],
        ['j.validate.core', 'jquery.validate/jquery.validate-1.10.src.js'],
        ['j.validate', 'jquery.validate/messages_cn.js', ['j.validate.core']],
        ['j.form', 'jquery.form/jquery.form.src.js'],
        ['j.html5Validate', 'jquery.html5Validate/jquery-html5Validate.src.js'],
        ['j.html5Validate-qy', 'jquery.html5Validate/jquery-html5Validate-qy.src.js'],

        ['j.timepicker.css', 'jquery.timepicker/jquery-ui-timepicker-addon.src.css'],
        ['j.timepicker', 'jquery.timepicker/jquery-ui-timepicker-addon.src.js', ['j.timepicker.css','j.ui.datepicker', 'j.ui.slider']],

        ['j.copy.source','jquery.copy/zeroClipboard.js'],
        ['j.copy', 'jquery.copy/jquery.copy.js',['j.copy.source']],

        ['j.popup.css','jquery.popup/popuptips.src.css'],
        ['j.popup','jquery.popup/popuptips.src.js', ['j.popup.css']],

        ['j.mobiscroll.css', 'jquery.mobiscroll/css/mobiscroll.custom-2.5.0.src.css?0827'],
        ['j.mobiscroll', 'jquery.mobiscroll/mobiscroll.custom-2.5.0.src.js', 
            ['j.mobiscroll.css']],

        [ 'j.touchwipe', 'jquery.touchwipe/jquery.touchwipe.1.1.1.src.js'],
        [ 'j.cycle', 'jquery.cycle/jquery.cycle.src.js'],

        [ 'j.checkbox', 'jquery.checkbox/jquery.checkbox.src.js'],
        [ 'j.styleSelect', 'jquery.styleSelect/jquery.styleSelect.src.js'],
        [ 'j.mousewheel', 'jquery.mousewheel/jquery.mousewheel.src.js'],
        [ 'j.raphael', 'jquery.raphael/raphael.src.js'],
        [ 'j.modernizr', 'jquery.modernizr/modernizr.custom.67830.js'],
        [ 'h5_upload', '../mobile/uploadFile.src.js'],
        [ 'lazy_load', 'jquery.lazyLoad/jquery.lazyload.1.9.3.js']

    ];

    jss = prependPath(jss, __DOMAIN.host + '/js/jquery.plugins/', __DOMAIN.isHttps);

    // 原本在custom里面，但要做DNS，同时防DNS缓存，所以放在这里。其实这个脚本不存在，被proxy到了
    // /ajax/_get_base_info.php?type=city_list里面。
    jss = jss.concat(prependPath([["c.yc.citys", "/js/app/common/yc.citys.js?rd=" + rand]], __DOMAIN.host, __DOMAIN.isHttps));

    jss = jss.concat(prependPath([['c.ut', '/js/app/common/ut.js?' + rand]], __DOMAIN.host, __DOMAIN.isHttps));

    var uicss= [ ['j.ui.css', '/js/jquery.plugins/jquery.ui/1.8.20/themes/base/jquery.ui.all.css']];
    var uis = [
        ['j.ui.core', 'jquery.ui.core.js', ['j.ui.css']],
        ['j.ui.widget', 'jquery.ui.widget.js'],
        ['j.ui.position', 'jquery.ui.position.js'],

        ['j.ui.mouse', 'jquery.ui.mouse.js', ['j.ui.widget']],
        ['j.ui.draggable', 'jquery.ui.draggable.js', ['j.ui.core', 'j.ui.mouse']],
        ['j.ui.resizable', 'jquery.ui.resizable.js', ['j.ui.core', 'j.ui.mouse']],
        ['j.ui.droppable', 'jquery.ui.droppable.js', ['j.ui.draggable']],
        ['j.ui.selectable', 'jquery.ui.selectable.js', ['j.ui.core', 'j.ui.mouse']],
        ['j.ui.sortable', 'jquery.ui.sortable.js', ['j.ui.core', 'j.ui.mouse']],

        ['j.ui.accordion', 'jquery.ui.accordion.js', [ 'j.ui.core', 'j.ui.widget']],
        ['j.ui.autocomplete', 'jquery.ui.autocomplete.js', ['j.ui.core','j.ui.widget','j.ui.position']],
        ['j.ui.button', 'jquery.ui.button.js',['j.ui.core']],
        ['j.ui.datepicker', 'jquery.ui.datepicker.js', ['j.ui.core']],
        ['j.ui.datepicker.i18n.zh', 'i18n/jquery.ui.datepicker-zh-CN.js', ['j.ui.datepicker']],
        ['j.ui.dialog', 'jquery.ui.dialog.js', 
            ['j.ui.button', 'j.ui.draggable', 'j.ui.position', 'j.ui.resizable']],
        ['j.ui.progressbar', 'jquery.ui.progressbar.js', ['j.ui.core', 'j.ui.widget']],
        ['j.ui.slider', 'jquery.ui.slider.js', ['j.ui.core', 'j.ui.mouse']],
        ['j.ui.tabs', 'jquery.ui.tabs.js', ['j.ui.core', 'j.ui.widget']]
    ];

    uicss = prependPath(uicss, __DOMAIN.host, __DOMAIN.isHttps);
    uis = prependPath(uis, __DOMAIN.host + '/js/jquery.plugins/jquery.ui/1.8.20/ui/', __DOMAIN.isHttps);


    uis = uicss.concat(uis);

    var mobicss = [
        ['j.mobi.icons.css', 'css/mobiscroll.icons.css'],
        ['j.mobi.widget.css', 'css/mobiscroll.widget.css'],
        ['j.mobi.widget.ios7.css', 'css/mobiscroll.widget.ios7.css'],
        ['j.mobi.scroller.css', 'css/mobiscroll.scroller.css'],
        ['j.mobi.scroller.ios7.css', 'css/mobiscroll.scroller.ios7.css'],
        ['j.mobi.animation.css', 'css/mobiscroll.animation.css']
    ];
    
    var mobijs = [
        /*['j.mobi.core', 'js/mobiscroll.core.js'],
        ['j.mobi.util.datetime', 'js/mobiscroll.util.datetime.js',['j.mobi.core']],
        ['j.mobi.widget', 'js/mobiscroll.widget.js',['j.mobi.core']],
        ['j.mobi.scroller', 'js/mobiscroll.scroller.js',['j.mobi.core']],
        ['j.mobi.datetime', 'js/mobiscroll.datetime.js',['j.mobi.util.datetime']],
        ['j.mobi.select', 'js/mobiscroll.select.js',['j.mobi.core']],
        ['j.mobi.widget.ios7', 'js/mobiscroll.widget.ios7.js',['j.mobi.core']],*/
        ['j.mobiscroll_new', 'js/mobiscroll.all.src.js',['j.mobi.icons.css','j.mobi.widget.css','j.mobi.widget.ios7.css','j.mobi.scroller.css','j.mobi.scroller.ios7.css','j.mobi.animation.css']],
        ['j.mobiscroll_new-yop', 'js/mobiscroll.all-yop.src.js',['j.mobi.icons.css','j.mobi.widget.css','j.mobi.widget.ios7.css','j.mobi.scroller.css','j.mobi.scroller.ios7.css','j.mobi.animation.css']]
    ];

    mobicss = prependPath(mobicss, __DOMAIN.host + '/js/jquery.plugins/jquery.mobiscroll/mobiscroll-2.13.2/', __DOMAIN.isHttps);
    mobijs = prependPath(mobijs, __DOMAIN.host + '/js/jquery.plugins/jquery.mobiscroll/mobiscroll-2.13.2/', __DOMAIN.isHttps);

    mobijs = mobicss.concat(mobijs);
    mobijs = uis.concat(mobijs);

    win._loadUserDone = function(userData){
        if(userData.code == 200){
            win.USERDATA = userData.result;
            win.USERdATAFULL = userData;
        }
    }

    var hostname = win.location.hostname,
        suffix = hostname.indexOf('qiye.yongche') >= 0 || hostname.indexOf('corporate.yongche') >= 0 ? '' : '.php';

    mobijs.push(['userload', '/ajax/loaduser'+suffix+'?callback=_loadUserDone&.js=aa&rd=' + (Math.random() * 99999)]);

    function addDo(res){
        res = res || [];
        for(var i = 0; i < res.length; i ++){
            var obj = res[i];
            Do.add(obj[0], { 
                path: obj[1], 
                type: (/\.js/.test(obj[1])) ? 'js': 'css', 
                requires: obj[2],
                charset: "UTF-8"
            });
        }
    }

    win.ADDDO = addDo;

    addDo(jss.concat(mobijs));

})(window, document);
/* This file is auto generated by utils/generate_do.js, please Don't edit this file manually. */
var _do_custom_arr = [];
_do_custom_arr.push(['b.order_info','/js/app/bus-wx/order_info.src.js?1444816241']);
_do_custom_arr.push(['c.autoreg','/js/app/common/autoreg.src.js?1444816241']);
_do_custom_arr.push(['c.business.city','/js/app/common/business.city.src.js?1444816241']);
_do_custom_arr.push(['c.common_h5-qy','/js/app/common/common_h5-qy.src.js?1444816241']);
_do_custom_arr.push(['c.common_h5','/js/app/common/common_h5.src.js?1444816241']);
_do_custom_arr.push(['c.common','/js/app/common/common.src.js?1444816241']);
_do_custom_arr.push(['c.header.cp','/js/app/common/header.cp.src.js?1444816241']);
_do_custom_arr.push(['c.header','/js/app/common/header.src.js?1452617154']);
_do_custom_arr.push(['c.j-plugins','/js/app/common/j-plugins.src.js?1444816241']);
_do_custom_arr.push(['c.j.mapabc','/js/app/common/jquery.mapabc.src.js?1444816241']);
_do_custom_arr.push(['c.j.total-city','/js/app/common/jquery.total-city.src.js?1444816241']);
_do_custom_arr.push(['c.j.touch','/js/app/common/jquery.touch.src.js?1444816241']);
_do_custom_arr.push(['c.j.yc-autocpl','/js/app/common/jquery.yc-autocpl.src.js?1444816241']);
_do_custom_arr.push(['c.j.yc_events','/js/app/common/jquery.yc_events.src.js?1444816241']);
_do_custom_arr.push(['c.j.yc-yop-autocpl','/js/app/common/jquery.yc-yop-autocpl.src.js?1444816241']);
_do_custom_arr.push(['c.logreg-qy','/js/app/common/logreg-qy.src.js?1444816241']);
_do_custom_arr.push(['c.logreg','/js/app/common/logreg.src.js?1447738495']);
_do_custom_arr.push(['c.verifycode_new-qy','/js/app/common/verifycode_new-qy.src.js?1444816241']);
_do_custom_arr.push(['c.verifycode_new','/js/app/common/verifycode_new.src.js?1444816241']);
_do_custom_arr.push(['c.verifycode','/js/app/common/verifycode.src.js?1444816241']);
_do_custom_arr.push(['h.homepage','/js/app/hp/homepage.src.js?1444816241']);
_do_custom_arr.push(['i.s.share','/js/app/i/share/share.src.js?1444816241']);
_do_custom_arr.push(['i.u.viewport','/js/app/i/user-to-user/viewport.src.js?1444816241']);
_do_custom_arr.push(['i.w.js-api','/js/app/i/weixin/js-api.src.js?1444816241']);
_do_custom_arr.push(['k.j.j-ui-timepicker-addon','/js/app/ka/jquery.timepicker/jquery-ui-timepicker-addon.src.js?1444816241']);
_do_custom_arr.push(['k.j.j.ui.timepicker.chart','/js/app/ka/jquery.timepicker/jquery.ui.timepicker.chart.src.js?1444816241']);
_do_custom_arr.push(['o.car','/js/app/order/car.src.js?1444816241']);
_do_custom_arr.push(['o.decision_common','/js/app/order/decision_common.src.js?1444816241']);
_do_custom_arr.push(['o.decision_driver_list','/js/app/order/decision_driver_list.src.js?1452617154']);
_do_custom_arr.push(['o.decision','/js/app/order/decision.src.js?1444816241']);
_do_custom_arr.push(['o.orderComplate','/js/app/order/orderComplate.src.js?1444816241']);
_do_custom_arr.push(['o.orderinfoBrand','/js/app/order/orderinfoBrand.src.js?1444816241']);
_do_custom_arr.push(['o.order_info','/js/app/order/order_info.src.js?1456359807']);
_do_custom_arr.push(['o.orderinfo','/js/app/order/orderinfo.src.js?1444816241']);
_do_custom_arr.push(['o.passengerInfo','/js/app/order/passengerInfo.src.js?1444816241']);
_do_custom_arr.push(['o.rides','/js/app/order/rides.src.js?1444816241']);
_do_custom_arr.push(['o.route','/js/app/order/route.src.js?1444816241']);
_do_custom_arr.push(['p.common_h5','/js/app/payment/common_h5.src.js?1444816241']);
_do_custom_arr.push(['w.business.city','/js/app/wx/business.city.src.js?1444816241']);
_do_custom_arr.push(['w.decision','/js/app/wx/decision.src.js?1444816241']);
_do_custom_arr.push(['w.geolocation','/js/app/wx/geolocation.src.js?1444816241']);
_do_custom_arr.push(['w.order_coupon','/js/app/wx/order_coupon.src.js?1444816241']);
_do_custom_arr.push(['w.order_info','/js/app/wx/order_info.src.js?1447920288']);
_do_custom_arr.push(['w.orderinfo','/js/app/wx/orderinfo.src.js?1444816241']);
_do_custom_arr.push(['w.order_info_ticket','/js/app/wx/order_info_ticket.src.js?1446094466']);
_do_custom_arr.push(['w.user_related','/js/app/wx/user_related.src.js?1444816241']);
_do_custom_arr.push(['w.viewport','/js/app/wx/viewport.src.js?1444816241']);
_do_custom_arr.push(['y.yck_order','/js/app/ycard/yck_order.src.js?1444816241']);
_do_custom_arr.push(['y.yorderinfo','/js/app/ycard/yorderinfo.src.js?1444816241']);
_do_custom_arr.push(['Y.business.city','/js/app/YOP/business.city.src.js?1446094466']);
_do_custom_arr.push(['Y.common_h5','/js/app/YOP/common_h5.src.js?1446089538']);
_do_custom_arr.push(['Y.decision_common','/js/app/YOP/decision_common.src.js?1444816241']);
_do_custom_arr.push(['Y.decision','/js/app/YOP/decision.src.js?1444816241']);
_do_custom_arr.push(['Y.geolocation','/js/app/YOP/geolocation.src.js?1444816241']);
_do_custom_arr.push(['Y.logreg','/js/app/YOP/logreg.src.js?1444816241']);
_do_custom_arr.push(['Y.order_coupon','/js/app/YOP/order_coupon.src.js?1444816241']);
_do_custom_arr.push(['Y.order_info','/js/app/YOP/order_info.src.js?1444816241']);
_do_custom_arr.push(['Y.orderinfo','/js/app/YOP/orderinfo.src.js?1444816241']);
_do_custom_arr.push(['Y.user_related','/js/app/YOP/user_related.src.js?1446089538']);
_do_custom_arr.push(['Y.verifycode_new','/js/app/YOP/verifycode_new.src.js?1446094466']);
_do_custom_arr.push(['Y.viewport','/js/app/YOP/viewport.src.js?1444816241']);
_do_custom_arr = window.PREPENDPATH( _do_custom_arr, __DOMAIN.host, __DOMAIN.isHttps);
window.ADDDO( _do_custom_arr);
