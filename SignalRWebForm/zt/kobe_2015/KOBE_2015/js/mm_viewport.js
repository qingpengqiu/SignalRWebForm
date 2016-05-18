/*************************************************************************************
* Viewport - view port javascript for integrating MM Online Systems into your website
*
* see:  http://www.magicmemories.com/onlinephotosolution/
*
* Copyright Magic Memories Limited 2010
*
* Created:	3 September 2006, Irik Anderson
*
* Last Modified:  24 October 2014, Gabriel
*
***************************************************************************************/

	//Default server URL to retrieve MM code from
	var protocol = document.location.protocol;	//Includes the : but not the //

	var serverURLDefault = protocol + "//my.magicmemories.com";

	//ID for the <script> tag which loads the MM viewport
	var scriptDOMID = "mm_viewport";

	// compress included files to save download time
	var compress = false;

	// this keeps us from rechecking and/or putting up the interface when it shouldn't be
	var winLoaded = false;

	//Flag to set whether we show the darkened screen and "Loading, please wait" message while loading the viewport
	var isLoading = true;

	//Find out which server we loaded the MM viewport code from by looking for a <script> tag
	//with ID equal to the value of 'scriptDOMID' defined above and parsing its src attrbute.
	//If no matching tag is found the value of serverURLDefault will be used.
	getServer();

	//load viewport stylesheet loading message
	if(isLoading) {
		magic_mem_loadjscssfile(server + "/js/mm_vp_loading_message.css", "css");
	}

	// load viewport object model
	magic_mem_loadjscssfile(server + "/js/mm_vpwc.js", "js");

	//Find out the name of the server which we loaded the MM viewport code from by looking for a <script> tag
	//with ID equal to the value of 'scriptDOMID' defined above and parsing its src attrbute. If no matching
	//tag is found the value of serverURLDefault will be used.
	function getServer() {
		var serverURL;
		try {
			serverURL = document.getElementById(scriptDOMID).src.split("/");
		} catch(err) {
			serverURL = serverURLDefault.split("/");
		}
		if (serverURL.length > 0) {
			server = serverURL[0] + "/" + serverURL[1] + "/" + serverURL[2] + "/vp";
		}
	}

	//Include a source code file by including it in this document's <head> tag
	function magic_mem_loadjscssfile(filename, filetype, callback){
		if (filetype=="js"){ //if filename is a external JavaScript file
			var fileref=document.createElement('script');
			fileref.setAttribute("type","text/javascript");
	  		fileref.setAttribute("src", filename);
	  		fileref.setAttribute("defer", "defer");
		}
	 	else if (filetype=="css"){ //if filename is an external CSS file
	  		var fileref=document.createElement("link");
	  		fileref.setAttribute("rel", "stylesheet");
	  		fileref.setAttribute("type", "text/css");
	  		fileref.setAttribute("href", filename);
	 	}
		//Append the <script> or <link> element created above onto the <head>
	 	if (typeof fileref!="undefined") {
	 		document.getElementsByTagName("head")[0].appendChild(fileref);
	 	}
	 	if (typeof callback == 'function') {
	 		callback();
	 	}
	}

	/************************************************************************************************************
	*
	*	various functions used to support the viewPort Interface
	*
	************************************************************************************************************/
	var frameWidth = 700;
	var frameHeight = 495;
	var frameHeightForShareImage = 470;
	var closeOffset = 0;
	var frameOffset = 5;
	var messageObj = null;
	var winLoaded = false;
	var browserSize = 515;
	var interface_server = server;
	var closeButtonClass = 'container-close-vp';
	var albumCode = "";
	var mediaCode = "";
	// NEW guest id/keyword - #### ROSS ###
	var keyword = "";
	var estoryID = 0;
	var map_id = ""; //Share Maps
	var image_id = ""; //Share Image

	//Check if the request contains any action like: estory_id,map_id,image_id, album_code, etc...
	checkURIDelay();
	function checkURIDelay() {
		//window.setTimeout(checkURI, 1200);

		if(typeof DHTML_modalMessage != "function")		// mm_vpwc.js not loaded
		{
			window.setTimeout(checkURIDelay, 10);
		} else {
			window.setTimeout(checkURI, 0);
		}
	}

	// check to see if the uri contains a call to action
	function checkURI() {
		var querystring = window.location.search;
		var querystringValue = querystring.substring(querystring.indexOf("?")+1, querystring.length);
		var paramValueList = querystringValue.split("=");

		if (paramValueList.length > 0) {
			var i=0;
			while (i < paramValueList.length) {
				if (paramValueList[i].substring(paramValueList[i].length-10,paramValueList[i].length) == "album_code") {
					albumCode = paramValueList[i+1].split("&")[0];
				}
				if (paramValueList[i].substring(paramValueList[i].length-10,paramValueList[i].length) == "media_code") {
					mediaCode = paramValueList[i+1].split("&")[0];
				}
				// NEW guest id/keyword - #### ROSS ####
				if (paramValueList[i].substring(paramValueList[i].length-13,paramValueList[i].length) == "media_keyword") {
					keyword = paramValueList[i+1].split("&")[0];
				}
				// #########################################
				if (paramValueList[i].substring(paramValueList[i].length-9,paramValueList[i].length) == "estory_id") {
					estoryID = paramValueList[i+1].split("&")[0];
				}
				if (paramValueList[i].substring(paramValueList[i].length-6,paramValueList[i].length) == "map_id") {
					map_id = paramValueList[i+1].split("&")[0];
				}
				if (paramValueList[i].substring(paramValueList[i].length-8,paramValueList[i].length) == "image_id") {
					image_id = paramValueList[i+1].split("&")[0];
				}
				i++;
			}
		}

		if (estoryID > 0 && winLoaded === false) {
			// show estory window
			getMMViewPort('estory', estoryID, false);
		}
		else if (mediaCode !== "" && winLoaded === false) {
			// show search results window
			getMMViewPort('direct', mediaCode, albumCode);
		}
		else if (keyword !== "" && winLoaded === false) {
			// NEW guest id/keyword - #### ROSS ####
			getMMViewPort('directkw', keyword, albumCode);
		}
		else if (albumCode !== "" && winLoaded === false) {
			// show search window
			getMMViewPort('search', albumCode, false);
		}
		else if (map_id && winLoaded === false) {
			// show search results window
			getMMViewPort('map', map_id, false);
		} 
		else if (image_id && winLoaded === false) {
			// show search results window
			getMMViewPort('image', image_id, false);
		}
	}

	// create a view port window
	// code: albumCode, estoryID, map_id, image_id, mediaCode, keyword
	// code2: false, albumCode
	function getMMViewPort(type, code, code2) {
		// Get loading message
		if(isLoading) {
			// load the css loading message
			loadingMessage(loadingTextMessageByType(type),type);
		}

		// load album specific display settings
		/*if (code) {
			try	{
				// Load stylesheet constructor
                magic_mem_loadjscssfile(server + "/js/mm_vpcss.php?album_code=" + code, "css");
				chooseDisplayType(type, code, code2);
			} catch(err) {
				// do something with the error ?;
			}
		} else {
			chooseDisplayType(type, code, code2);
		}*/

		chooseDisplayType(type, code, code2);
	}

	// show the correct display according to how we were called
	function chooseDisplayType(type, code, code2) {

		// create window according to type
		switch(type) {
			// search interface
			// requires album code
			case "search":
				if (winLoaded === false) {
					winLoaded = true;
					showMMSearch(code);
				}
			break;

		  	// estory receive interface
			// requires Estory ID
		  	case "estory":
				winLoaded = true;
				showMMEstory(code);
		  	break;

			// MM Google Maps
		  	case "map":
				winLoaded = true;
				showMMGMaps(code);
		  	break;

			// MM Single Image Share
		  	case "image":
				winLoaded = true;
				showMMImage(code);
		  	break;

		  	// do a direct search against the database
			// requires media code
		  	case "direct":
				winLoaded = true;
				searchMMDirect(code, code2);	//Don't know the album code, just use empty string
		  	break;

		  	// NEW KEYWORD direct search
		  	case "directkw":
				winLoaded = true;
				searchMMKeyword(code, code2);
		  	break;

			// open a login form
		  	case "login":
				winLoaded = true;
				showMMLogin();
		  	break;

			// show default search inteface
			// requires album code
			default:
			winLoaded = true;
			showMMSearch(code);
		}
	}

	// show the search interface
	function showMMDisplay(albumCode)
	{
		getMMViewPort('search', albumCode, false);
	}

	// Display a login box that will allow users to upload video to YouTube website
	function getMMYoutubeLogin(albumCode)
	{
		// CLOSE THE LOADING MESSAGE
		if(isLoading) {
			closeLoadingMessage();
		}

		// check window size and change close class button if required
		if(getWindowSize() > browserSize){
			var closeButtonClass = 'container-close-vp';
		} else {
			var closeButtonClass = 'container-close-vp-resized';
		}

		magic_mem_loadjscssfile(server + "/js/mm_vpcss.php?album_code=" + albumCode, "css");
		windowHTML = "<div class='" + closeButtonClass + "'><a title='close this window' href='javascript:closeViewPort();'>" + getCloseViewportIcon("close") + "</a></div><iframe id=\'viewport_window\' src=\'" + interface_server + "/_youtube_controller.php?album_code=" + albumCode + "&action=box\' style=\'border:0px;width:" + frameWidth + "px;height:" + (frameHeight-closeOffset) + "px;\' frameborder=0 scrolling=no></iframe>";
		showViewPort(windowHTML,frameWidth,frameHeight);
	}

	// show the search interface
	function showMMSearch(albumCode)
	{
		// CLOSE THE LOADING MESSAGE
		if(isLoading) {
			closeLoadingMessage();
		}

		// check window size and change close class button if required
		if(getWindowSize() > browserSize){
			var closeButtonClass = 'container-close-vp';
		} else {
			var closeButtonClass = 'container-close-vp-resized';
		}

		magic_mem_loadjscssfile(server + "/js/mm_vpcss.php?album_code=" + albumCode, "css");
		windowHTML = "<div class='" + closeButtonClass + "'><a title='close this window' href='javascript:closeViewPort();'>" + getCloseViewportIcon("close") + "</a></div><iframe id=\'viewport_window\' src=\'" + interface_server + "/_search_controller.php?album_code=" + albumCode + "&action=box\' style=\'border:0px;width:" + frameWidth + "px;height:" + (frameHeight-closeOffset) + "px;\' frameborder=0 scrolling=no></iframe>";
		showViewPort(windowHTML,frameWidth,frameHeight);
	}

	// show estory
	function showMMEstory(estoryID)
	{
		// check window size and change close class buttom if required
		if(getWindowSize() > browserSize){
			var closeButtonClass = 'container-close-vp';
		} else {
			var closeButtonClass = 'container-close-vp-resized';
		}

		magic_mem_loadjscssfile(server + "/js/mm_vpcss.php?estory_id=" + estoryID, "css");
		windowHTML = "<div class='" + closeButtonClass + "'><a title='close this window' href='javascript:closeViewPort();'>" + getCloseViewportIcon("div_close_icon") + "</a></div><iframe id=\'viewport_window\' src=\'" + interface_server + "/_estoryplayer.php?action=player" + "&estory_id=" + estoryID+ "\' style=\'border:0px;width:" + frameWidth + "px;height:" + (frameHeight-closeOffset) + "px;\' frameborder=0 scrolling=no></iframe>";
		showViewPort(windowHTML,frameWidth,frameHeight);

		// fade background to black
		fadeBlack();
	}

	// show MM Google Maps
	function showMMGMaps(map_id) {

		// CLOSE THE LOADING MESSAGE
		if(isLoading)
			closeLoadingMessage();

		// check window size and change close class buttom if required
		if(getWindowSize() > browserSize){
			var closeButtonClass = 'container-close-vp';
		} else {
			var closeButtonClass = 'container-close-vp-resized';
		}

		magic_mem_loadjscssfile(server + "/js/mm_vpcss.php", "css");
		windowHTML = "<div class='" + closeButtonClass + "'><a title='close this window' href='javascript:closeViewPort();'>" + getCloseViewportIcon("close") + "</a></div><iframe id=\'viewport_window\' src=\'" + interface_server + "/_google_maps_controller.php?vp=1&shared_id=" + map_id + "\' style=\'border:0px;width:" + frameWidth + "px;height:" + (frameHeight-closeOffset) + "px;\' frameborder=0 scrolling=no></iframe>";
		showViewPort(windowHTML,frameWidth,frameHeight);
	}

	// show MM Single Image
	function showMMImage(image_id) {

		// CLOSE THE LOADING MESSAGE
		if(isLoading)
			closeLoadingMessage();

		// check window size and change close class buttom if required
		if(getWindowSize() > browserSize){
			var closeButtonClass = 'container-close-vp';
		} else {
			var closeButtonClass = 'container-close-vp-resized';
		}
		magic_mem_loadjscssfile(server + "/js/mm_vpcss.php", "css");
		windowHTML = "<div class='" + closeButtonClass + "'><a title='close this window' href='javascript:closeViewPort();'>" + getCloseViewportIcon("close") + "</a></div><iframe id=\'viewport_window\' src=\'" + interface_server + "/_share_single_media_controller.php?vp=1&shared_id=" + image_id + "\' style=\'border:0px;width:" + frameWidth + "px;height:" + (frameHeightForShareImage-closeOffset) + "px;\' frameborder=0 scrolling=no></iframe>";
		showViewPort(windowHTML,frameWidth,frameHeightForShareImage);
	}

	// show a direct search
	function searchMMDirect(mediaCode,albumCode)
	{
		// CLOSE THE LOADING MESSAGE
		if(isLoading) {
			closeLoadingMessage();
		}

		// check window size and change close class buttom if required
		if(getWindowSize() > browserSize){
			var closeButtonClass = 'container-close-vp';
		} else {
			var closeButtonClass = 'container-close-vp-resized';
		}

		magic_mem_loadjscssfile(server + "/js/mm_vpcss.php?album_code=" + albumCode, "css");

		windowHTML = "<div class='" + closeButtonClass + "'><a title='close this window' href='javascript:closeViewPort();'>" + getCloseViewportIcon("close") + "</a></div><iframe src=\'" + interface_server + "/_search_controller.php?media_code=" + mediaCode + "&album_code=" + albumCode + "&action=search&type=direct\' id=\'window\' style=\'border:0px;width:" + frameWidth + "px;height:" + (frameHeight-closeOffset) + "px;\' frameborder=0 scrolling=no></iframe>";
		showViewPort(windowHTML,frameWidth,frameHeight);
	}


	// ###### ROSS #########
	// show a KEYWORD search
	function searchMMKeyword(keyword,albumCode)
	{
		// CLOSE THE LOADING MESSAGE
		if(isLoading) {
			closeLoadingMessage();
		}

		// check window size and change close class buttom if required
		if(getWindowSize() > browserSize){
			var closeButtonClass = 'container-close-vp';
		} else {
			var closeButtonClass = 'container-close-vp-resized';
		}

		magic_mem_loadjscssfile(server + "/js/mm_vpcss.php?album_code=" + albumCode, "css");

		windowHTML = "<div class='" + closeButtonClass + "'><a title='close this window' href='javascript:closeViewPort();'>" + getCloseViewportIcon("close") + "</a></div><iframe src=\'" + interface_server + "/_search_controller.php?media_keyword=" + keyword + "&album_code=" + albumCode + "&action=search&type=directkw\' id=\'window\' style=\'border:0px;width:" + frameWidth + "px;height:" + (frameHeight-closeOffset) + "px;\' frameborder=0 scrolling=no></iframe>";
		showViewPort(windowHTML,frameWidth,frameHeight);
	}


	// *************************************************** Modal box *****************************************************************

	// display the close icon for viewport
	function getCloseViewportIcon(id){
		return "<img id='" + id +"' alt='close' border=0 src='" + server + "/img/icons/close.png'  onmouseOver=src='" + server + "/img/icons/close_over.png' onmouseOut=src='" + server + "/img/icons/close.png' />";
	}

	// close the interface
	function closeViewPort()
	{
		transDiv = document.getElementById('DHTMLSuite_modalBox_backgroundDiv');
		transDiv.style.backgroundColor  = "#FFFFFF";
		transDiv.style.opacity = "0.4";
		messageObj.setHtmlContent("");
		messageObj.display();
		messageObj.close();
        // close the loading box if still there!
        if(isLoading){
            loadingObj.close();
        }
		winLoaded = false;
	}

	// this shows the View Port
	function showViewPort(content, x, y) {
		// see: mm_vpwc.js
		messageObj = new DHTML_modalMessage();
		messageObj.setHtmlContent(content);
		messageObj.setSize(x,y);
		messageObj.setCssClassMessageBox(false);
		messageObj.setSource(false);
		messageObj.setShadowDivVisible(true);
		messageObj.display();
	}

	// fade background to black
	function fadeBlack(){
		transDiv = document.getElementById('DHTMLSuite_modalBox_backgroundDiv');
		transDiv.style.backgroundColor  = "#000000";
		x = 1;
		intervalID = setInterval('changeOpacity(transDiv)',1);
	}

	// change the div opacity
	function changeOpacity(obj) {
		if (x > 40) {
			clearInterval(intervalID);

			// display close buttom after opacity finish
			document.getElementById('div_close_icon').style.display="block";
		} else {
			try
			{
				x = x + 1;
				obj.style.opacity = x/40;
			}
			// display close buttom after opacity finish
			catch(obj) {document.getElementById('div_close_icon').style.display="block";}
		}
	}

	// change server value from default (mostly used for testing)
	function setMMServer(mmServer) {
		server = mmServer;
	}

	// ************************************************** Compatability *******************************************************

	// legacy support for "myestory"
	function getMMVyouPort(type, code) {
		getMMViewPort(type, code);
	}

	// close the interface
	function closeMMDisplay()
	{
		closeViewPort();
	}

	// legacy support for "myestory"
	function closeVyouPort() {
		closeViewPort();
	}

	// legacy support for "myestory"
	function showVyouPort(content, x, y){
		showViewPort(content, x, y);
	}

	// *************************************************** Utilities *****************************************************************

	// Finding the size of the browser window
	function getWindowSize() {
		var winWidth = 0, winHeight = 0;
		if( typeof( window.innerWidth ) == 'number' ) {
			//Non-IE
			winWidth = window.innerWidth;
			winHeight = window.innerHeight;
		} else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
			//IE 6+ in 'standards compliant mode'
			winWidth = document.documentElement.clientWidth;
			winHeight = document.documentElement.clientHeight;
		} else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
			//IE 4 compatible
			winWidth = document.body.clientWidth;
			winHeight = document.body.clientHeight;
		}
		return winHeight;
	}

	/* Get the size of the loading box according to the type */
	function loadingSetWidthByType(type) {
		switch(type) {
			// Estory loading text
			case "estory":
				return 280;
			break;

			// Default loading text
			default:
			return 220;
		}
	}

	/* Customize the message of the loading box according to the type */
	function loadingTextMessageByType(type) {
		switch(type) {
			// Estory loading text
			case "estory":
				return "<div class='loading_holder'>Loading your estory, please wait...</div>";
			break;

			// Default loading text
			default:
			return "<div class='loading_holder'>Loading, please wait...</div>";
		}
	}

	// Display a loadingMessage box
	function loadingMessage(text,type){
		try {
			// see: mm_vpwc.js
			loadingObj = new DHTML_modalMessage();
			loadingObj.setHtmlContent(text);
			loadingObj.setSize(loadingSetWidthByType(type),50);
			loadingObj.setCssClassMessageBox('modalDialog_contentDiv_loading');
			loadingObj.setSource(false);
			loadingObj.setShadowDivVisible(false);
			loadingObj.display();
		} catch(err) {
			// nothing will be catch
		}
	}

	// Close a loading box
	function closeLoadingMessage(){
		try {
			transDiv = document.getElementById('DHTMLSuite_modalBox_backgroundDiv');
			transDiv.style.backgroundColor  = "#FFFFFF";
			transDiv.style.opacity = "0.4";
			loadingObj.setHtmlContent("");
			loadingObj.display();
			loadingObj.close();
			winLoaded = false;
		} catch(err) {
			// nothing will be catch
		}
	}