({
	doInit : function(component, event, helper) {
        var pageUrl = decodeURIComponent(window.location.search.substring(1));
        var paramArrays = pageUrl.split('&');
        var errorFlg = '';
        var infoFlg = '';
        var infoMsg = '';
        for (var i = 0; i < paramArrays.length; i++) {
            var paramArray = paramArrays[i].split('=');
            if (paramArray[0] === 'errorFlg') {
                errorFlg = paramArray[1].replace(/-/g,'');
                component.set("v.errorFlg", errorFlg);
            } else if (paramArray[0] === 'infoFlg') {
                infoFlg = paramArray[1].replace(/-/g,'');
                component.set("v.infoFlg", infoFlg);
            } else if (paramArray[0] === 'infoMsg') {
                infoMsg = paramArray[1].replace(/-/g,'');
                component.set("v.infoMsg", infoMsg);
            }
        }
	}
})