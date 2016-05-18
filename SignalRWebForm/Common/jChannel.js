var this_location = (window.location + "/").toLowerCase();

if(this_location.indexOf("/channels/train/") >= 0) document.getElementById("top_train").className = "top_menu_hover";
if(this_location.indexOf("/channels/competetion/") >= 0) document.getElementById("top_competetion").className = "top_menu_hover";
if(this_location.indexOf("/channels/shoe/") >= 0) document.getElementById("top_shoe").className = "top_menu_hover";
if(this_location.indexOf("/channels/nutrition/") >= 0) document.getElementById("top_nutrition").className = "top_menu_hover";
if(this_location.indexOf("/channels/health/") >= 0) document.getElementById("top_health").className = "top_menu_hover";
if(this_location.indexOf("/channels/beginner/") >= 0) document.getElementById("top_beginner").className = "top_menu_hover";
if(this_location.indexOf("/channels/woman/") >= 0) document.getElementById("top_woman").className = "top_menu_hover";
if(this_location.indexOf("/channels/life/") >= 0) document.getElementById("top_life").className = "top_menu_hover";
if(this_location.indexOf("/channels/expert/") >= 0) document.getElementById("top_expert").className = "top_menu_hover";
if(this_location.indexOf("/channels/tools/") >= 0) document.getElementById("top_tools").className = "top_menu_hover";
