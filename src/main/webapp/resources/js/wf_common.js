var fnGetMakeParams = function() {
	var params = {};
    $('#_MENU_FROM_ :input').each(function() {
        if (this.id.indexOf('jqg')>-1) {
            //나중에 그리드 INPUT 받아서 처리시에 추가
        } else {
           params[this.id] = $(this).val();
        }
    });
    
    return params;
};


/**
 * Post 방식으로 Popup
 *
 * @param url
 *            submit할 주소
 * @param params
 *            Plain Object
 * @param target
 *            url이 적용되는 target 이름(현재 페이지는 '_self')
 * @param width
 *            팝업창 넓이
 * @param width
 *            팝업창 높이
 */
var fnPostPopup = function(url, params, target, width, height, scrollbar, resizable) {
	
	if ("_self"==target) {
		fnPostGoto(url, params, target);
    } else {
    	
    	scrollbar = scrollbar || "yes";
    	resizable = resizable || "yes";
    	
    	if (null==target || undefined==target || ""==target) {
    		target = fnGetRandomText(20);
    	}
    	
		//넓이와 높이를 지정하지 않으면 최대 사이즈로.
		if (isEmpty(width) || width == 0){
			width = screen.availWidth;
		}
		if (isEmpty(height) || height == 0){
			height = screen.availHeight;
		}
	    
	    if(opener == null){
	    	var pos = centerWindow(width, height);
	    }else{
	    	var pos = offsetWindow(width, height, 20, 20);
	    }
	    var popup = window.open("", target, "width=" + width + ",height=" + height + ",left=" + pos[0] + ",top=" + pos[1] + ",status=no, scrollbars=" + scrollbar + ", resizable=" + resizable );
	    if (width == screen.availWidth || height == screen.availHeight){ //최대일 경우 크롬 최적화를 위해 resizeTo처리.
	    	popup.resizeTo(width, height);
	    }

    	fnPostGoto(url, params, target);
	    
	    popup.focus();
	    return popup;
    }
};


/**
 * Post 방식으로 submit
 *
 * @param url
 *            submit할 주소
 * @param params
 *            Plain Object
 * @param target
 *            url이 적용되는 target 이름(현재 페이지는 '_self'
 */
var fnPostGoto = function(url, params, target) {
    var f = document.createElement('form');
    var obj, value;
    for ( var key in params) {
        value = params[key];
        obj = document.createElement('input');
        obj.setAttribute('type', 'hidden');
        obj.setAttribute('name', key);
        obj.setAttribute('value', value);
        f.appendChild(obj);
    }
    if (target) f.setAttribute('target', target);
    f.setAttribute('method', 'post');
    f.setAttribute('action', url);
    document.body.appendChild(f);
    f.submit();
};

/**
 * 팝업 윈도우 가운데로 띄울 위치 구하기
 *
 * @param width -
 *            창크기(width)
 * @param height -
 *            창크기(height)
 */
var centerWindow = function(width, height) {

	var winCWidth  = document.body.clientWidth;  // 현재창의 너비
	var winCHeight = document.body.clientHeight; // 현재창의 높이
	var winWidth  = screen.availWidth;  // 스크린 너비
	var winHeight = screen.availHeight; // 스크린 높이
	
	var winX      = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
	var winY      = window.screenY || window.screenTop || 0; // 현재창의 y좌표
	

	var w = winX + (winWidth/2) - (width/2) ;
	var h = winY + (winHeight/2) - (height/2) ;


    dim = new Array(2);
    dim[0] = w;
    dim[1] = h;
    dim[2] = width;
    dim[3] = height;

    return dim;
};

var offsetWindow = function(width, height, offsetX, offsetY) {
    offsetX = offsetX || 20;
    offsetY = offsetY || 20;
	var winCWidth  = document.body.clientWidth;  // 현재창의 너비
	var winCHeight = document.body.clientHeight; // 현재창의 높이
	var winWidth  = screen.availWidth;  // 스크린 너비
	var winHeight = screen.availHeight; // 스크린 높이
	
	var winX      = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
	var winY      = window.screenY || window.screenTop || 0; // 현재창의 y좌표
	

	var w = winX + offsetX;
	var h = winY + offsetY;

    dim = new Array(2);
    dim[0] = w;
    dim[1] = h;
    dim[2] = width;
    dim[3] = height;

    return dim;
};

/**
* 빈값체크 후 메시지 처리 및 포커스
*
* @param objId -
*            Object Id
* @param fieldText -
*            필드명
*/
var isEmpty = function(fieldText) {

  if (null==fieldText || "null" ==  fieldText || "undefined" ==  fieldText || fieldText.length == 0)	return true;
  else return false;
};

/**
 * contextPath 구하기 (http://localhost:8080/test/request.do - "/test")
 */
var getContextPath = function() {
    var path = "";
    try {
        var hostIndex = location.href.indexOf(location.host) + location.host.length;
        path = location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
        
        if (path != "/web") {
        	path = "";
        }      
    } catch (e) {
    }
    
    return path;
};

