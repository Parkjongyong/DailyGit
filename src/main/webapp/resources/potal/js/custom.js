$(document).ready(function() {		

	/*include header
	$('.header').load("../include/header.html", function(){  	});*/
	
	//탭디자인1
//	$('.tab-cont').hide();
//	$('.tab-cont.active').show();

	$('.tab-style01 li').on('click',function(){
		var _self = $(this);
		$('.tab-style01 li').removeClass('on');
		_self.addClass('on');
		$('.tab-cont').each(function(i, e) {
			if (_self.attr('rel') == $(this).attr('id')) {
				$(this).stop().fadeIn();
				if (!$('.tab-style02 li', $(this)).hasClass('on')) {
					$('.tab-style02 li', $(this)).eq(0).addClass('on');
				}
				$('.tab-cont02.active', $(this)).show();
			} else $(this).hide();
		});
	});
	
//	$('.tab-cont02').hide();
//	$('.tab-cont02.active').show();
	
	$('.tab-style02 li').on('click',function(){
		var _self = $(this);
		$('.tab-style02 li').removeClass('on');
		_self.addClass('on');
		$('.tab-cont02').each(function(i, e) {
			if (_self.attr('rel') == $(this).attr('id')) {
				$(this).stop().fadeIn();
			} else $(this).hide();
		});
	});

	//탭디자인2
//	$('.tab-cont02').hide();
//	$('.tab-cont02.active').show();
//	
//	var tabMenu02 = $('#tab-menu02 li');
//
//	$(tabMenu02).on('click',function(){
//	 
//		$(tabMenu02).removeClass('on');
//		$(this).addClass('on');
//		$('.tab-cont02').hide();
//		var activeTabs = $(this).attr('rel');
//		$('#' + activeTabs).stop().fadeIn();
//	
//	});
	
	setView();
	
	//사이트맵 open/hide
	$('.hmenu-box').on('click',function(){
		
		$('.gnb').toggleClass('on');//gnb 숨김
		$('.header.main').toggleClass('on');
		$('.hmenu-line').toggleClass('active');//메뉴
		$('.sitemap-area').toggleClass('on');//사이트맵

	});
	
	$(".logo").click(function() {
		fnPostGoto('/', {}, '_self');
	}).css({'cursor':'pointer'});
});

function setView() {
	$('.tab-style01 li').removeClass('on');
	var type = $.url().param('type') || 0;
	var rel = $('.tab-style01 li').eq(type).addClass('on').attr('rel');
	$('.tab-cont').each(function(i, e) {
		if (rel == $(this).attr('id')) {
			$(this).stop().fadeIn();
			if ($('.tab-style02 li', $(this)).length > 0) {
				$('.tab-style02 li', $(this)).removeClass('on');
				var subtype = $.url().param('subtype') || 0;
				var subrel = $('.tab-style02 li', $(this)).eq(subtype).addClass('on').attr('rel');
				$('.tab-cont02', $(this)).each(function(i, e) {
					if (subrel == $(this).attr('id')) {
						$(this).stop().fadeIn();
					} else $(this).hide();
				});
			}
		} else $(this).hide();
	});
}

function link_notice() {
	
    var url = "/coGrowth/noticePopup.do";
    var target = "coGrowthBoardList";
    var width = "920";
    var height = "800";
    
    fnPostPopup(url, {}, target, width, height);
}

function link_material() {
	
    var url = "/coGrowth/materialPopup.do";
    var target = "coGrowthMaterialList";
    var width = "920";
    var height = "800";
    
    fnPostPopup(url, {}, target, width, height);
}

var fnGetRandomText = function(textSize) {
    var text = "";
    var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    for( var i=0; i < textSize; i++ )
        text += possible.charAt(Math.floor(Math.random() * possible.length));

    return text;	
};

var centerWindow = function(width, height) {

	//var winWidth  = document.body.clientWidth;  // 현재창의 너비
	//var winHeight = document.body.clientHeight; // 현재창의 높이
	var winWidth  = screen.availWidth;  // 스크린 너비
	var winHeight = screen.availHeight; // 스크린 높이
	
	var winX      = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
	var winY      = window.screenY || window.screenTop || 0; // 현재창의 y좌표
	var w = winX + (winWidth - width) / 2;
	var h = winY + (winHeight - height) / 2;
	
    dim = new Array(2);
    dim[0] = w;
    dim[1] = h;
    dim[2] = width;
    dim[3] = height;

    return dim;
};

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
		if (null==width || undefined==width || ""==width || width == 0){
			width = screen.availWidth;
		}
		if (null==height || undefined==height || ""==height || height == 0){
			height = screen.availHeight;
		}
		
	    var pos = centerWindow(width, height);
	    
	    if (null==target || undefined==target || ""==target) {
	    	target = fnGetRandomText(20);
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


//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//기능 INPUT PARAMS 제어 ////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
* HTML Document에서 입력 Tag들의 값을 Object에 담아 반환
* Input, Select, TextArea tag?값을 읽어서 param에 담음
* @param isIncludeDisabled
*            disabled된 입력 Tag 값을 가져올지 구분, 디폴트는 가져옴
* @returns params Objects
*/
var fnGetParams = function(isIncludeDisabled) {
  isIncludeDisabled = isIncludeDisabled || true;
  var params = {};
  $(':input').each(function() {
      if (this.id.indexOf('jqg')>-1) {
          //나중에 그리드 INPUT 받아서 처리시에 추가
      } else {
      	if (this.id != '') {
	            if (!isIncludeDisabled) {
	                if ('disabled' != $(this).attr('disabled')) {
	                    params[this.id] = $.trim($(this).val());
	                    if ( $(this).is('.decimal, .decimal1, .decimal2, .decimal3, .integer') ){
		            		params[this.id] = params[this.id].replace(/,/gi,"");
		            	}
	                    if ( $(this).is('.phone') ){
		            		params[this.id] = params[this.id].replace(/_/gi,"");
		            	}
	                }
	            } else {
	            	if (this.type=="checkbox") {
	            		if (this.checked) params[this.id] = $(this).val();
	            		else params[this.id] = "";
	            	} else if (this.type=="radio") {
	            		if( this.checked) params[this.id] = $(this).val();
	            	} else {
	            		params[this.id] = $.trim($(this).val());		
	            	}
	            	if ( $(this).is('.decimal, .decimal1, .decimal2, .decimal3, .integer') ){
	            		params[this.id] = params[this.id].replace(/,/gi,"");
	            	}
	            	if ( $(this).is('.phone') ){
	            		params[this.id] = params[this.id].replace(/_/gi,"");
	            	}
	            }
      	}
      }
  });
  
  return params;
};

var fnGetMakeParams = function() {
	var params = {};
    return params;
};


var isEmpty = function(fieldText) {
	if (null==fieldText || "undefined" ==  fieldText || fieldText.length == 0)	return true;
	else return false;
};

var oneFileDownload = function(appSeq, attachmentSeq) {
	if (appSeq === undefined || appSeq=="") {
		alert("파일 관리키가 없습니다.");
		return false;
	}
	var url = getContextPath() + "/download.do";
	url += "?APP_SEQ=" + appSeq;
	if (isNotBlank(attachmentSeq)) {
		url += "&ATTACHMENT_SEQ=" + attachmentSeq;
	}
	
	$('#downloadFrame').remove();
	$('body').append('<iframe id="downloadFrame" style="display:none"></iframe>');
	$('#downloadFrame').get(0).contentWindow.location.href = url;
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

var isBlank = function(fieldText) {
	if (null==fieldText || "undefined" == fieldText || trimValue(fieldText).length == 0)	return true;
  else return false;
};

var isNotBlank = function(fieldText) {
	if( isBlank(fieldText) ) {
		return false;
	} else {
		return true;
	}
}

/**
 * 입력받은 값에서 양쪽 공백 지워주기
 *
 * @param event
 */
var trimValue = function(inputValue) {
    var sLeftTrimed = inputValue.replace(/^\s+/, "");
    var sBothTrimed = sLeftTrimed.replace(/\s+$/, "");
    return (sBothTrimed);
};

/**
* 엔터키 입력 시 특정 함수 호출
*
* @param width -
*            창크기(width)
* @param height -
*            창크기(height)
*/
var checkEnter = function(functionName) {
  if (event.keyCode == 13) {
      eval(functionName);
  }
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//기능 Ajax 통신 ////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
* ajax post통신
*/
var ajaxJsonCall = function(url, param, successCallback, errorCallback) {
	var contentType;
	var data;
	var dataType;
	
	if (typeof param == "string") {
	    contentType = "application/json;charset=UTF-8";
	    data = param;
	    dataType = "json"
	} else {
	    //contentType = "application/x-www-form-urlencoded;charset=UTF-8";
		contentType = "application/json;charset=UTF-8";
		data = JSON.stringify(param);;
	    dataType = "json";
	}
	
	$.ajax({
	type : 'POST',
	url : url,
	contentType : contentType,
	data : data,
	dataType : dataType,
	cache: false,
	beforeSend:function(){
		$('body').append('<div class="pageLoader"></div>');
	},
	complete:function(){
		if (undefined==param.pageLoader || !param.pageLoader) $('.pageLoader').remove();
	},
	success : function(data) {
	    try {
	        if (data) {
	            if (data["status"] == "SUCC") {
	                if (typeof successCallback !== 'undefined') {
	                    successCallback(data);
	                }
	            } else if (data["status"] == "FAIL"){
	                alert(data["errMsg"]);
	                if (typeof errorCallback !== 'undefined') {
	                    errorCallback(data);
	                }
	                try{ $('.pageLoader').remove(); } catch(e){}
	            } else {
	                if (typeof successCallback !== 'undefined') {
	                    successCallback(data);
	                }
	            }
	        }
	    } catch (e) {
	        alert(e.message);
	        try{ $('.pageLoader').remove(); } catch(e){}
	    }
	},
	error : function(xhr, status, error) {
	    if (401 === xhr.status) {
	        alert('서버에 오류가 발생하여 요청을 수행할 수 없습니다. 시스템 관리자에 문의 바랍니다.');
	        location.href = "/";
	    } else if (500 === xhr.status) {
	    	alert('서버에 오류가 발생하여 요청을 수행할 수 없습니다. 시스템 관리자에 문의 바랍니다.');
	    } else {
	        alert(error);
	    }
	    try{ $('.pageLoader').remove(); } catch(e){}
	    }
	});
};

//iframe 자동 크기 조절
function resizeIFrame(iframeId){
	try{
		var innerBody = document.getElementById(iframeId).contentWindow.document.body;
		var innerHeight = innerBody.scrollHeight + (innerBody.offsetHeight - innerBody.clientHeight);
  
		if(document.getElementById(iframeId).style.height != innerHeight){
			document.getElementById(iframeId).style.height = innerHeight;
		}
  
		if(document.all){
			innerBody.attachEvent('onclick',parent.do_resize);
			innerBody.attachEvent('onkeyup',parent.do_resize);
		}else{
			innerBody.addEventListener("click", parent.do_resize, false);
			innerBody.addEventListener("keyup", parent.do_resize, false);
		}
 
	}catch (e){
	}
}



