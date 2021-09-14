//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//기능 일반 //////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
jQuery.ajaxSetup({cache:false});

// CONSOLE 오류방지

var gCSRF_PARAM_NAME = "__CSRF_TOKEN__";
var _dynamicResizeTarget		= []; //gridName, gridDivId
var _dynamicResizeTargetWidth	= []; //gridName, gridDivId

var console = window.console || {
    log: function() {
    }
};

var disibleColStyle = {
	editable : false,
	background : "#e4e4e4",
	border : "#88888888,1",
	borderBottom : "#ff999999,1",
	borderRight : "#ff999999,1"
};

var enableColStyle = {
		editable : true,
		border : "#88888888,1",
		borderBottom : "#ff999999,1",
		borderRight : "#ff999999,1"
	};

var resizeGrid = function() {
	//if (""!=_dynamicResizeTarget) {
	if (_dynamicResizeTarget != null && _dynamicResizeTarget.length > 0 ) {
		$.each(_dynamicResizeTarget, function(index, _gInfo){
			var _new_height = getGridHeight(_gInfo.gridDivId, _gInfo.gridPaging);
			
			//console.log( "_new_height = " + _new_height);
			//console.log( "_gInfo.gridDivId = " + _gInfo.gridDivId);
			document.getElementById(_gInfo.gridDivId).style.height = _new_height + "px";
			//eval(_gInfo.name+".resetSize();");
			eval(_gInfo.gridDivId+".resetSize();");
		});
	}
}

var getGridHeight = function(objId, isPaging) {
	
	//console.log( "getGridHeight");
	var obj = $("#" + objId).closest(".realGridArea");

	//console.log( "getGridHeight isPaging = " +isPaging);

	var retVal = obj.height();
	if( isPaging == true ) {
		retVal = retVal - 48;
	}
	//console.log( "getGridHeight " + objId + " : " +retVal);
	return retVal;
};

var dynamicGridWidthChange = function () {
    if ("" !== _dynamicResizeTargetWidth) {
        $.each(_dynamicResizeTargetWidth, function(index, _gInfo){
            //var _new_height = getGridHeight(_gInfo.gridDivId);
            //document.getElementById(_gInfo.gridDivId).style.height = _new_height + "px";
            //console.log("[]" + _gInfo.gridName);
            eval(_gInfo.gridDivId+".resetSize();");
        });
    }

    try {
        if ("function" === typeof resizeEventHandler) resizeEventHandler();
    } catch (e) {
        //console.log("window.resize:" + e);
    }
};

$("document").on("click",".datepicker", function() {  
	// 추가선택자를 넣고 동적이벤트 바인딩을 할경우 선택자는 document로 지정한다.
	this.datepicker(optionsDatepicker);
});


/**
 * browser detect
 */
var browser = (function() {
    var s = navigator.userAgent.toLowerCase();
    var match = /(webkit)[ \/](\w.]+)/.exec(s) ||
        /(opera)(?:.*version)?[ \/](\w.]+)/.exec(s) ||
        /(msie) ([\w.]+)/.exec(s) ||
        /(edge)[ \/]([\w.]+)/.exec(s) ||
        /(chrome)[\/]([\w.]+)/.exec(s) ||
        !/compatible/.test(s) &&
        /(mozilla)(?:.*? rv:([\w.]+))?/.exec(s) ||
        [];
    return { name: match[1] || '', version: match[2] || '0' };
}());

var fnHide = function ($obj) {
    if (-1 < $.inArray(browser.name, ['msie', 'edge', 'mozilla'])) {
        $obj.attr('disabled', true);
    } else {
        $obj.hide();
    }
};

var fnShow = function ($obj) {
    if (-1 < $.inArray(browser.name, ['msie', 'edge', 'mozilla'])) {
        $obj.attr('disabled', false);
    } else {
        $obj.show();
    }
};

var showMask = function () {
    $('#mask').remove();
    $('body').append("<div id='mask' style='position:absolute;left:0;top:0;z-index:9000;background-color:#000;display:none;'></div>");
    //mask { position:absolute;left:0;top:0;z-index:9000;background-color:#000;display:none;}
    //화면의 높이와 너비를 구한다.
    var maskHeight = $(document).height();
    var maskWidth = $(window).width();

    //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
    $('#mask').css({'width':maskWidth,'height':maskHeight});

    //애니메이션 효과
    //$('#mask').fadeIn(1000);
    $('#mask').fadeTo("slow",0.8);
};

var hideMask = function () {
    $('#mask').remove();
};

var showProgress = function(base) {
    base = base||'body';
    $('#progress').remove();

    var maskHeight;
    var maskWidth;
    var maskCentorPosTop;
    var maskCentorPosLeft;

    if ('body'===base) {
        maskHeight = $(document).height();
    	//maskHeight = $(window).height();
        maskWidth = $(window).width();
    } else {
        maskHeight = $(base).height();
        maskWidth = $(base).width();
    }

    maskCentorPosTop	= Math.floor(maskHeight / 2) - 70;
    maskCentorPosLeft	= Math.floor(maskWidth / 2) - 80;

    var _progressHtml = "<br/><br/><div id='floatingBarsG'>"
        + "<div class='blockG' id='rotateG_01'></div>"
        + "<div class='blockG' id='rotateG_02'></div>"
        + "<div class='blockG' id='rotateG_03'></div>"
        + "<div class='blockG' id='rotateG_04'></div>"
        + "<div class='blockG' id='rotateG_05'></div>"
        + "<div class='blockG' id='rotateG_06'></div>"
        + "<div class='blockG' id='rotateG_07'></div>"
        + "<div class='blockG' id='rotateG_08'></div>"
        + "</div>"
        + "</div>";

    if ('body'===base) {
        $(base).append("<div id='progress' style='position:absolute;left:0;top:0;z-index:9900;background-color:#F2F2F2;vertical-align:middle;'>" + _progressHtml);
    } else {
        $(base).parent().css("position"	,"relative");
        $(base).parent().css("height"	,maskHeight);

        $(base).css("position"	,"relative");
        $(base).css("z-index"	,"1");

        $(base).parent().append("<div id='progress' style='position:relative;left:0;top:-"+maskHeight+";z-index:9900;background-color:#F2F2F2;'>" + _progressHtml);
    }

    //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
    if ('body'===base) {
        $('#progress').css({'width':maskWidth,'height':maskHeight});
        $('#floatingBarsG').css({'top':maskCentorPosTop,'left':maskCentorPosLeft});
    } else {
        $('#progress').css({'width':maskWidth,'height':maskHeight});
        $('#floatingBarsG').css({'top':maskCentorPosTop,'left':maskCentorPosLeft});
    }

    //애니메이션 효과
    //$('#mask').fadeIn(1000);
    $('#progress').fadeTo("slow",0.8);

};

var hideProgress = function(base) {
    $('#progress').remove();
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

/**
 * 폼데이터를 객체화 (jqGrid의 postData 옵션에 사용)
 */
jQuery.fn.serializeObject = function() {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};




//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Design 팀 적용 스크립트 ////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
var optionsDatepicker = {
		showOn: "both", // 버튼과 텍스트 필드 모두 캘린더를 보여준다.
		buttonImage: getContextPath()+"/resources/images/common/datepick_icon.png", // 버튼 이미지.
		buttonImageOnly: true,
        showButtonPanel: false,		
		yearRange: "-100:+10",
		dateFormat: "yy-mm-dd", // 텍스트 필드에 입력되는 날짜 형식.
		changeMonth: true ,
		changeYear: true,
		nextText: '다음 달', // next 아이콘의 툴팁.
		prevText: '이전 달', // prev 아이콘의 툴팁.
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		showButtonPanel: true,
		currentText: '오늘' , // 오늘 날짜로 이동하는 버튼 패널
		closeText: '닫기',  // 닫기 버튼 패널
		beforeShow: function() {
	        setTimeout(function(){
	            $('.ui-datepicker').css('z-index', 100);
	        }, 0);
	    },
		onClose: function(dateText, inst) {
			/**
			 * ※ 날짜입력 유효성 체크
			 *  - 달력이용 및 수동입력시 날짜형식이 올바르게 입력되었는지 체크
			 *  - [선택체크] 시작일 / 종료일 체크가 자동으로 이루어지도록 설정가능 dateHolder 속성설정 bgn/end 로 지정
			 *    시작일이 종료일보다 크게 입력되면 종료일에 맞춰 짐
			 *    종료일이 시작일보다 작게 입력되면 시작일에 맞춰 짐
			 *    입력 예 ) <input type="text" name="TEST_BGN" class="datepicker w75 t_center" value="" dateHolder="bgn">
			 *             <input type="text" name="TEST_END" class="datepicker w75 t_center" value="" dateHolder="end">
			 */
			
			if ($.trim(dateText) == "") {
				$(this).val("");
				return;
			}
			
			var poshyOption = {
				content: "",
				className: "tip-yellow",
				alignTo: "target",
				alignX: 'inner-left',
				showOn: "none", // hover, focus
				offsetY: 5
			}
			
			dateText = dateText.split("-").join("");
			
			if(isValidDate(dateText)) {
				//'-'를 제외한 8자리 올바르게 입력시 '-'삽입
				$(this).val(dateText.substr(0, 4)+"-"+dateText.substr(4, 2)+"-"+dateText.substr(6));

				//dateHolder 속성이 있다면 시작일-종료일 체크
				var dateHolder = $(this).attr("dateHolder");
				if (dateHolder != undefined) {
					
					if (dateHolder == "bgn") { 
						//선택한 날짜가 시작일일시
						var bgnDate = $(this).val();
						var endDate = $("#TB_END_DT").val();
						
						if ($.trim(endDate) != "") {
							bgnDate = bgnDate.split("-").join("");
							endDate = endDate.split("-").join("");
							
							if (toNumber(endDate) > 0) {
								if (bgnDate > endDate) {
									//시작일이 종료일보다 후의 날짜일시
									
									poshyOption.content = "시작일이 종료일보다 이후의 날짜로 지정되어 자동맞춤되었습니다.";
									$(this).poshytip(poshyOption);
									$(this).poshytip('show').poshytip('hideDelayed', 4000);
									$(this).val(endDate.substr(0, 4)+"-"+endDate.substr(4, 2)+"-"+endDate.substr(6));
								} 
							}
							
						}
						
					} else if (dateHolder == "end") {
						//선택한 날짜가 종료일일시
						var bgnDate = $("#TB_START_DT").val();
						var endDate = $(this).val();
						
						if ($.trim(bgnDate) != "") {
							bgnDate = bgnDate.split("-").join("");
							endDate = endDate.split("-").join("");
							
							if (toNumber(bgnDate) > 0) {
								if (endDate < bgnDate) {
									//종료일이 시작일보다 작을시
									
									poshyOption.content = "종료일이 시작일보다 이전의 날짜로 지정되어 자동맞춤되었습니다.";
									$(this).poshytip(poshyOption);
									$(this).poshytip('show').poshytip('hideDelayed', 4000);
									$(this).val(bgnDate.substr(0, 4)+"-"+bgnDate.substr(4, 2)+"-"+bgnDate.substr(6));
								} 
							}
						}
					}
				}
				try {fnCallbackDatePicker(this.id) } catch (e) {};
			} else {
				poshyOption.content = "날짜 형식이 올바르지 않습니다.<br/>입력 예) 2018-01-31 또는 20180131";
				$(this).poshytip(poshyOption);
				$(this).poshytip('show').poshytip('hideDelayed', 4000);
				$(this).val("");
				$(this).select();
			}
		}
	};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Design 팀 적용 스크립트 ////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
var optionsMonthpicker = {
		showOn: "both", // 버튼과 텍스트 필드 모두 캘린더를 보여준다.
		buttonImage: getContextPath()+"/resources/images/common/datepick_icon.png", // 버튼 이미지.
		buttonImageOnly: true,
		showButtonPanel: false,		
		yearRange: "-100:+10",
		dateFormat: "yy-mm-dd", // 텍스트 필드에 입력되는 날짜 형식.
		changeMonth: true ,
		changeYear: true,
		nextText: '다음 달', // next 아이콘의 툴팁.
		prevText: '이전 달', // prev 아이콘의 툴팁.
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		showButtonPanel: true,
		currentText: '당월' , // 당월 날짜로 이동하는 버튼 패널
		closeText: '닫기',  // 닫기 버튼 패널
		beforeShow: function() {
			setTimeout(function(){
				$('.ui-datepicker').css('z-index', 100);
			}, 0);
		},
		onClose: function(dateText, inst) {
			/**
			 * ※ 날짜입력 유효성 체크
			 *  - 달력이용 및 수동입력시 날짜형식이 올바르게 입력되었는지 체크
			 *  - [선택체크] 시작일 / 종료일 체크가 자동으로 이루어지도록 설정가능 dateHolder 속성설정 bgn/end 로 지정
			 *    시작일이 종료일보다 크게 입력되면 종료일에 맞춰 짐
			 *    종료일이 시작일보다 작게 입력되면 시작일에 맞춰 짐
			 *    입력 예 ) <input type="text" name="TEST_BGN" class="datepicker w75 t_center" value="" dateHolder="bgn">
			 *             <input type="text" name="TEST_END" class="datepicker w75 t_center" value="" dateHolder="end">
			 */
			
			if ($.trim(dateText) == "") {
				$(this).val("");
				return;
			}
			
			var poshyOption = {
					content: "",
					className: "tip-yellow",
					alignTo: "target",
					alignX: 'inner-left',
					showOn: "none", // hover, focus
					offsetY: 5
			}
			
			dateText = dateText.split("-").join("");
			
			if(isValidDate(dateText)) {
				//'-'를 제외한 8자리 올바르게 입력시 '-'삽입
				$(this).val(dateText.substr(0, 4)+"-"+dateText.substr(4, 2)+"-"+dateText.substr(6));
				
				//dateHolder 속성이 있다면 시작일-종료일 체크
				var dateHolder = $(this).attr("dateHolder");
				if (dateHolder != undefined) {
					
					if (dateHolder == "bgn") { 
						//선택한 날짜가 시작일일시
						var bgnDate = $(this).val();
						var endDate = $("#TB_END_DT").val();
						
						if ($.trim(endDate) != "") {
							bgnDate = bgnDate.split("-").join("");
							endDate = endDate.split("-").join("");
							
							if (toNumber(endDate) > 0) {
								if (bgnDate > endDate) {
									//시작일이 종료일보다 후의 날짜일시
									
									poshyOption.content = "시작일이 종료일보다 이후의 날짜로 지정되어 자동맞춤되었습니다.";
									$(this).poshytip(poshyOption);
									$(this).poshytip('show').poshytip('hideDelayed', 4000);
									$(this).val(endDate.substr(0, 4)+"-"+endDate.substr(4, 2)+"-"+endDate.substr(6));
								} 
							}
							
						}
						
					} else if (dateHolder == "end") {
						//선택한 날짜가 종료일일시
						var bgnDate = $("#TB_START_DT").val();
						var endDate = $(this).val();
						
						if ($.trim(bgnDate) != "") {
							bgnDate = bgnDate.split("-").join("");
							endDate = endDate.split("-").join("");
							
							if (toNumber(bgnDate) > 0) {
								if (endDate < bgnDate) {
									//종료일이 시작일보다 작을시
									
									poshyOption.content = "종료일이 시작일보다 이전의 날짜로 지정되어 자동맞춤되었습니다.";
									$(this).poshytip(poshyOption);
									$(this).poshytip('show').poshytip('hideDelayed', 4000);
									$(this).val(bgnDate.substr(0, 4)+"-"+bgnDate.substr(4, 2)+"-"+bgnDate.substr(6));
								} 
							}
						}
					}
				}
				try {fnCallbackDatePicker(this.id) } catch (e) {};
			} else {
				poshyOption.content = "날짜 형식이 올바르지 않습니다.<br/>입력 예) 2018-01-31 또는 20180131";
				$(this).poshytip(poshyOption);
				$(this).poshytip('show').poshytip('hideDelayed', 4000);
				$(this).val("");
				$(this).select();
			}
		}
};

$.datepicker._gotoToday = function(id) {
    $(id).datepicker('setDate', new Date()).datepicker('hide').blur();
};

//년월 달력용 onChangeMonthYear function
var fn_onChangeMonthYear_ym = function(year, month, inst) {
    console.log('>>>>>>>>'+fn_paddingZero(year,4)+'-'+fn_paddingZero(month,2));
    //$(this).datepicker('setDate', fn_paddingZero(year,4)+'-'+fn_paddingZero(month,2));
    //$(this).datepicker('setDate', new Date(year, month, 1));
    $(this).val(fn_paddingZero(year,4)+'-'+fn_paddingZero(month,2));
};
//년월 달력용 onClose function
var fn_onClose_ym = function(dateText, inst) {
    /**
     * ※ 날짜입력 유효성 체크: 일반달력내용참고
     */
    if ($.trim(dateText) == "") {
        $(this).val("");
        return;
    }
    var poshyOption = {
        content: "",
        className: "tip-yellow",
        alignTo: "target",
        alignX: 'inner-left',
        showOn: "none", // hover, focus
        offsetY: 5
    }
    //dateText 입력된 날짜 - 수동으로 입력된 날짜도 포함
    dateText = dateText.split("-").join("");
    
    if(isValidDate(dateText+'01')) { //년월값만 있으므로 01 붙여서 체크
        
        //'-'를 제외한 6자리 올바르게 입력시 '-'삽입
        $(this).val(dateText.substr(0, 4)+"-"+dateText.substr(4, 2));

        //dateHolder 속성이 있다면 시작일-종료일 체크
        var dateHolder = $(this).attr("dateHolder");
        if (dateHolder != undefined) {
            if (dateHolder == "bgn") { 
                //선택한 날짜가 시작일일시
                var bgnDate = $(this).val();
                var endDate = $(this).nextAll(".datepicker_ym:first").val();
                if ($.trim(endDate) != "") {
                    bgnDate = bgnDate.split("-").join("");
                    endDate = endDate.split("-").join("");
                    
                    if (toNumber(endDate) > 0) {
                        if (bgnDate > endDate) {
                            //시작일이 종료일보다 후의 날짜일시
                            
                            poshyOption.content = "시작월이 종료월보다 이후의 날짜로 지정되어 자동맞춤되었습니다.";
                            $(this).poshytip(poshyOption);
                            $(this).poshytip('show').poshytip('hideDelayed', 4000);
                            $(this).val(endDate.substr(0, 4)+"-"+endDate.substr(4, 2));
                        } 
                    }
                }
            } else if (dateHolder == "end") {
                //선택한 날짜가 종료일일시
                var bgnDate = $(this).prevAll(".datepicker_ym:first").val();
                var endDate = $(this).val();
                if ($.trim(bgnDate) != "") {
                    bgnDate = bgnDate.split("-").join("");
                    endDate = endDate.split("-").join("");
                    if (toNumber(bgnDate) > 0) {
                        if (endDate < bgnDate) {
                            //종료일이 시작일보다 작을시
                            poshyOption.content = "종료월이 시작월보다 이전의 날짜로 지정되어 자동맞춤되었습니다.";
                            $(this).poshytip(poshyOption);
                            $(this).poshytip('show').poshytip('hideDelayed', 4000);
                            $(this).val(bgnDate.substr(0, 4)+"-"+bgnDate.substr(4, 2));
                        } 
                    }
                }
            }
        }
        try {fnCallbackDatePicker(this.id) } catch (e) {};
    } else {
        poshyOption.content = "년월 형식이 올바르지 않습니다.<br/>입력 예) 2018-01 또는 201801";
        $(this).poshytip(poshyOption);
        $(this).poshytip('show').poshytip('hideDelayed', 4000);
        $(this).val("");
        $(this).select();
    }
}
// 아래 클래스가 적용된 input 태그에 input mask 적용.
var fnInputmask = function(){
	$("input[class~=email]").inputmask({alias:"email"});
	/*
    $("input[class~=phone]").inputmask({"mask":"999-9999-9999"}).on('input change', function(event){
    	//console.log('v:'+this.value);
    	if (this.value.match(/^02/)){
    		$(this).inputmask({"mask":"99-9999-9999"});
    	}else{
    		$(this).inputmask({"mask":"999-9999-9999"});
    	}
    });*/
    $("input[class~=phone]").on("keyup", function() {
        $(this).val($(this).val().replace(/[^0-9,-]/g,""));
    }).attr('maxLength', 13);
    
    $("input[class~=decimal]").inputmask({
        prefix: "",
        groupSeparator: ",",
        alias: "numeric",
        placeholder: "0",
        digits: 0,
        digitsOptional: false
    });
    $("input[class~=decimal1]").inputmask({
        prefix: "",
        groupSeparator: ",",
        alias: "numeric",
        placeholder: "0",
        digits: 1,
        digitsOptional: false
    });
    $("input[class~=decimal2]").inputmask({
        prefix: "",
        groupSeparator: ",",
        alias: "numeric",
        placeholder: "0",
        digits: 2,
        digitsOptional: false
    });
    $("input[class~=decimal3]").inputmask({
        prefix: "",
        groupSeparator: ",",
        alias: "numeric",
        placeholder: "0",
        digits: 3,
        digitsOptional: false
    });
    $("input[class~=percent]").inputmask({
        alias: "integer",
        min: 0,
        max: 100,
        allowMinus: false
    });
    $("input[class~=percent1]").inputmask({
        alias: "numeric",
        min: 0,
        max: 100,
        digits: 1,
        allowMinus: false    
    });
    $("input[class~=percent2]").inputmask({
        alias: "numeric",
        min: 0,
        max: 100,
        digits: 2,
        allowMinus: false
    });
    $("input[class~=integer]").inputmask({
    	alias:"integer",
    	groupSeparator: ","
    });
}

$(function () {		

	// 달력 UI
	$(".datepicker").datepicker(optionsDatepicker);	
	// 년월 달력
	$(".datepicker_ym").datepicker(optionsMonthpicker);
	$(".datepicker_ym").datepicker("option", "dateFormat", "yy-mm"); //포맷
	$(".datepicker_ym").datepicker("option", "onChangeMonthYear", fn_onChangeMonthYear_ym);
	$(".datepicker_ym").datepicker("option", "onClose", fn_onClose_ym);
	$(".datepicker_ym").focus(function () { //일자선택부분 숨기기
        $(".ui-datepicker-calendar").hide();
    });
	
	// input mask 적용
	fnInputmask();
	
	// LNB메뉴
	$('#lnbMenu li.active').addClass('open').children('ul').show();
	$('#lnbMenu li.has-sub>a').on('click', function(){
		$(this).removeAttr('href');
		var element = $(this).parent('li');
		if (element.hasClass('open')) {
			element.removeClass('open');
			element.find('li').removeClass('open');
			element.find('ul').slideUp(200);
		}
		else {
			element.addClass('open');
			element.children('ul').slideDown(200);
			element.siblings('li').children('ul').slideUp(200);
			element.siblings('li').removeClass('open');
			element.siblings('li').find('li').removeClass('open');
			element.siblings('li').find('ul').slideUp(200);
		}
	});

	//텝메뉴
	$(".tabCont").hide();
	$(".tabCont:first").show();	
	
	$("ul.tabDesign li").click(function () {
		$("ul.tabDesign li").removeClass("on");
		$(this).addClass("on");
		$(".tabCont").hide();
		var activeTab = $(this).attr("rel");
		$("#" + activeTab).fadeIn();
		
		console.log("common : 111111111111111111111111111111111111111111");
	});	

	//상단이동
	$(window).scroll(function(){
		if($(this).scrollTop() > 0){
			$('.btnTops').fadeIn();
		}else{
			$('.btnTops').fadeOut();
		}
	});
	
	//전체메뉴
	$(".siteMapBtn").click(function () {
		$(".siteMapArea").slideToggle("fast");
	});	
	$(".siteMapClose").click(function () {
		$(".siteMapArea").slideToggle("fast");
	});	
	
	$('.btnTops').click(function () {
		$('html, body').animate({scrollTop: 0}, 450);
		return false;
	});
	
	
/*	//레이어팝업 colse 중복으로 인해 주석처리함.
  	$(".close").bind("click",function(e){
		if (confirm("창을 닫으시겠습니까?")) {
			self.close();
		}
	});*/
	
	$(".deleteicon").bind("click",function(e){
		$.each($(this.parentElement).find("input"),function(key, value){
			this.value = "";
		});
	});	
	$(".delt-icon").bind("click",function(e){
		$.each($(this.parentElement).find("input"),function(key, value){
			this.value = "";
		});
	});	
});

//layer popup
function layer_open(el) {
	var temp = $('#' + el);
	var bg = temp.parents('bg');
	if (bg) {
		$('.layer').fadeIn();
	} else {
		temp.fadeIn();
	}

	temp.css('display', 'block');
	if (temp.outerHeight() < $(document).height()) temp.css('margin-top', '-' + temp.outerHeight() / 2 + 'px');
	else temp.css('top', '0px');
	if (temp.outerWidth() < $(document).width()) temp.css('margin-left', '-' + temp.outerWidth() / 2 + 'px');
	else temp.css('left', '0px');

	temp.find('.layerClose').click(function (e) {
		if (bg) {
			$('.layer').fadeOut();
		} else {
			temp.fadeOut();
		}
		e.preventDefault();
	});

	$('.layer .bg').click(function (e) {
		//$('.layer').fadeOut();
		e.preventDefault();
	});
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//기능 문자열 함수 ////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
 * replaceAll
 */
String.prototype.replaceAll = function(oldStr, newStr) {
    if(!isNullValue(this)) {
        return this.split(oldStr).join(newStr);
    } else {
        return this;
    }
};

/*
 * 문자열의 길이가 n이 될때까지 왼쪽에 문자열 c를 채움
 * ex) alert('123'.lpad(5, '0')); -> 00123
 */
String.prototype.lPad = function (n,c) {
    var i; var a = this.split(''); for (i = 0; i < n - this.length; i++) {a.unshift (c);}; return a.join('');
};

/*
 * 문자열의 길이가 n이 될때까지 오른쪽에 문자열 c를 채움
 */
String.prototype.rPad = function (n,c) {
    var i; var a = this.split(''); for (i = 0; i < n - this.length; i++) {a.push (c);}; return a.join('');
};

/**
 * null 체크
 *
 * @param event
 */
var isNullValue = function(inputValue) {
    if (inputValue == null || inputValue.length == 0 || inputValue == "") {
        return true;
    } else {
        return false;
    }
};

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
 * String바이트 수 구하기
 *
 * @param szValue
 * @returns {Number}
 */
var calculateBytes = function(szValue, maxSize) {
    var tcount = 0;
    var tmpStr = new String(szValue);
    var temp = tmpStr.length;

    var onechar;

    if ("undefined"==maxSize) {
        for (var k = 0; k < temp; k++) {
            onechar = tmpStr.charAt(k);
            if (escape(onechar).length > 4) {
                tcount += 3;
            } else {
                tcount += 1;
            }
        }

        return tcount;
    } else {
        var rtnVal = new Array();

        rtnVal[0] = 0;
        rtnVal[1] = "";
        for (var k=0; k<temp; k++ ){
            onechar = tmpStr.charAt(k);

            if (escape(onechar).length > 4){
                tcount += 3;
            }else{
                tcount += 1;
            }

            if (tcount<=maxSize) {
                rtnVal[1] += onechar;
            }
        }

        rtnVal[0]= tcount;
        return rtnVal;
    }
};



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//기능 날짜 관련 함수 ////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * 날짜 차이 계산 함수
 *
 * @param 필드아이디1
 *            stndDateId : 기준 날짜(YYYY-MM-DD)
 * @param 필드아이디2
 *            targetDateId : 대상 날짜(YYYY-MM-DD)
 * @param 결과반환필드
 *            resultId
 * @returns
 */
var getDateDiff = function(stndDateId, targetDateId, resultId) {

    var date1 = $("#" + stndDateId).val();
    var date2 = $("#" + targetDateId).val();

    if (date1 == "" || date2 == "") { return; }

    var arrDate1 = date1.split("-");
    var getDate1 = new Date(parseInt(arrDate1[0]), parseInt(arrDate1[1]) - 1, parseInt(arrDate1[2]));
    var arrDate2 = date2.split("-");
    var getDate2 = new Date(parseInt(arrDate2[0]), parseInt(arrDate2[1]) - 1, parseInt(arrDate2[2]));

    var getDiffTime = getDate1.getTime() - getDate2.getTime();

    $("#" + resultId).val(Math.floor(getDiffTime / (1000 * 60 * 60 * 24)));
};


var getDateDiff2 = function(fromDate, toDate) {
    if (fromDate == "" || toDate == "") { return; }
    if(!isNotEmpty(fromDate) || !isNotEmpty(toDate)){ return; }
    
    var arrDate1 = toDate.split("-");
    var getDate1 = new Date(parseInt(arrDate1[0]), parseInt(arrDate1[1]) - 1, parseInt(arrDate1[2]));
    var arrDate2 = fromDate.split("-");
    var getDate2 = new Date(parseInt(arrDate2[0]), parseInt(arrDate2[1]) - 1, parseInt(arrDate2[2]));

    var getDiffTime = getDate1.getTime() - getDate2.getTime();

    return Math.floor(getDiffTime / (1000 * 60 * 60 * 24));
};


/**
 * 날짜 차이 계산 함수
 *
 * @param 날짜1
 *            srcDateStr : 기준 날짜(YYYY-MM-DD)
 * @param 날짜2
 *            targetDateStr : 대상 날짜(YYYY-MM-DD)
 * @param 결과반환
 * @returns
 */
var getStrDateDiff = function(srcDateStr, targetDateStr) {	
	
	if (srcDateStr == "" || targetDateStr == "") { return; }
	var srcDate = new Date(srcDateStr.substring(0,4), srcDateStr.substring(4,6), srcDateStr.substring(6,8), srcDateStr.substring(8,10), srcDateStr.substring(10,12), srcDateStr.substring(12,14));
	var targetDate = new Date(targetDateStr.substring(0,4), targetDateStr.substring(4,6), targetDateStr.substring(6,8), targetDateStr.substring(8,10), targetDateStr.substring(10,12), targetDateStr.substring(12,14));
	
    var getDiffTime = srcDate.getTime() - targetDate.getTime();
    return Math.floor(getDiffTime / (60 * 60 * 24));
};

var fnGetDomain = function() {
    var dns, arrDns, str;
    dns = document.location.href; // <-- 현재 URL 얻어온다
    arrDns = dns.split("//"); // <-- // 구분자로 짤라와서
    str = arrDns[0] + "//" + arrDns[1].substring(0, arrDns[1].indexOf("/")); // <--
    // 뒤에부터
    // 다음 /
    // 까지
    // 가져온다
    return str;
};


/**
 * 날짜 포맷 맞추기
 */
var getDateFormatData = function(flag, cnt, delimiter) {
	if (delimiter == undefined) delimiter = "-";
	
	var dateObj = new Date();
	
	var y1 = dateObj.getFullYear();
	var m1 = dateObj.getMonth();
	var d1 = dateObj.getDate();
	
	if (flag == "y") {
		dateObj.setYear(y1 + cnt);
		
	} else if (flag == "m") {
		dateObj.setMonth(m1 + cnt);
		
	} else if (flag = "d") {
		dateObj.setDate(d1 + cnt);
	}
	y1 = dateObj.getFullYear();
	m1 = dateObj.getMonth() + 1;
	d1 = dateObj.getDate();
	
	return y1 + delimiter + this.formatLen(m1) + delimiter + this.formatLen(d1);
};

/**
 * 날짜 길이 맞추기
 */
var formatLen = function(str) {
	return str = (""+str).length<2 ? "0"+str : str;
}

/**
 * 오늘 날짜
 */
var getToDay = function(delimiter) {
	return getDateFormatData("today", 0, delimiter);
};

/**
 * 계산된 날짜 
 * @param flag 날짜계산구분(y/m/d 중 입력)
 * @param cnt 계산되어야할날짜 (예: 10)
 * @param delimiter
 * 
 * 사용예시 : getDiffDay("m", -1) >>> 한달전 날짜를 조회 
 * 
 */
var getDiffDay = function(flag, cnt, delimiter) {
	return getDateFormatData(flag, cnt, delimiter);
}


/**
 * 입력한 날짜의 달의 첫째일을 리턴
 */
var firstDayByMonth = function(toDate, delimiter) {
	if (delimiter == undefined) delimiter = "-";
	
	var arrDate1 = toDate.split("-");
	var dateObj = new Date();
	dateObj.setFullYear(parseInt(arrDate1[0]));
	dateObj.setMonth(parseInt(arrDate1[1]) - 1);
	dateObj.setDate(1);
	
	return dateObj.getFullYear() + delimiter + this.formatLen(dateObj.getMonth()+1) + delimiter + this.formatLen(dateObj.getDate());
}

/**
 * 입력한 날짜 리턴
 */
var currentDayByMonth = function(toDate, delimiter) {
	if (delimiter == undefined) delimiter = "-";
	
	var arrDate1 = toDate.split("-");
	var dateObj = new Date();
	dateObj.setFullYear(parseInt(arrDate1[0]));
	dateObj.setMonth(parseInt(arrDate1[1]) - 1);
	dateObj.setDate(parseInt(arrDate1[2]));
	
	return dateObj.getFullYear() + delimiter + this.formatLen(dateObj.getMonth()+1) + delimiter + this.formatLen(dateObj.getDate());
}

/**
 * 날짜포맷에 맞는지 검사
 */
function isDateFormat(d) {
	if (d.length != 8) {
		return false;
	}
	var df = /^(19[7-9][0-9]|9999|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;
	
	return d.match(df);
}

/**
 * 윤년여부 검사
 */
function isLeaf(year) {
	var leaf = false;

	if(year % 4 == 0) {
		leaf = true;

		if(year % 100 == 0) {
			leaf = false;
		}

		if(year % 400 == 0) {
			leaf = true;
		}
	}
	return leaf;
}


/**
 * 날짜 유효성 검사 
 * @param d
 * @returns {Boolean}
 */
function isValidDate(d) {
	if(!isDateFormat(d)) {
		return false;
	}

	var month_day = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

	var year = Number(d.substr(0, 4));
	var month = Number(d.substr(4, 2));
	var day = Number(d.substr(6));

	// 날짜가 0이면 false
	if(day == 0) {
		return false;
	}

	var isValid = false;

	// 윤년일때
	if(isLeaf(year)) {
		if(month == 2) {
			if(day <= month_day[month-1] + 1) {
				isValid = true;
			}
		} else {
			if(day <= month_day[month-1]) {
				isValid = true;
			}
		}
	} else {
		if(day <= month_day[month-1]) {
			isValid = true;
		}
	}
	return isValid;
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//기능 포멧 관련 함수 ////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
* 콤마제거
*
* @param data
*/
var removeComma = function(data) {
	try { 
		if (null==data) return '';
		return data.toString().replaceAll(/,/g, "");} 
	catch(e) {
		console.log("removeComma error %s %o",data,e);
		return "";}

};

/**
* 콤마 추가
*
* @param data
*/
var addComma = function(data) {
  var rtnVal = "";
  if( isNotEmpty(data)) {
	  data = removeComma(data);  
	  var arrNum = data.toString().split('.');
	    if (arrNum.length >= 2) {
	        rtnVal = arrNum[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "." + arrNum[1];
	    } else {
	        rtnVal = arrNum[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }
  }
  return rtnVal;
};

var removeNAddComma = function (data) {
	return addComma(removeComma(data));
}

/**
 * 예금주 식별번호 형식 지정
 *
 * @param cellvalue -
 *            Cell 값
 * @param options -
 *            Cell Option 정보
 * @param rowObject -
 *            Row Obejct
 */
var accteeNoFormat = function(cellvalue) {
    if (cellvalue.length === 7) { return cellvalue.substring(0, 6) + "-" + cellvalue.substring(6, 7); }
    return cellvalue;
};

var removeNonNumber = function(str) {
	str = $.trim(str);
	str = str.replace(/[^0-9]/g,'');
	
	return str;
};

var setCellNumberFormat = function(num1) {
	num1 = removeNonNumber(num1);
	if (num1.length == 10) {
		num1 = num1.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
		
	} else if (num1.length == 11) {
		num1 = num1.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
	}
	return num1;
};

/**
 * 전화번호 검증 함수 
 * 휴대전화 / 일반전화 포함 
 */
var checkTelNumber = function(number) {
	var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
	
	if (isEmpty(number)) {
		return false;
		
	} else if (!regExp.test(number)) {
		return false;
	}
	return true;
};

/**
* 사업자등록번호 형식 지정
*
* @param cellvalue -
*            Cell 값
* @param options -
*            Cell Option 정보
* @param rowObject -
*            Row Obejct
*/
var bunsinessNoFormat = function(cellvalue, options, rowObject) {

  if (cellvalue.length == 10) { return cellvalue.substring(0, 3) + "-" + cellvalue.substring(3, 5) + "-" + cellvalue.substring(5); }
  return cellvalue;

};

/**
* @Description : 사업자등록번호 체크 
*
* @return : true, false
*/
var checkBizID = function(bizID) { 
  // bizID는 숫자만 10자리로 해서 문자열로 넘긴다. 
  var checkID = new Array(1, 3, 7, 1, 3, 7, 1, 3, 5, 1); 
  var tmpBizID, i, chkSum=0, c2, remander; 
  bizID = bizID.replace(/-/gi,''); 
  for (i=0; i<=7; i++) chkSum += checkID[i] * bizID.charAt(i); 
  c2 = "0" + (checkID[8] * bizID.charAt(8)); 
  c2 = c2.substring(c2.length - 2, c2.length); 
  chkSum += Math.floor(c2.charAt(0)) + Math.floor(c2.charAt(1)); 
  remander = (10 - (chkSum % 10)) % 10 ; 
  if (Math.floor(bizID.charAt(9)) == remander) return true ; // OK! 
  return false; 
};

/**
 * 법인사업자등록번호 형식 지정
 *
 * @param cellvalue -
 *            Cell 값
 * @param options -
 *            Cell Option 정보
 * @param rowObject -
 *            Row Obejct
 */
var corpBusinessNoFormat = function(cellvalue, options, rowObject) {
    if (cellvalue.length === 13) {return cellvalue.substring(0, 6) + "-" + cellvalue.substring(6, 13);}
    return cellvalue;
};

//법인사업자 체크
var checkCorpBusiness = function(businessNo) {
    //console.log("businessNo" ,businessNo);
    // 법인번호 오류검증 공식
    // 법인번호에서 마지막 자리를 제외한
    // 앞에 모든 자리수를 1과 2를 순차적으로 곱한다.
    // 예) 1234567890123
    //     ************
    //     121212121212
    //     각각 곱한 수를 모든 더하고 10으로 나눈 나머지 수를 구한다.
    //     (각각더한수 % 10)
    //     나눈 나머지 수와 법인번호 마지막 번호가 일치하면 검증일치
    businessNo = businessNo.replace(/-/gi,'');
    if (businessNo.length !== 13){
        return false;
    }

    var arr_regno  = businessNo.split("");
    var arr_wt   = new Array(1,2,1,2,1,2,1,2,1,2,1,2);
    var iSum_regno  = 0;
    var iCheck_digit = 0;

    for (i = 0; i < 12; i++){
        iSum_regno +=  eval(arr_regno[i]) * eval(arr_wt[i]);
    }

    iCheck_digit = 10 - (iSum_regno % 10);
    iCheck_digit = iCheck_digit % 10;
    if (iCheck_digit != arr_regno[12]) {
        return false;
    }
    return true;
};

var checkBubinNo = function (bubinNo){
    var as_Biz_no = String(bubinNo);
    var isNum = true;
    var I_TEMP_SUM = 0 ;
    var I_TEMP = 0;
    var S_TEMP;
    var I_CHK_DIGIT = 0;

    if (bubinNo.length !== 13) {
        return false;
    }

    for (index01 = 1; index01 < 13; index01++) {
        var i = index01 % 2;
        var j = 0;

        if(i === 1){
            j = 1;
        }
        else if( i === 0){
            j = 2;
        }

        I_TEMP_SUM = I_TEMP_SUM + parseInt(as_Biz_no.substring(index01-1, index01),10) * j;
    }

    I_CHK_DIGIT= I_TEMP_SUM%10 ;

    if (I_CHK_DIGIT !== 0 ) {
        I_CHK_DIGIT = 10 - I_CHK_DIGIT;
    }
    if (as_Biz_no.substring(12,13) !== String(I_CHK_DIGIT)) {
        return false;
    }
    return true;
};

/**
* 날짜 포멧 변경
*
* @param date
*/
var formatDate = function(txtDate) {
  // 공백인 경우는 정상으로 처리
  if (txtDate != "") {
      if (!isDate(txtDate)) {
          alert("날짜 형식이 맞지 않습니다.");
          return txtDate;
      }
      return txtDate.substring(0, 4) + "-" + txtDate.substring(4, 6) + "-" + txtDate.substring(6, 8);
  } else {
      return txtDate;
  }
};


/**
* 날짜 포멧 변경
*
* @param date
*/
var removeDashFromDateText = function(txtDate) {
  // 공백인 경우는 정상으로 처리
  if (isEmpty( txtDate) ) {
      return "";
  } else {
      return txtDate.replace(/-/g, "");
  } 
};


/**
* 날짜 포멧 변경
*
* @param date
*/
var unFormatDate = function(strFormatDate) {
  // 공백인 경우는 정상으로 처리
  if (strFormatDate != "") {
      if (!isDate(strFormatDate)) {
          alert("날짜 형식이 맞지 않습니다.");
          return txtDate;
      }

      return strFormatDate.replace(/-/g, "");
  } else {
      return strFormatDate;
  }
};

/**
 * Date를 String으로 변경
 * 
 * @param date
 * @param type [DATE:YYYYMMDD | TIME:HH24MISS | DATETIME:YYYYMMDDHH24MISS | default(DATETIME):YYYYMMDDHH24MISS]
 */
var fn_convertDateToString = function(date, type) {

	var strDt = null;
	
	if(type == 'DATE') {
		strDt = fn_paddingZero(date.getFullYear(), 4) + fn_paddingZero(date.getMonth() + 1, 2) + fn_paddingZero(date.getDate(), 2)
	} else if(type == 'TIME') {
		strDt = fn_paddingZero(date.getHours(), 2) + fn_paddingZero(date.getMinutes(), 2) + fn_paddingZero(date.getSeconds(), 2);
	} else {
		strDt = fn_paddingZero(date.getFullYear(), 4) + fn_paddingZero(date.getMonth() + 1, 2) + fn_paddingZero(date.getDate(), 2) + fn_paddingZero(date.getHours(), 2) + fn_paddingZero(date.getMinutes(), 2) + fn_paddingZero(date.getSeconds(), 2);
	}

    return strDt;
}

/**
 * 현재시간을 YYYYMMDDHH24MISS형태로 가져옴
 *
 * @returns
 */
var fn_getCurrentTime = function() {
    var toDay = new Date();

    var formatDate = fn_paddingZero(toDay.getFullYear(), 4) + fn_paddingZero(toDay.getMonth() + 1, 2) + fn_paddingZero(toDay.getDate(), 2) + fn_paddingZero(toDay.getHours(), 2) + fn_paddingZero(toDay.getMinutes(), 2) + fn_paddingZero(toDay.getSeconds(), 2);
    return formatDate;
};

/**
 * 현재시간을 YYYYMMDD형태로 가져옴
 *
 * @returns
 */
var fn_getCurrentDate = function() {
    var toDay = new Date();

    var formatDate = fn_paddingZero(toDay.getFullYear(), 4) + fn_paddingZero(toDay.getMonth() + 1, 2) + fn_paddingZero(toDay.getDate(), 2);
    return formatDate;
};

/**
 * 0값으로 자리수 메꾸기
 *
 * @param val
 * @param digits
 * @returns {String}
 */
var fn_paddingZero = function(val, digits) {
    var zeroVal = '';
    val = val.toString();

    if (val.length < digits) {
        for (var i = 0; i < digits - val.length; i++)
            zeroVal += '0';
    }
    return zeroVal + val;
};


/**
 * 숫자를 한글로 변환
 *
 * @param num
 * @returns hanStr
 */
var MoneyToHan = function(num) {
    arrayNum = new Array("", "일", "이", "삼", "사", "오", "육", "칠", "팔", "구");
    arrayUnit = new Array("", "십", "백", "천", "만", "십만", "백만", "천만", "억", "십억", "백억", "천억", "조", "십조", "백조");
    arrayStr = new Array()
    len = num.length;
    hanStr = "";
    for (i = 0; i < len; i++) {
        arrayStr[i] = num.substr(i, 1)
    }
    code = len;
    for (i = 0; i < len; i++) {
        code--;
        tmpUnit = "";
        if (arrayNum[arrayStr[i]] != "") {
            tmpUnit = arrayUnit[code];
            if (code > 4) {
                if ((Math.floor(code / 4) == Math.floor((code - 1) / 4) && arrayNum[arrayStr[i + 1]] != "") || (Math.floor(code / 4) == Math.floor((code - 2) / 4) && arrayNum[arrayStr[i + 2]] != "")) {
                    tmpUnit = arrayUnit[code].substr(0, 1);
                }
            }
        }
        hanStr += arrayNum[arrayStr[i]] + tmpUnit;
    }
    return hanStr;
};

/**
 * 전화번호, 폰번호 입력 포멧 맞춤
 *
 * @param num ,type
 * @returns formatNum
 */
var PhoneFomatter = function (num,type){
    var formatNum = '';

    if(num.length==11){
        if(type==0){
            formatNum = num.replace(/(\d{3})(\d{4})(\d{4})/, '$1-****-$3');
        }else{
            formatNum = num.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
        }
    }else if(num.length==8){
        formatNum = num.replace(/(\d{4})(\d{4})/, '$1-$2');
    }else{
        if(num.indexOf('02')==0){
            if(type==0){
                formatNum = num.replace(/(\d{2})(\d{4})(\d{4})/, '$1-****-$3');
            }else{
                formatNum = num.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');
            }
        }else{
            if(type==0){
                formatNum = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-***-$3');
            }else{
                formatNum = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
            }
        }
    }
    return formatNum;
};

/**
 * 이메일 형식 체크
 *
 * @param num ,type
 * @returns formatNum
 */
var EemailFormatCheck = function(strValue, msgFlag)
{
	
	var regExp = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;

	//입력을 안했으면
	if(strValue.lenght == 0){
		if (msgFlag != "N") {
			alert("이메일을 입력하셔야 합니다.");
		}
		return false;
	}

	//이메일 형식에 맞지않으면
	if (!strValue.match(regExp)){
		if (msgFlag != "N") {
			alert("이메일 형식에 맞지 않습니다.");
		}
		return false;
	}
	return true;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//기능 Ajax 통신 ////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * 조회 요청
 */
function searchCall(grid, url, functionID, params) {
	// 상태바 활성화
	if (grid != null && grid != "undefined") {
		grid.showProgress();
	}
	
    if( params == null || params == "undefined") {
    	var value1 = fnGetParams();
    } else {
    	var value1 = params;
    }
    
    if( functionID == null || functionID == "undefined") {
    	var value2 = 'fnSearchSuccess';
    } else {
    	var value2 = functionID + 'Success';
    }
	
	// 조회 요청
	ajaxJsonCall(url+".do", value1, eval(value2));
}

/**
 * 삭제 요청
 */
function deleteCall(grid, url, functionID, params) {
	// 파라미터 셋팅
    if( params == null || params == "undefined") {
    	var value1 = fnGetMakeParams();
    } else {
    	var value1 = params;
    }
    
	// 그리드가 존재하는 경우 상태바 활성화 및 그리드 데이터 추출
    if( grid != null && grid == "undefined") {
    	grid.showProgress();
    	// ITEM_LIST 중복을 피하기 윟 파라미터 값에서 체크한 후 없는 경우만 생성
    	var checkKey = false;
        for (var key in value1) {
        	
        	if (value1[key] == "ITEM_LIST") {
        		checkKey = true;
        	}
        }     	
        if (!checkKey) {
        	$.extend(value1, {"ITEM_LIST":grid.getStateRows()});
        }
    }    
    
    if( functionID == null || functionID == "undefined") {
    	var value2 = 'fnDeleteSuccess';
    	var value3 = 'fnDeleteFail';
    } else {
    	var value2 = functionID + 'Success';
    	var value3 = functionID + 'Fail';
    }
    
	// 조회 요청
	ajaxJsonCall(url+".do", value1, eval(value2), eval(value3));
}

/**
 * 저장 요청
 */
function saveCall(grid, url, functionID, params) {
	// 파라미터 셋팅
    if( params == null || params == "undefined") {
    	var value1 = fnGetMakeParams();
    } else {
    	var value1 = params;
    }
    
	// 그리드가 존재하는 경우 상태바 활성화 및 그리드 데이터 추출
    if( grid != null && grid == "undefined") {
    	grid.showProgress();
    	
    	// ITEM_LIST 중복을 피하기 윟 파라미터 값에서 체크한 후 없는 경우만 생성
    	var checkKey = false;
        for (var key in value1) {
        	
        	if (value1[key] == "ITEM_LIST") {
        		checkKey = true;
        	}
        }     	
        if (!checkKey) {
        	$.extend(value1, {"ITEM_LIST":grid.getStateRows()});
        }
    	
    }	    

    if( functionID == null || functionID == "undefined") {
    	var value2 = 'fnSaveSuccess';
    	var value3 = 'fnSaveFail';
    } else {
    	var value2 = functionID + 'Success';
    	var value3 = functionID + 'Fail';
    }
	
	// 조회 요청
	ajaxJsonCall(url+".do", value1, eval(value2), eval(value3));
}

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
    	//$('body').append('<div class="loading-area"></div>');
    	loading();
    },
    complete:function(){
    	//if (undefined==param.pageLoader || !param.pageLoader) $('.loading-area').remove();
    	loadingEnd();
    },
    success : function(data) {
        try {
            if (data) {
                if (data["status"] == "SUCC") {
                    if (typeof successCallback !== 'undefined') {
                        successCallback(data);
                    }
                } else if (data["status"] == "FAIL"){
                    
                    if (typeof errorCallback !== 'undefined') {
                        errorCallback(data);
                    }else{
                    	alert(data["errMsg"]);
                    }
//                    try{ $('.loading-area').remove(); } catch(e){}
                    try{ loadingEnd(); } catch(e){}
                } else {
                    if (typeof successCallback !== 'undefined') {
                        successCallback(data);
                    }
                }
            }
        } catch (e) {
            alert(e.message);
//            try{ $('.loading-area').remove(); } catch(e){}
            try{ loadingEnd(); } catch(e){}
        }
    },
    error : function(xhr, status, error) {
        if (401 === xhr.status) {
            alert('<spring:message code="M1000015" javaScriptEscape="true"/>');
            location.href = "/";
        } else if (500 === xhr.status) {
        	alert('서버에 오류가 발생하여 요청을 수행할 수 없습니다. 시스템 관리자에게 문의 바랍니다.');
        } else {
            alert(error);
        }
        try{ $('.loading-area').remove(); } catch(e){}
        }
    });
};

var ajaxJsonCallSync = function(url, param, successCallback, errorCallback, isProgress) {
    var contentType;
    var data;
    var dataType;

    //fnAddDefaultValue(param);
    
    if (typeof param == "string") {
        contentType = "application/json;charset=UTF-8";
        data = param;
        dataType = "json"
    } else if (typeof param == "object") {
        contentType = "application/json;charset=UTF-8";
        data = JSON.stringify(param);
        dataType = "json"
    } else {
        alert("ajaxJsonCall Type 오류");
    }

    // console.log( "data = "+ data);

    if (isEmpty(isProgress)) {
        ajaxShowProgress();
    } else {
        if (isProgress) ajaxShowProgress();
    }

    $.ajax({
        type : 'POST'
        ,url : url
        ,contentType : contentType
        ,data : data
        ,dataType : dataType
        ,async : false
        ,beforeSend : function(xmlHttpRequest) {
            xmlHttpRequest.setRequestHeader("ajax", "true");
            xmlHttpRequest.setRequestHeader(gCSRF_PARAM_NAME, fnGetCsrfToken() );
        }
        ,success : function(data) {
           // console.log(">>>>>>>>>", JSON.stringify(data));
            try {
                if (data) {
                    if (data["status"] === "SUCC") {
                        if (!isEmpty(data["message"])) alert(data["message"]);
                        if (typeof successCallback !== 'undefined') {
                            successCallback(data);
                        }
                    } else if (data["status"] === "FAIL") {
                    	if (!isEmpty(data["message"])) {
                    		if( "_ACCESS_DENIED_" == data["message"] ) {
                    			location.href = getContextPath() + "/common/accessDenied.jsp";
                    			return;
                    		} else if ( "_NO_AUTH_" == data["message"] ) {
                    			location.href = getContextPath() + "/common/noAuthError.jsp";
                    			return;
                    			
                    		} else if ( "_DUP_USER_" == data["message"] ) {
                    			location.href = getContextPath() + "/common/dupAccessDenied.jsp";
                    			return;
                    		}
                    	}                    	
                        if (!isEmpty(data["errMsg"])) alert(data["errMsg"]);
                        if (typeof errorCallback !== 'undefined') {
                            errorCallback(data);
                        }
                    } else {
                        if (typeof successCallback !== 'undefined') {
                            successCallback(data);
                        }
                    }
                }
            } catch (e) {
                //console.log(JSON.stringify( e));
                alert(e.message);
            }
        }
        ,error : function(xhr, status, error) {
            // console.log("xhr=" + JSON.stringify( xhr));
            // console.log("status=" + JSON.stringify( status));
            // console.log("error=" +  JSON.stringify(error));
            if (401 === xhr.status) {
                //alert('사용자 세션이 만료 되었거나, 로그인 하지 않았습니다.');
                location.href = getContextPath() + "/common/accessDenied.jsp";
            } else {
                alert("서버 응답 오류:" + error);
            }
        }
    });
};


/*
 * 첨부파일  ajax 통신
 * */
var ajaxFileJsonCall = function(url, params, successCallback, errorCallback, isProgress) {
	/*
	var maxSize = 10485760;
	var formParam = new FormData();
	var fileTotalSize = 0;
	
	for(var i=0; i < $("#"+params.fileInputId)[0].files.length; i++){

		formParam.append("_uploadFile", $("#"+params.fileInputId)[0].files[i]);
		
		var size = $("#"+params.fileInputId)[0].files[i].size;
		if( maxSize < size){
			alert("첨부파일 사이즈는 10MB 이내로 등록 가능합니다.");
			return;
		}

		var fileNm = $("#"+params.fileInputId)[0].files[i].name;
		var ext = fileNm.substring(fileNm.lastIndexOf(".")+1, fileNm.length);
		if (!isValidFileExt(ext)) {
	        //alert("첨부할 수 없는 확장자를 가진 파일입니다.");
	        return ;
	    }
    }
	*/
	var formParam = new FormData();

	for(var i=0; i < $("#"+params.fileInputId)[0].files.length; i++){
		formParam.append("_uploadFile", $("#"+params.fileInputId)[0].files[i]);
	}

	formParam.append("FILE_MNG_KEY", params.FILE_MNG_KEY);
	formParam.append("AUDIT_YN", params.AUDIT_YN);
	formParam.append("fileInputId", params.fileInputId);

    if (isEmpty(isProgress)) {
        ajaxShowProgress();
    } else {
        if (isProgress) ajaxShowProgress();
    }

    $.ajax({
        type : 'POST'
        ,url : url
        ,contentType : false
        ,processData : false
        ,data : formParam
        ,dataType : "json"
        ,beforeSend : function(xmlHttpRequest) {
            xmlHttpRequest.setRequestHeader("ajax", "true");
            xmlHttpRequest.setRequestHeader(gCSRF_PARAM_NAME, fnGetCsrfToken() );
        }
        ,success : function(data) {
            try {
                if (data) {
                    if (data["status"] === "SUCC") {
                        if (!isEmpty(data["message"])) alert(data["message"]);
                        if (typeof successCallback !== 'undefined') {
                            successCallback(data);
                        }
                    } else if (data["status"] === "FAIL") {
                    	if (!isEmpty(data["message"])) {
                    		if( "_ACCESS_DENIED_" == data["message"] ) {
                    			location.href = getContextPath() + "/common/accessDenied.jsp";
                    			return;
                    		} else if ( "_NO_AUTH_" == data["message"] ) {
                    			location.href = getContextPath() + "/common/noAuthError.jsp";
                    			return;
                    			
                    		} else if ( "_DUP_USER_" == data["message"] ) {
                    			location.href = getContextPath() + "/common/dupAccessDenied.jsp";
                    			return;
                    		}
                    	}                    	
                        if (!isEmpty(data["errMsg"])) alert(data["errMsg"]);
                        if (typeof errorCallback !== 'undefined') {
                            errorCallback(data);
                        }
                    } else {
                        if (typeof successCallback !== 'undefined') {
                            successCallback(data);
                        }
                    }
                }
            } catch (e) {
                //console.log(JSON.stringify( e));
                alert(e.message);
            }
        }
        ,error : function(xhr, status, error) {
            if (401 === xhr.status) {
                //alert('사용자 세션이 만료 되었거나, 로그인 하지 않았습니다.');
            	location.href = getContextPath() + "/common/accessDenied.jsp";
            } else {
                alert("서버 응답 오류:" + error);
            }
        }
    });
};


/*
 * 첨부파일 확장자 체크 함수
 */
function isValidFileExt(ext){

    
    fileExt = ext.toLowerCase();

    var acceptFileTypes = _gFileAttchAllowType.replaceAll("*.", ""); 

	if (acceptFileTypes.indexOf(fileExt)<0) {
		alert("허용되지 않은 확장자 입니다.\n\n업로드 가능 확장자 : " + acceptFileTypes );
		return false;
	} else { 
		return true;
	}

    /*
    switch(ext.toLowerCase()){
        case 'txt' :
            isFlag = true;
            break;
        case 'xls' :
            isFlag = true;
            break;
        case 'xlsx' :
            isFlag = true;
            break;
        case 'doc' :
            isFlag = true;
            break;
        case 'docx' :
            isFlag = true;
            break;
        case 'ppt' :
            isFlag = true;
            break;
        case 'pptx' :
            isFlag = true;
            break;
        case 'hwp' :
            isFlag = true;
            break;
        case 'zip' :
            isFlag = true;
            break;
        case 'jpg' :
            isFlag = true;
            break;
        case 'jpeg' :
            isFlag = true;
            break;
        default :
            isFlag = false;
            break;
    }

    return isFlag;
    */
}

var ajaxHtmlCall = function(url, param, successCallback, errorCallback, isProgress) {
    var contentType;
    var data;
    var dataType;

    if (typeof param == "string") {
        contentType = "application/json;charset=UTF-8";
        data = param;
        dataType = "html"
    } else if (typeof param == "object") {
        contentType = "application/json;charset=UTF-8";
        data = JSON.stringify(param);
        dataType = "html"
    } else {
        alert("ajaxHtmlCall Type 오류");
    }

    //console.log( "data = "+ data);

    if (isEmpty(isProgress)) {
        ajaxShowProgress();
    } else {
        if (isProgress) ajaxShowProgress();
    }

    $.ajax({
        type : 'POST'
        ,url : url
        ,contentType : contentType
        ,data : data
        ,dataType : dataType
        ,beforeSend : function(xmlHttpRequest) {
            xmlHttpRequest.setRequestHeader("ajax", "true");
        }
        ,success : function(data) {
            //console.log(">>>>>>>>>", JSON.stringify(data));
            try {
                if (data) {
                    if (data["status"] === "SUCC") {
                        if (!isEmpty(data["message"])) alert(data["message"]);
                        if (typeof successCallback !== 'undefined') {
                            successCallback(data);
                        }
                    } else if (data["status"] === "FAIL") {
                        if (!isEmpty(data["errMsg"])) alert(data["errMsg"]);
                        if (typeof errorCallback !== 'undefined') {
                            errorCallback(data);
                        }
                    } else {
                        if (typeof successCallback !== 'undefined') {
                            successCallback(data);
                        }
                    }
                }
            } catch (e) {
                //console.log(JSON.stringify( e));
                alert(e.message);
            }
        }
        ,error : function(xhr, status, error) {
            //console.log("xhr=" + JSON.stringify( xhr));
            //console.log("status=" + JSON.stringify( status));
            //console.log("error=" +  JSON.stringify(error));
            if (401 === xhr.status) {
                alert('사용자 세션이 만료 되었거나, 로그인 하지 않았습니다.');
                //location.href = getContextPath() + "URL정의 필요.";
            } else {
                alert("서버 응답 오류:" + error);
            }
        }
    });
};

var errorCallback = function() {
  alert("서버와의 연결이 해지되었습니다.");
};

/**
 * loading bar function
 */
function ajaxShowProgress() {
    $(document).ajaxStart(function() {
        showProgress();
    }).ajaxStop(function() {
        hideProgress();
    });
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//기능 Controll 제어 ////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
* input시 글자수 제한
* inputObjId : 입력박스 아이디
* msgObjId : 글자수 표현할 메시지 박스 아이디
* maxSize : 제한 글자수
*/
var setTextLimit = function (inputObjId, maxSize) {

  var hanLen 		= maxSize/3;
  var _msgObjId 	= "_"+inputObjId+"_MSG";
  hanLen = parseInt(hanLen);

  //console.log($("#"+inputObjId).attr('type'));
  
  if ("text"==$("#"+inputObjId).attr('type')) {
  	$("#"+inputObjId).after("<div class='t_right d_none'><span id='"+_msgObjId+"'></span></div>");
  } else {
  	$("#"+inputObjId).after("<div class='t_right'><span id='"+_msgObjId+"'></span></div>");
  }
  
  if (_msgObjId!=null && _msgObjId!="") {
      var rtnVal = calculateBytes($("#"+inputObjId).val(), maxSize);

      $("#"+_msgObjId).empty();
      $("#"+_msgObjId).append(rtnVal[0]+"/"+maxSize);
  }
  
  $("#"+inputObjId).on("change keyup", function() {
      var rtnVal = calculateBytes($("#"+inputObjId).val(), maxSize);
      var currSize = rtnVal[0];
      if (currSize > maxSize) {
          alert("입력 글자수가 초과되었습니다.\n영문은 " + maxSize +"자, 한글은 " + hanLen + "자 만큼 입력가능합니다.");
          $("#"+inputObjId).val(rtnVal[1]);
          currSize = maxSize;
      }
      if (_msgObjId!=null && _msgObjId!="") {
          $("#"+_msgObjId).empty();
          $("#"+_msgObjId).append(currSize+"/"+maxSize);
      }

  });
};

/**
* 숫자만 입력받게 하고 콤마를 붙였다 뗐다함. 사용법 : setCommaFormat('id')
* 소숫점 포함
*
* @param numObjId
*/
var setCommaFormat = function(numObjId, scale) {

  // $("input[id=" + numObjId + "]").attr("style","text-align:right"); // 다른
  // Style까지 모두 무시되어 아래 CSS로 변경
  $("input[id=" + numObjId + "]").css("text-align", "right");
  $("input[id=" + numObjId + "]").keyup(function(event) {
  	if( isNotEmpty(scale) && 0 != scale ) {
        var val = $(this).val().match(/[^0-9.-]/g);
        if (val != null) {
            $(this).val(Number($(this).val().replace(/[^0-9.-]/g, '')));
        }
  	} else {
  		var val = $(this).val().match(/[^0-9-]/g);
        if (val != null) {
            $(this).val(Number($(this).val().replace(/[^0-9-]/g, '')));
        }
  	}
  });
  $("input[id=" + numObjId + "]").focus(function(event) {
      $(this).val($(this).val().replace(/,/g, ""));
  });
  $("input[id=" + numObjId + "]").blur(function() {
  	//console.log( numObjId + " blur");
  	if ($(this).val() != null) {
  		//console.log(  "value = " + $(this).val());
  		if( isNotEmpty(scale) && 0 != scale) {
            var arrNum = $(this).val().split('.');
            if (arrNum.length >= 2) {
            	var scaleValue = arrNum[1].substring(0, scale);
                $(this).val(arrNum[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "." + scaleValue);
            } else {
                $(this).val(arrNum[0].replace(/\B(?=(\d{3})+(?!\d))/g, ","));
            }
    	} else {
            var arrNum = $(this).val().split('.');
            if (arrNum.length >= 2)
                $(this).val(arrNum[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",") );
            else
                $(this).val(arrNum[0].replace(/\B(?=(\d{3})+(?!\d))/g, ","));
    	}
  	}
  });
};

/**
* 날짜를 수기로 입력하게함 ,  사용법 : setDateFormat('id')
* 입력형식 : YYYY-MM-DD , YYYYMMDD
*
* @param numObjId
*/
var setDateFormat = function(numObjId) {

  $("input[id=" + numObjId + "]").keyup(function(event) {
		var val = $(this).val().match(/[^0-9-]/g);
		if (val != null) {
		    $(this).val($(this).val().replace(/[^0-9-]/g, ''));
		}
  	
  });
  $("input[id=" + numObjId + "]").blur(function() {
  	if ($(this).val() != null) {
  		var strDate = $(this).val().replace(/-/g, "");
  		
        if (!isDate(strDate)) {
            alert("날짜 형식이 맞지 않습니다.");
            $(this).val("");
        }else{
        	$(this).val(strDate.substring(0, 4) + "-" + strDate.substring(4, 6) + "-" + strDate.substring(6, 8));
        }
  	}
  });
};

/**
* 00 ~ 23시까지만 입력하게 함,  사용법 : setHourFormat('id')
*
* @param numObjId
*/
var setHourFormat = function(numObjId) {

  $("input[id=" + numObjId + "]").css("text-align", "center");
  $("input[id=" + numObjId + "]").keyup(function(event) {
      var val = $(this).val().match(/[^0-9]/g);
      if (val != null) {
          $(this).val($(this).val().replace(/[^0-9]/g, ''));
      }
  });

  $("input[id=" + numObjId + "]").blur(function() {
  	//console.log( numObjId + " blur");
      if ($(this).val() != null) {
      	var value = Number($(this).val());
      	//console.log(  "value = " + value);
      	
      	if( value < 0 || value > 23) {
      		alert( "00 ~ 23 시 까지만 가능합니다.");
      		$(this).val("23");
      	} else if( value < 10 ) {
      		$(this).val("0" + value);
      	}

      }
  });
};


/**
* 00 ~ 59분 까지만 입력하게 함,  사용법 : setMinuteFormat('id')
*
* @param numObjId
*/
var setMinuteFormat = function(numObjId) {

  $("input[id=" + numObjId + "]").css("text-align", "center");
  $("input[id=" + numObjId + "]").keyup(function(event) {
      var val = $(this).val().match(/[^0-9]/g);
      if (val != null) {
          $(this).val($(this).val().replace(/[^0-9]/g, ''));
      }
  });

  $("input[id=" + numObjId + "]").blur(function() {
      if ($(this).val() != null) {
      	var value = Number($(this).val());
      	if( value < 0 ||  value > 59) {
      		alert( "00 ~ 59 분 까지만 가능합니다.");
      		$(this).val("59");
      	} else if( value < 10 ) {
      		$(this).val("0" + value);
      	}
      }
  });
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


/**
* 스페이스바 사용 불가
* 사용법 : <input type="text" onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);">
*
* @param numObjId
*/ 
var noSpaceForm = function (obj) { // 공백사용못하게
    var str_space = /\s/;  // 공백체크
    if(str_space.exec(obj.value)) { //공백 체크
        alert("해당 항목에는 공백을 사용할수 없습니다.\n공백은 자동적으로 제거 됩니다.");
        obj.focus();
        obj.value = obj.value.replace(' ',''); // 공백제거
        return false;
    }
}
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
	            }
        	}
        }
    });
    
    return params;
};


var fnGetParamsOn = function() {
	var params = {};
	$(':input').each(function() {
		if (this.id.indexOf('jqg')>-1) {
			//나중에 그리드 INPUT 받아서 처리시에 추가
		} else {
			if (this.id != '') {
				if ($(this).prop("disabled") == false) {
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
				}
			}
		}
	});
	
	return params;
};


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
 * HTML Document에서 입력 Tag들의 값을 Object에 담아 반환
 * Input, Select, TextArea tag?값을 읽어서 param에 담음
 * @param isIncludeDisabled
 *            disabled된 입력 Tag 값을 가져올지 구분, 디폴트는 가져옴
 * @returns params Objects
 */
var fnGetFormParams = function(formId, isIncludeDisabled) {
    isIncludeDisabled = isIncludeDisabled || true;
    var params = {};
    $('#'+ formId + ' :input').each(function() {
    	if (this.id != '') {
	        if (this.id.indexOf('jqg')>-1) {
	            //나중에 그리드 INPUT 받아서 처리시에 추가
	        } else {
	            if (!isIncludeDisabled) {
	                if ('disabled' != $(this).attr('disabled')) {
	                    params[this.id] = $(this).val();
	                    if ( $(this).is('.decimal, .decimal1, .decimal2, .decimal3, .integer') ){
	    	            	params[this.id] = params[this.id].replace(/,/gi,"");
	    	            }
	                }
	            } else {
	            	if (this.type=="checkbox") {
	            		if (this.checked) params[this.id] = $(this).val();
	            		else params[this.id] = "";
	            	} else if (this.type=="radio") {
	            		if( this.checked) params[this.id] = $(this).val();
	            	} else {
	            		params[this.id] = $(this).val();		
	            	}
	            	if ( $(this).is('.decimal, .decimal1, .decimal2, .decimal3, .integer') ){
		            	params[this.id] = params[this.id].replace(/,/gi,"");
		            }
	            }
	        }
    	}
    });
    
    $.extend( params, fnGetMakeParams());
    
    return params;
};

/**
 * 입력 화면을 상세 조회 화면으로 사용할때
 * input, select, textarea에 대해서 공통으로 처리
 */
var SetReadOnly = function (btnYn) {
    'use strict';
    $(':input').attr('readonly', true);
    $(':input').addClass('readOnly');
    
    var btnShowYn = false;
    
    if(btnYn == undefined){
        btnShowYn = false;
    }else{
        if(btnYn){
            btnShowYn = true;
        }else{
            btnShowYn = false;
        }
    }
    $('.gBtn, button').hide();
    $('.tBtn, button').hide();
    $('.ico').hide();
    $('.searchicon').hide();
    if(!btnShowYn){       
        $('.btnL, button').hide();
    }
    
    /*  single file upload readonly */
    $('input[id$="_uploadFile"]').hide();
    $('.file-upload').hide();
    $('input[id$="_setReadOnlyFlag"]').val('Y');
    /*  single file upload readonly */
    
    $(".datepicker").each(function() {
    	$(this).hide();
    	$(this).after($(this).val());
    });
    
    $('input:radio').each(function() {
    	$(this).hide();
    	if (!$(this).is(':checked')) {try{$(this)[0].nextSibling.nodeValue = "";}catch(e){}}
    });
    $('input:checkbox').each(function() {
    	$(this).hide();
    	if (!$(this).is(':checked')) {try{$(this)[0].nextSibling.nodeValue = "";}catch(e){}}
    });
    $('select').each(function() {
        //if (!$(this).is(':selected')) fnHide($(this));
    	$(this).hide();
    	try{
    	if (""!=$(this)[0].options[$(this)[0].selectedIndex].value) {
    		$(this).after($(this)[0].options[$(this)[0].selectedIndex].text);
    	}}catch(e){}
    });
    $('textarea').each(function() {
        $(this).css('border', 'solid 1px #c6c6c6');
    });
    
};

/**
 * 입력 화면을 상세 조회 화면으로 사용할때
 * input, select, textarea에 대해서 공통으로 처리
 */
var SetReadOnlyLine = function (btnYn) {
    'use strict';
    $(':input').attr('readonly', true);

    /*  single file upload readonly */
    $('input[id$="_uploadFile"]').hide();
    $('.file-upload').hide();
    $('input[id$="_setReadOnlyFlag"]').val('Y');
    /*  single file upload readonly */
    
    $(".datepicker").each(function() {
    	$(this).hide();
    	$(this).after($(this).val());
    });
    
    $('input:radio').each(function() {
    	$(this).hide();
    	if (!$(this).is(':checked')) {try{$(this)[0].nextSibling.nodeValue = "";}catch(e){}}
    });
    $('input:checkbox').each(function() {
    	$(this).attr("disabled","disabled");
    	//if (!$(this).is(':checked')) {try{$(this)[0].nextSibling.nodeValue = "";}catch(e){}}
    });
    $('select').each(function() {
        //if (!$(this).is(':selected')) fnHide($(this));
    	$(this).hide();
    	try{
    	if (""!=$(this)[0].options[$(this)[0].selectedIndex].value) {
    		$(this).after($(this)[0].options[$(this)[0].selectedIndex].text);
    	}}catch(e){}
    });
    $('textarea').each(function() {
        $(this).css('border', 'solid 1px #c6c6c6');
    });
};

var SetReadOnlyJqgrid = function(gridId) {
	'use strict';
    $('#'+gridId+' :input').attr('readonly', true);

    $('#'+gridId+' .datepicker').each(function() {
    	$(this).hide();
    	$(this).after($(this).val());
    });
    
	$('#'+gridId+' input:radio').each(function() {
    	$(this).hide();
    	if (!$(this).is(':checked')) {try{$(this)[0].nextSibling.nodeValue = "";}catch(e){}}
    });
    $('#'+gridId+' input:checkbox').each(function() {
    	$(this).attr("disabled","disabled");
    	//if (!$(this).is(':checked')) {try{$(this)[0].nextSibling.nodeValue = "";}catch(e){}}
    });
    $('#'+gridId+' select').each(function() {
        //if (!$(this).is(':selected')) fnHide($(this));
    	$(this).hide();
    	try{
    	if (""!=$(this)[0].options[$(this)[0].selectedIndex].value) {
    		$(this).after($(this)[0].options[$(this)[0].selectedIndex].text);
    	}}catch(e){}
    });
    $('#'+gridId+' textarea').each(function() {
        $(this).css('border', 'solid 1px #c6c6c6');
    });
    
	$("#"+gridId+" .btn").hide();
	$("#"+gridId+" .ui-datepicker-trigger").hide();
	$("#"+gridId).find('img').hide();
}
/**
 * form 의
 * input, select, textarea에 대해서 공통으로 처리
 */
var SetFormReadOnly = function (formId, btnYn) {
    'use strict';
    $('#' + formId + ' :input').attr('readonly', true);
    $('#' + formId + ' :input').addClass('readOnly');
    
    var btnShowYn = false;
    
    if(btnYn == undefined){
        btnShowYn = false;
    }else{
        if(btnYn){
            btnShowYn = true;
        }else{
            btnShowYn = false;
        }
    }
    
    $('#' + formId + ' .gBtn').hide();
    $('#' + formId + ' .tBtn').hide();
    $('#' + formId + ' :button').hide();
    $('#' + formId + ' .ico').hide();
    
    if(!btnShowYn){       
        $('#' + formId + ' .btnL').hide();
    }
    
    /*  single file upload readonly */
    $('#' + formId + ' input[id$="_uploadFile"]').hide();
    $('#' + formId + ' .file-upload').hide();
    $('#' + formId + ' input[id$="_setReadOnlyFlag"]').val('Y');
    /*  single file upload readonly */
    
    $('#' + formId + ' .datepicker').each(function() {
    	$(this).hide();
    	$(this).after($(this).val());
    });
    
    $('#' + formId + ' input:radio').each(function() {
    	$(this).hide();
		if (!$(this).is(':checked')) $(this)[0].nextSibling.nodeValue = "";
    });
    $('#' + formId + ' input:checkbox').each(function() {
    	$(this).hide();
    	if (!$(this).is(':checked')) $(this)[0].nextSibling.nodeValue = "";
    });
    $('#' + formId + ' select').each(function() {
        //if (!$(this).is(':selected')) fnHide($(this));
    	$(this).hide();
    	if (""!=$(this)[0].options[$(this)[0].selectedIndex].value) {
    		$(this).after($(this)[0].options[$(this)[0].selectedIndex].text);
    	}
    });
    $('#' + formId + ' textarea').each(function() {
        $(this).css('border', 'solid 1px #c6c6c6');
    });

};



/**
 * 특정 id의
 * input, select, textarea에 대해서 공통으로 처리
 */
var SetReadOnlyById = function (args) {
    'use strict';
    for( var i = 0, nSize = args.length; i < nSize; i++) {

    	var obj = $('#' + args[i]); 
    	/*
    	console.log( "args[i] = " + args[i]);
    	console.log( "obj attr type = " + obj.attr("type"));
    	console.log( "obj hasClass = " + obj.hasClass('datepicker') );
    	console.log( "obj is select= " + obj.is("select") );
    	console.log( "obj is textarea= " + obj.is("textarea") );
    	console.log( "obj.next().text()=" + obj.next().is("button") );
    	*/
    	
    	obj.attr('readonly', true);
    	obj.addClass('readOnly');
	    
    	if( obj.is("input")) {
    		var objType = obj.attr("type");
    		
    		if( objType == "text") {

    		    if( obj.hasClass('datepicker') ) {

    		    	if( obj.next().is("button")) {
    		    		if( obj.next().hasClass('ui-datepicker-trigger')) {
    		    			obj.next().hide();
    		    		}
    		    	}
    		    }
    		    
    		} else if( objType == "radio") {

    		} else if( objType == "checkbox") {
    			
    		} else {
    			
    		}
    	} else if( obj.is("select")) {
    		obj.each(function() {
    	    	obj.hide();
    	    	if (""!=obj[0].options[obj[0].selectedIndex].value) {
    	    		obj.after(obj[0].options[obj[0].selectedIndex].text);
    	    	}
    	    });
    	} else if( obj.is("textarea")) {
    		obj.css('border', 'solid 1px #c6c6c6');
    	} else if( obj.is("button")) {
    		obj.hide();
    	} else {
    		if( obj.hasClass('tBtn') 
    			|| obj.hasClass('gBtn')
    			|| obj.hasClass('ico')) {
    			obj.hide();
    		} 

    	}
    }
};

/**
 * 버튼의 상태를 처리한다.
 *
 * @param btnId -
 *            button 객체 아이디
 * @param btnStatus -
 *            button 상태
 */
var setButtonStatus = function(btnId, btnStatus) {
    var arrData = btnId.split("^");
    for (var i = 0; i < arrData.length; i++) {
        if (btnStatus === 'N') {
            $("#" + arrData[i]).hide();
        } else {
            $("#" + arrData[i]).show();
        }
    }
};


var SetDisabledById = function (args, isFlag) {
    'use strict';
    for( var i = 0, nSize = args.length; i < nSize; i++) {

    	var obj = $('#' + args[i]); 
    	/*
    	console.log( "args[i] = " + args[i]);
    	console.log( "obj attr type = " + obj.attr("type"));
    	console.log( "obj hasClass = " + obj.hasClass('datepicker') );
    	console.log( "obj is select= " + obj.is("select") );
    	console.log( "obj is textarea= " + obj.is("textarea") );
    	console.log( "obj.next().text()=" + obj.next().is("button") );
    	*/

    	if( isFlag ) {
	    	obj.attr('disabled', true);
	
	    	if( obj.is("input")) {
	    		var objType = obj.attr("type");
	    		if( objType == "text") {
	
	    		    if( obj.hasClass('datepicker') ) {
	    		    	if( obj.next().is("button")) {
	    		    		if( obj.next().hasClass('ui-datepicker-trigger')) {
	    		    			obj.next().hide();
	    		    		}
	    		    	}
	  		    	
	    		    }
	    		    
	    		} else if( objType == "radio") {
	    			$('input:radio[name="' + args[i] + '"]').each(function() {
	    		        $(this).attr('disabled', true);
	    			});
	
	    		} else if( objType == "checkbox") {
	    			
	    		} else {
	    		}
	    	} else if( obj.is("button")) {
	    		obj.hide();
	    	} else {
	    		if( obj.hasClass('tBtn') 
	    			|| obj.hasClass('gBtn')
	    			|| obj.hasClass('ico')) {
	    			obj.hide();
	    		} 
	    	}
    	} else {
    		obj.attr('disabled', false);
    		
	    	if( obj.is("input")) {
	    		var objType = obj.attr("type");
	    		if( objType == "text") {
	
	    		    if( obj.hasClass('datepicker') ) {
	    		    	if( obj.next().is("button")) {
	    		    		if( obj.next().hasClass('ui-datepicker-trigger')) {
	    		    			obj.next().show();
	    		    		}
	    		    	}
	  		    	
	    		    }
	    		}
	    	} else if( obj.is("button")) {
	    		obj.show();
	    	} else {
	    		if( obj.hasClass('tBtn') 
	    			|| obj.hasClass('gBtn')
	    			|| obj.hasClass('ico')) {
	    			obj.show();
	    		} 
	    	}
    	}
    }
};



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//화면 제어 ////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
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

function fnAddDefaultValue(params) {
	if( isEmpty(params.COMP_CD)) {
		params.COMP_CD = _gCompCd;
	}
	
	if( isEmpty(params.SYS_TYPE)) {
		params.SYS_TYPE = _gSysType;
	}
}

/**
 * CSRF Token을 가져온다
 */
var fnGetCsrfToken = function() {
	return $("#_MENU_FORM_").find("input[name=" + gCSRF_PARAM_NAME + "]").val();
};


/**
 * CSRF Token Param을 가져온다
 */
var fnGetCsrfTokenParam = function() {
	var param = {};
	param[gCSRF_PARAM_NAME] = fnGetCsrfToken();
	return param;
};

/**
 * target URL로 POST request 한다. 사용법 : gotoUrlMethodPost("<c:url
 * value='TARGET_URL지정'/>", params , "_self");
 *
 * @param url
 * @param params
 * @param target
 */
var gotoUrlMethodPost = function(url, params, target) {
    var f = document.createElement('form');
    var obj, value;
    for (var key in params) {
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
    f.setAttribute('action', url +".do");
    document.body.appendChild(f);
    f.submit();
};

/**
 * GET 방식으로 submit
 *
 * @param url
 *            submit할 주소
 * @param params
 *            Plain Object
 * @param target
 *            url이 적용되는 target 이름(현재 페이지는 '_self'
 */

var fnGetGoto = function(url, params, target) {
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
    f.setAttribute('method', 'get');
    f.setAttribute('action', url);
    document.body.appendChild(f);
    f.submit();
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
 * Post 방식으로 Popup 다중 계단식으로 띄웁
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
 * @param offset
 *            팝업창 높이
 */
var fnPostPopupOffset = function(url, params, target, width, height, offset, scrollbar, resizable) {
    //console.log("offset",offset);
    if ("_self"==target) {
        fnPostGoto(url, params, target);
    } else {
    	scrollbar = scrollbar || "yes";
        resizable = resizable || "yes";
        var pos = centerWindow(width, height);
        var xpos =  Number(pos[0]) + Number(offset);
        var ypos =  Number(pos[1]) + Number(offset);
        var popup = window.open("", target, "width=" + width + ",height=" + height + ",left=" + xpos + ",top=" + ypos + ",status=no, scrollbars=" + scrollbar + ", resizable=" + resizable );
        fnPostGoto(url, params, target);
        popup.focus();
        return popup;
    }
};

var fnGetRandomText = function(textSize) {
    var text = "";
    var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    for( var i=0; i < textSize; i++ )
        text += possible.charAt(Math.floor(Math.random() * possible.length));

    return text;	
};


//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Validation 체크 ////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
* 숫자여부 
*/
function isNumCheck(num)
{
  var objPattern =  /^[-]?\d?\d*\.?\d*$/;
  var str = num;
  if(str == "" || str == null) {
      return true;
  } else {
      if (!objPattern.test(str)) {
          return false;
      } else {
          return true;
      }
  }
}

/**
* 비밀번호 유효성 검증
*
* @param uidObjId -
*            사용자 아이디 Object ID
* @param upwObjId -
*            입력된 비밀번호 Object ID
*/
var checkPasswordValidate = function(uidObjId, upwObjId) {

  var uid = $("#" + uidObjId).val();
  var upw = $("#" + upwObjId).val();

  if (!/^[a-zA-Z0-9]{8,20}$/.test(upw)) {
      alert('비밀번호는 숫자와 영문자 조합으로 8자리 이상을 사용해야 합니다.');
      return false;
  }

  var chk_num = upw.search(/[0-9]/g);
  var chk_eng = upw.search(/[a-z]/ig);

  if (chk_num < 0 || chk_eng < 0) {
      alert('비밀번호는 숫자와 영문자를 혼용하여야 합니다.');
      return false;
  }

  if (/(\w)\1\1\1/.test(upw)) {
      alert('비밀번호에 같은 문자를 4번 이상 사용하실 수 없습니다.');
      return false;
  }

  if (upw.search(uid) > -1) {
      alert('ID가 포함된 비밀번호는 사용하실 수 없습니다.');
      return false;
  }

  return true;

};

/**
* 값이 다른지 비교
*
* @param objId -
*            Object Id
* @param compareData -
*            비교할 값
*/
var isNotEqual = function(objId, compareData) {
  if ($("#" + objId).val() == compareData) { return false; }
  return true;
};

/**
* 값이 동일한지 비교
*
* @param objId -
*            Object Id
* @param compareData -
*            비교할 값
*/
var isEqual = function(objId, compareData) {
  if ($("#" + objId).val() == compareData) { return true; }
  return false;
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

var isEmptyToStr = function(fieldText, str) {
	if (isEmpty(fieldText)) return str;
	else return fieldText;
};


var isNotEmpty = function(fieldText) {
	if( isEmpty(fieldText) ) {
		return false;
	} else {
		return true;
	}
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
};


/**
* 빈값체크 후 메시지 처리 및 포커스
*
* @param objId -
*            Object Id
* @param msgText -
*            빈값일 경우 출력할 메세지
*/
var isEmptyMsg = function(objId, msgText) {

  if ($("#" + objId).val() == "") {
      alert(msgText);
      $("#" + objId).focus();
      return true;
  }
  return false;

};

/**
* 값이 다른지 비교
*
* @param formId -
*            Form Id
* @param objId -
*            Object Id
* @param compareData -
*            비교할 값
*/
var isNotEqualToArr = function(formId, objId, compareData, idx) {
  if ($("#" + formId + " #" + objId).eq(idx).val() == compareData) { return false; }
  return true;
};

/**
* 배열객체의 특정 순번의 필드 값이 동일한지 비교
*
* @param formId -
*            Form Id
* @param objId -
*            Object Id
* @param compareData -
*            비교할 값
*/
var isEqualToArr = function(formId, objId, compareData, idx) {
  if ($("#" + formId + " #" + objId).eq(idx).val() == compareData) { return true; }
  return false;
};

/**
* 빈값체크 후 메시지 처리 및 포커스
*
* @param formId -
*            Form Id
* @param objId -
*            Object Id
* @param fieldText -
*            필드명
*/
var isEmptyToArr = function(formId, objId, fieldText, idx) {

  if ($("#" + formId + " #" + objId).eq(idx).val() == "") {
      if (typeof fieldText !== 'undefined') {
          alert(fieldText + "을(를) 입력하세요.");
          $("#" + formId + " #" + objId).eq(idx).focus();
      }
      return true;
  }
  return false;
};

/**
* 빈값체크 후 메시지 처리 및 포커스
*
* @param formId -
*            Form Id
* @param objId -
*            Object Id
* @param msgText -
*            빈값일 경우 출력할 메세지
*/
var isEmptyMsgToArr = function(formId, objId, msgText, idx) {

  if ($("#" + formId + " #" + objId).eq(idx).val() == "") {
      alert(msgText);
      $("#" + formId + " #" + objId).eq(idx).focus();
      return true;
  }
  return false;

};

/**
* 라디오 빈값체크 후 메시지 처리 및 포커스
*
* @param email -
*            이메일주소
*/
var isEmptyRadio = function(objId, fieldText) {
  if ($('input[name=' + objId + ']:radio:checked').length == 0) {
      alert(fieldText );
      $("#" + objId).focus();
      return true;
  } else {
      return false;
  }
};

/**
 * 날짜가 맞는 날인지 확인
 *
 * @param date
 */
var isDate = function(txtDate) {
    var currVal = txtDate;

    if (currVal == '') return false;

    if (currVal.length == 10) {
        currVal = currVal.replace(/-/g, "");
    }

    if (currVal.length < 8) return false;

    var dtArray = currVal.match(/^[0-9]{4}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])/);

    if (dtArray == null) return false;

    // Checks for mm/dd/yyyy format. yyyymmdd
    dtYear = dtArray[3];
    dtMonth = dtArray[5];
    dtDay = dtArray[7];

    if (dtMonth < 1 || dtMonth > 12)
        return false;
    else if (dtDay < 1 || dtDay > 31)
        return false;
    else if ((dtMonth == 4 || dtMonth == 6 || dtMonth == 9 || dtMonth == 11) && dtDay == 31)
        return false;
    else if (dtMonth == 2) {
        var isleap = (dtYear % 4 == 0 && (dtYear % 100 != 0 || dtYear % 400 == 0));
        if (dtDay > 29 || (dtDay == 29 && !isleap)) return false;
    }
    return true;
};

/**
 * From / To 날짜 비교 '-' 가 들어있는 날짜여야 함
 *
 * @param date
 */
var betweenDate = function(fromDate, toDate) {
    if (!isDate(fromDate)) {
        alert("시작 날짜가 형식이 맞지 않습니다.");
        return false;
    }

    if (!isDate(toDate)) {
        alert("종료 날짜가 형식이 맞지 않습니다.");
        return false;
    }

    var fromDay = getDateObj(fromDate);
    var toDay = getDateObj(toDate);

    if ((toDay.getTime() - fromDay.getTime()) < 0)
        return false;
    else {

    }
    return true;
};


/**
 * From / To 시간 비교,  '-' 가 들어있는 날짜여야 함
 *
 * 날짜: _DD, 시간: _HH, 분: _MM 이 붙어 있는 id 임
 * @param date
 */
var betweenDt = function(fromDtId, toDtId) {
	var fromDate = $("#" + fromDtId + "_DD").val();
	var toDate = $("#" + toDtId + "_DD").val();
	
	if (!isDate(fromDate) ) { 
		alert("시작 날짜가 형식이 맞지 않습니다.");
		return false;
	}
	
	if (!isDate(toDate) ) { 
		alert("종료 날짜가 형식이 맞지 않습니다.");
		return false;
	}
	var fromArray = fromDate.split("-"); 
	var toArray = toDate.split("-"); 
	
	fromDate = new Date(fromArray[0], Number(fromArray[1])-1, fromArray[2], $("#" + fromDtId + "_HH").val(), $("#" + fromDtId + "_MM").val());
	toDate = new Date(toArray[0], Number(toArray[1])-1, toArray[2], $("#" + toDtId + "_HH").val(), $("#" + toDtId + "_MM").val());
	
	if((toDate.getTime() - fromDate.getTime()) < 0){ 
		return false;
	}
	return true;
};

/**
 * From / To 시간 비교,  '-' 가 들어있는 날짜여야 함
 *
 * 날짜: _DD, 시간: _HH, 분: _MM 이 붙어 있는 id 임
 * @param date
 */
var betweenDtStrObj = function(fromDtStr, toDtId) {
	var fromDate = fromDtStr;
	var toDate = $("#" + toDtId + "_DD").val();
	
	if (!isDate(fromDate) ) { 
		alert("시작 날짜가 형식이 맞지 않습니다.");
		return false;
	}
	
	if (!isDate(toDate) ) { 
		alert("종료 날짜가 형식이 맞지 않습니다.");
		return false;
	}
	var fromArray = fromDate.split("-"); 
	var toArray = toDate.split("-"); 
	
	fromDate = getDateObj(fromDate);
	toDate = new Date(toArray[0], Number(toArray[1])-1, toArray[2], $("#" + toDtId + "_HH").val(), $("#" + toDtId + "_MM").val());
	
	if((toDate.getTime() - fromDate.getTime()) < 0){ 
		return false;
	}
	return true;
};


/**
 * 숫자여부(정수) true, false
 * 
 * @param date
 */
function is_integer(varNum) {
	var reg = /^[-|+]?\d+$/;
    return reg.test(varNum);
}


var booleanCheck = function(input, def){
    var flag;
    if(input == undefined){
        flag = def;
    }else{
        if(input){
            flag = true;
        }else{
            flag = false;
        }
    }
    return flag;
};;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//기능 파일 //////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
* 파일업로드 공통팝업
* options 항목 target, url, callback, dataFormat, width, height, readOnly
*/
/*var openFileUplaod = function(options) {
  options = options || {};
  if (options["KEY_ID"] === 'undefined') {
      alert('필수값 KEY_ID가 없습니다.');
      return;
  }
  var defaults = {TARGET:'FileUpload', url:getContextPath() + '/upload.do', CALLBACK:'fnCallBackFileUpload', DATA_FORMAT:'raw', width:800, height:500, READ_ONLY:false};
  for(var prop in defaults) {
      options[prop] = typeof options[prop] !== 'undefined' ? options[prop] : defaults[prop];
  }
  
  $.extend(options,fnGetMakeParams());
  
  options.APP_SEQ = $("#" + options.KEY_ID).val();
  fnPostPopup(options.url, options, options.TARGET, 600, 300);
  
};*/

var openAllFileDownload = function(options) {
  options = options || {};
  if (options["KEY_ID"] === 'undefined') {
      alert('필수값 KEY_ID가 없습니다.');
      return;
  }
  var defaults = {target:'downloadFrame', url:getContextPath() + '/download.do', callback:'fnCallBackFileUpload', dataFormat:'raw', width:800, height:500, readOnly:false};
  for(var prop in defaults) {
      options[prop] = typeof options[prop] !== 'undefined' ? options[prop] : defaults[prop];
  }
  options.APP_SEQ = $("#" + options.KEY_ID).val();
  if (options.APP_SEQ === '') {
      alert('다운로드 파일이 없습니다');
      return;
  }
  $('#downloadFrame').remove();
  $('body').append('<iframe id="downloadFrame" style="display:none"></iframe>');
  $('#downloadFrame').get(0).contentWindow.location.href = options.url + "?APP_SEQ=" + options.APP_SEQ;
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

var oneQmsFileDownload = function(DOC_NO, FILE_NAME,FILE_PATH) {
	var url = getContextPath() + "/itemSpecQmsDownload.do";
	url += "?DOC_NO=" + DOC_NO
	     + "&FILE_NAME=" + FILE_NAME
	     + "&FILE_PATH=" + FILE_PATH
	;
	
	$('#downloadFrame').remove();
	$('body').append('<iframe id="downloadFrame" style="display:none"></iframe>');
	$('#downloadFrame').get(0).contentWindow.location.href = url;
};

var displayFileUpload = function(options) {
	options = options || {};
	if (options["KEY_ID"] === 'undefined') {
	    alert('필수 파라미터 KEY_ID가 없습니다.');
	    return;
	}
	var defaults = {url:getContextPath() + '/upload/file.do', CALLBACK:'fnCallBackFileUpload', DATA_FORMAT:'raw', DELETE_INIT:'Y'};
	for(var prop in defaults) {
	    options[prop] = typeof options[prop] !== 'undefined' ? options[prop] : defaults[prop];
	}
	options.APP_SEQ = $("#" + options.KEY_ID).val();
	var rTable = options.TABLE_ID;
	
	var fnCallBack = window[options.CALLBACK];
	
	$.ajax({
	    type:'GET',
	    url:options.url,
	    data:{APP_SEQ:options.APP_SEQ},
	    dataType : 'json',
	    cache: false,
	    async : false,
	    success : function(result) {
	        try {
	            if (result && result.files) {
	                if (fnCallBack) {
	                    var rdata;
	                    if ("table" === options.DATA_FORMAT) {
	                    	var strTable = "";
	                    	strTable	+= "<table class='table-style t_center'>				    ";
	                    	strTable	+= "<colgroup>                                            	";
	                    	strTable	+= "	<col style='width:5%;'>                   			";
	                    	strTable	+= "	<col style='width:8%;'>                   			";
	                    	strTable	+= "	<col style='width:*;'>                   	 		";
	                    	strTable	+= "	<col style='width:15%;'>                  			";
	                    	strTable	+= "	<col style='width:10%;'>                  			";
	                    	strTable	+= "</colgroup>                                           	";
	                    	strTable	+= "<tbody>                                               	";
	                    	strTable	+= "	<tr>                                              	";
	                    	strTable	+= "		<th class='center'><input type='checkbox' checked name='F_CHK_ALL"+options["KEY_ID"] + "' onclick='gfnCheckAll(\"F_CHK_ALL"+options["KEY_ID"] + "\",\"F_CHK_"+options["KEY_ID"] + "\")'></th>";
	                    	strTable	+= "		<th class='center'>No</th>                                   	";
	                    	strTable	+= "		<th class='center'>파일명</th>                               	";
	                    	strTable	+= "		<th class='center'>등록일자</th>                             	";
	                    	strTable	+= "		<th class='center'>파일크기</th>                             	";
	                    	strTable	+= "	</tr>                                             	";
	
	                    	if (0 === result.files.length) {
	                    			strTable	+= "<tr><td colspan='5' class='t_center' style='height:60px;'>파일이 없습니다.</td></tr>";
	                    		
	                    	} else {
	                    		for(var i in result.files) {
	                    			strTable	+= "	<tr class='F_File_ROW'>											";
	                    			strTable	+= "		<td><input type='checkbox' checked name='F_CHK_"+options["KEY_ID"] + "'></td>				";
	                    			strTable	+= "		<td>"+(parseInt(i)+1)+"</td>				";
	                    			
	                    			var _downLinkUrl = "";
	                    			if ("msie"==browser.name)
	                    				_downLinkUrl = "<a href='javascript:oneFileDownload(\""+result.files[i].APP_SEQ+"\",\""+result.files[i].ATTACHMENT_SEQ+"\")' title='"+result.files[i].name+"' style='color:blue;'>"+result.files[i].name+"</a>";
	                    			else 
	                    				_downLinkUrl = "<a href='"+getContextPath() + "/" + result.files[i].url + "' title='"+result.files[i].name+"' style='color:blue;' download='"+result.files[i].name+"'>"+result.files[i].name+"</a>";
	                    				
	                    			strTable	+= "		<td class='t_left'>"+_downLinkUrl+"</td>											";
	                    			strTable	+= "		<td class='t_center'>"+formatDate(result.files[i].inputDt.substring(0, 8))+"</td>	";
	                    			strTable	+= "		<td class='t_right'>"+formatFileSize(parseInt(result.files[i].size))+"</td>			";
	                    			strTable	+= "	</tr>											";
	                    		}
	                    	}
	
	                    	strTable	+= "</tbody>												";
	                    	strTable	+= "</table>												";
	
	                    	rdata = strTable;
	                    } else if ("table2" === options.DATA_FORMAT) {
	                    	var strTable	= "";
	                    	strTable	+= "<table class='table-style t_center'>	                ";
	                    	strTable	+= "<colgroup>                                            	";
	                    	strTable	+= "	<col style='width:7%;'>                   			";
	                    	strTable	+= "	<col style='width:*;'>                   	 		";
	                    	strTable	+= "	<col style='width:15%;'>                  			";
	                    	strTable	+= "	<col style='width:15%;'>                  			";
	                    	strTable	+= "</colgroup>                                           	";
	                    	strTable	+= "<tbody>                                               	";
	
	                    	if (0 === result.files.length) {
	                    			strTable	+= "<tr><td colspan='4' class='t_center' style='height:60px;'>파일이 없습니다.</td></tr>";
	                    		
	                    	} else {
	                    		for(var i in result.files) {
	                    			strTable	+= "	<tr>											";
	                    			strTable	+= "		<td class='center'>"+(parseInt(i)+1)+"</td>				";
	                    			
	                    			var _downLinkUrl = "";
	                    			if ("msie"==browser.name)
	                    				_downLinkUrl = "<a href='javascript:oneFileDownload(\""+result.files[i].APP_SEQ+"\",\""+result.files[i].ATTACHMENT_SEQ+"\")' title='"+result.files[i].name+"' style='color:blue;'>"+result.files[i].name+"</a>";
	                    			else 
	                    				_downLinkUrl = "<a href='"+getContextPath() + "/" + result.files[i].url + "' title='"+result.files[i].name+"' style='color:blue;' download='"+result.files[i].name+"'>"+result.files[i].name+"</a>";
	                    				
	                    			strTable	+= "		<td class='t_left'>"+_downLinkUrl+"</td>											";
	                    			strTable	+= "		<td class='t_center' style='border-right:1px solid #d7d7d7'>"+formatDate(result.files[i].inputDt.substring(0, 8))+"</td>	";
	                    			strTable	+= "		<td class='t_right'>"+formatFileSize(parseInt(result.files[i].size))+"</td>			";
	                    			strTable	+= "	</tr>											";
	                    		}
	                    	}
	
	                    	strTable	+= "</tbody>												";
	                    	strTable	+= "</table>												";
	
	                    	rdata = strTable;
	                    } else if ("vTable" === options.DATA_FORMAT) {
	                    	var strTable	= "<ul class='file-Upload-List'>";
	                    	if (0 === result.files.length) {
	                    			strTable	+= "";
	                    	} else {
	                    		for(var i in result.files) {
	                    			var _downLinkUrl = "";
	                    			if ("msie"==browser.name)
	                    				_downLinkUrl = "<a href='javascript:oneFileDownload(\""+result.files[i].APP_SEQ+"\",\""+result.files[i].ATTACHMENT_SEQ+"\")' title='"+result.files[i].name+"' style='color:blue;'><p>"+result.files[i].name+"</p></a>";
	                    			else 
	                    				_downLinkUrl = "<a href='"+getContextPath() + "/" + result.files[i].url + "' title='"+result.files[i].name+"' style='color:blue;' download='"+result.files[i].name+"'><p>"+result.files[i].name+"</p></a>";
	                    				
	                    			strTable	+= "		<li>"+_downLinkUrl+"</li>";
	                    		}
	                    	}
	                    	strTable += "</ul>";
	                    	rdata = strTable;
	                    } else if ("raw" === options.DATA_FORMAT) {
	                        rdata = result.files;
	                    } else if("bTable" === options.DATA_FORMAT){
	                        var table = "";
	                            for(var i in result.files) {
	                                table  += "<a href='javascript:oneFileDownload(\"" + getContextPath() + "/" + result.files[i].url + "\");' class='downLink'>"+result.files[i].name+"</a>";
	                            }
	                        rdata=table;
	                    } else if("outTable" === options.DATA_FORMAT){
	                    	var table = "";
	                    	
	                    	if (0 === result.files.length) {
	                    		table	+= "<li>파일이 없습니다.<li>";
	                    	}else{
	                    		for(var i in result.files) {
	                                table  += "<li><a href='javascript:oneFileDownload(\""+result.files[i].APP_SEQ+"\",\""+result.files[i].ATTACHMENT_SEQ+"\")' title='"+result.files[i].name+"' style='color:blue;'>"+result.files[i].name+"</a></li>";
	                            }
	                    	}
                            rdata=table;
	                    }
	                    
	                    if (0 === result.files.length && options.DELETE_INIT == 'Y') {
	                    	$("#" + options.KEY_ID).val("");
	                    }
	                    
	                    if(rTable != ""){
	                    	fnCallBack(rdata, rTable);
	                    }else{
	                    	fnCallBack(rdata);
	                    }
	                    
	                }
	            }
	        } catch (e) {
	            alert('첨부파일 조회 중 오류가 발생하였습니다.');
	            console.log(e.message);
	        }
	    },
	    error : errorCallback
	});
};

/**
* 파일 사이즈 표시
*/
var formatFileSize = function(bytes) {
  if (typeof bytes !== 'number') {
      return '';
  }
  if (bytes >= (1024 * 1024 * 1024)) {
      return (bytes / (1024 * 1024 * 1024)).toFixed(2) + ' GB';
  }
  if (bytes >= (1024 * 1024)) {
      return (bytes / (1024 * 1024)).toFixed(2) + ' MB';
  }
  return (bytes / 1024).toFixed(2) + ' KB';
};

/*
 * 첨부파일명만 리턴하는 함수
 */
function getAttachFileName(full_path, target){
	
	// 파일명
	var file_nm = full_path.substring(full_path.lastIndexOf("\\")+1, full_path.length);
 	// 확장자
 	var ext = file_nm.substring(file_nm.lastIndexOf(".")+1, file_nm.length);
 	
 	if(isValidFileExcelExt(ext)){
 		$("#"+target).val(file_nm);
 	}else{
 		alert("첨부할 수 없는 확장자를 가진 파일입니다.");
 		return;
 	}
}

/*
 * 첨부파일 확장자 체크 함수
 */
function isValidFileExcelExt(ext){
	
	var isFlag = false;
	
	switch(ext.toLowerCase()){
		case 'xls' :
			isFlag = true;
			break;
		case 'xlsx' :
			isFlag = true;
			break;
		default :
			isFlag = false;
			break;
	}
	
	return isFlag;
}

/**
 * 문자열("YYYYMMDD" or "YYYYMMDDHH24MISS") 을 받아
 * javascript  Data 객체로 return 한다.
 */
var getDateObj = function( strTime) {

    if( isEmpty(strTime) ) {
        alert("날짜 형식이 맞지 않습니다.");
        return;
    }

    var strDt = strTime.replace(/-/g, "");
    if( strDt.length != 8 && strDt.length != 14 ) {
        alert("날짜 형식이 맞지 않습니다.");
        return;
    }

    if(strDt.length == 8 ) {
        var nYear = parseInt(strDt.substr(0,4));
        var nMonth = parseInt(strDt.substr(4,2));
        var nDay = parseInt(strDt.substr(6,2));

        return new Date(nYear, nMonth - 1, nDay);
    } else if(strDt.length == 14 ) {
        var nYear = parseInt(strDt.substr(0,4));
        var nMonth = parseInt(strDt.substr(4,2));
        var nDay = parseInt(strDt.substr(6,2));
        var nHour = parseInt(strDt.substr(8,2));
        var nMinute = parseInt(strDt.substr(10,2));
        var nSecond = parseInt(strDt.substr(12,2));

        //console.log( nYear + "-" + nMonth + "-" + nDay + "-" + nHour + "-" + nMinute + "-" + nSecond);
        return new Date(nYear, nMonth - 1, nDay, nHour, nMinute, nSecond);
    }
}

/**
 * Date 객체를 문자열 날짜("YYYYMMDDHH24MISS")로 return 한다.
 * nSize 값이 있을 경우 nSize 만큼 substr하여 return 한다.
 *
 */
var getDateStr = function( dateObj, nSize) {
    //console.log( "objTime = " + objTime);
    var nYear = dateObj.getFullYear();
    var nMonth = dateObj.getMonth() + 1;
    var nDate = dateObj.getDate();
    var nHour = dateObj.getHours();
    var nMinute = dateObj.getMinutes();
    var nSecond = dateObj.getSeconds();

    var strMonth = fn_paddingZero(nMonth, 2);
    var strDate = fn_paddingZero(nDate, 2);
    var strHour = fn_paddingZero(nHour, 2);
    var strMinute = fn_paddingZero(nMinute, 2);
    var strSecond = fn_paddingZero(nSecond, 2);


    var strDay = "" + nYear + strMonth + strDate;
    //console.log( strDate + "-" + strHour + "-" + strMinute);

    var retVal = strDay + strHour + strMinute + strSecond;

    if (isNotEmpty(nSize)) {
        retVal = retVal.substr(0,nSize);
    }
    return retVal;
}

/**
 * PC 시간과 DB 시간의 날짜 차이 계산 함수
 * dbTime : 화면 load 시 또는 ajax로 가져온 DB 시간 : YYYYMMDDHH24MISS
 */
var getDbTimeBalance = function(dbTime){
    var pcTime = new Date();
    var strCurrTime = dbTime;
    //console.log( "strCurrTime = " + strCurrTime);
    var serverTime = getDateObj(strCurrTime);
    //console.log( "pcTime = " + pcTime);
    //console.log( "serverTime = " + serverTime);
    var nTimeBalance = (serverTime - pcTime);
    return nTimeBalance;
};

/**
 * 현재 시간 구하기
 *
 * getDbTimeBalance 으로 구한 balance를 이용하여 현재시간 구하기
 *
 * return : Date 문자열
 */
var getCalCurrentDbTimeStr = function(nTimeBalance) {
    return getDateStr(getCalCurrentDbTime(nTimeBalance));
};

/**
 * 목표시간까지의 남은 시간을 구한다.
 *
 *
 */
var getRemainTime = function(strEndDt, nbalance) {
    var endTime = getDateObj(strEndDt).getTime();
    var now = getCalCurrentDbTime(nbalance).getTime();
    var remainTimes = (endTime - now) /1000 ;
    var remainText = "";

    // 남은 일수
    var day = Math.floor(remainTimes / (3600 * 24));
    var mod = remainTimes % (24 * 3600);
    //  남은시간
    var hour = Math.floor(mod / 3600);
    mod = mod % 3600;
    //    남은분
    var min = Math.floor(mod / 60);
    //    남은초
    var sec = Math.round(mod % 60);

    remainText = ( day  > 0) ? ("" + day + "일 ") : "";
    remainText = ( hour > 0) ? remainText + hour + "시간 " : (remainText.length > 0) ? remainText + hour + "시간 " : remainText;
    remainText = ( min  > 0) ? remainText + min + "분 " : (remainText.length > 0) ? remainText + min + "분 " : remainText;
    remainText = remainText + sec + "초"

    if (( sec <= 0 && remainText === "0초" ) || ( remainText === "" )) {
        //    이제그만...
        remainText = "종료";
    }
    return remainText;
};

var removeAllOption = function(objId) {
    $("#" + objId + " option").each(function() {
        $(this).remove();
    });
};

//String message 을 argument 를 치환한 문자열을 리턴한다.
var springMsgReplace = function(srcMsg, args) {
    var retMsg = srcMsg;
    if (isEmpty(args)) {
        return retMsg;
    } else {
        var argType = typeof(args);
        if (argType == "object") {
            for (var i = 0, nSize = args.length; i < nSize; i++) {
                retMsg = retMsg.replace("{" + i + "}", args[i]);
            }
        } else {
            retMsg = retMsg.replace( "{0}", args );
        }
        return retMsg;
    }
};

/**
 * Keypress시 input에 입력 key 값이 숫자만 입력 할 수 있도록 하는 함수
 * @param event
 */
function keyNumeric() {
    if ((event.keyCode >= 48 && event.keyCode <= 57) /*0 ~ 9*/
        || (event.keyCode === 8) /*Backspace key*/
        || (event.keyCode === 9) /*Tab key*/
        || (event.keyCode === 13) /*Enter key*/
        || (event.keyCode === 46) /*Delete key*/
        || (event.keyCode >= 37 && event.keyCode <= 40) /*arrow key*/){
        event.returnValue = true;
    } else {
        event.returnValue = false;
    }
}

/**
 *  Keypress시 input에 입력 key 값이 숫자와 '-' 만 입력 할 수 있도록 하는 함수
 * @param event
 */
var keyNumericDash = function() {
    //console.log("event.keyCode",event.keyCode);
    if ((event.keyCode >= 48 && event.keyCode <= 57)  ||
        (event.keyCode === 13) ||
        (event.keyCode === 45)){
        event.returnValue = true;
    } else {
// 		alert("숫자와 '-'만 입력 가능합니다.");
        event.returnValue = false;
    }
};

/**
 *  Keypress시 input에 입력 key 값이 숫자와 '-', '.' 만 입력 할 수 있도록 하는 함수
 * @param event
 */
var keyNumericDashPoint = function() {
    if((event.keyCode >= 48 && event.keyCode <= 57)  ||
        (event.keyCode === 13) ||
        (event.keyCode === 45) ||
        (event.keyCode === 46) )
    {
        event.returnValue = true;
    } else {
        alert("숫자와 '-', '.'만 입력 가능합니다.");
        event.returnValue = false;
    }
};

/**
 *  소수점 자리수 리턴
 * @param event
 */
var getPrecision = function(val) {
    var split = val.split(".");
    if (split[1] != null) {
        return split[1].length;
    } else {
        return 0;
    }
};

/**
 * 날짜 일 연산(날짜 문자열, 추가할 일수)
 */
var getAddDate = function(dateStr, addDay) {
	if( isNotEmpty(dateStr)) {
	    var dateObj = getDateObj(dateStr);
	    dateObj.setDate(dateObj.getDate() + addDay);
	    var textDate = getDateStr(dateObj, 8);
	    return formatDate(textDate);
	} else {
		return dateStr;
	}
};

/**
 * 날짜 월 더하기
 */
var getAddMonth = function(dateStr, addMonth) {
	if( isNotEmpty(dateStr)) {
	    var dateObj = getDateObj(dateStr);
	    dateObj.setMonth(dateObj.getMonth() + addMonth);
	    var textDate = getDateStr(dateObj, 8);
	    return formatDate(textDate);
	} else {
		return dateStr;
	}
};


var cfnInitLogParam = function(global, options) {
    $.extend(options, global);
    var oparams = {scrNm1:'', scrNm2:'', scrNm3:'', scrNm4:'', btnId:'', btnNm:'', actNm:''};
    oparams.scrNm1 = options.scrNm1 || '';
    oparams.scrNm2 = options.scrNm2 || '';
    oparams.scrNm3 = options.scrNm3 || '';
    oparams.scrNm4 = options.scrNm4 || '';
    oparams.btnId = options.btnId || '';
    oparams.btnNm = options.btnNm || '';
    oparams.actNm = options.actNm || '';
    return oparams;
};

var cfnGlobalParam = function(g_params, scrName) {
    if (opener && opener.g_params) {
        $.extend(g_params, opener.g_params);
        if (!g_params.scrNm1) g_params.scrNm1 = scrName;
        else {
            if (!g_params.scrNm2) g_params.scrNm2 = scrName;
            else {
                if (!g_params.scrNm3) g_params.scrNm3 = scrName;
                else {
                    if (!g_params.scrNm4) g_params.scrNm4 = scrName;
                }
            }
        }
    } else {
        g_params.scrNm1 = scrName;
    }
    $.each(g_params, function(id, value) {
        //console.log("id =", id, ", value =", value);
    });
};

var cfnCheckParam = function(param) {
    if (param.srchEndDate1 && isNotEmpty(param.srchEndDate1)) param.srchEndDate1 = param.srchEndDate1 + " 23:59:59.999";
    if (param.srchEndDate2 && isNotEmpty(param.srchEndDate2)) param.srchEndDate2 = param.srchEndDate2 + " 23:59:59.999";
    if (param.srchEndDate2 && isNotEmpty(param.srchEndDate2)) param.srchEndDate2 = param.srchEndDate2 + " 23:59:59.999";
    return param;
};

var cfnChangeMode = function(options) {
    'use strict';
    var mode = options.mode || 'display'; // display, modify
    var excludes = options.excludes || []; // display.. 제외 대상
    var includes = options.includes || []; // modify.. readonly 처리 대상

    //console.log('excludes', excludes);
    if (mode === 'display') {
        $(':input').each(function() {// input
            var type = $(this).attr('type');
            var tag = $(this).prop('tagName');
            var index = jQuery.inArray($(this).attr('id'), excludes);
            if (0 > index) {
                if (!(type && tag === "INPUT" && type.toUpperCase() === 'HIDDEN')) {
                    // 공통 처리
                    $(this).attr('readonly', true);
                    $(this).removeClass('req_input');
                    $(this).addClass('inputView');
                    // datepicker 클래스가 있는지 체크하여 제거한다.
                    if (type) {
                        if (type.toUpperCase() === 'RADIO') {// 라디오버튼 일때
                            //console.log("RADIO");
                            $(this).hide();
                            if (!$(this).is(':checked')) {try{$(this)[0].nextSibling.nodeValue = "";}catch(e){}}
                        } else if (type.toUpperCase() === 'CHECKBOX') {
                            //console.log("CHECKBOX");
                            $(this).hide();
                            if (!$(this).is(':checked')) {try{$(this)[0].nextSibling.nodeValue = "";}catch(e){}}
                        }
                    } else {
                        if (tag === "SELECT") {
                            //console.log("SELECT");
                            $(this).hide();
                            try {
                                if ("" !== $(this)[0].options[$(this)[0].selectedIndex].value) {
                                    $(this).after("&nbsp;&nbsp;" + $(this)[0].options[$(this)[0].selectedIndex].text);
                                }
                            } catch (e) {
                            }
                        } else if (tag === "TEXTAREA") {
                            //console.log("TEXTAREA");
                            //$(this).css('border', 'solid 1px #c6c6c6');
                        }
                    }
                }
            }
            //console.log('id =', $(this).attr('id'), ', index =', index, ', type =', $(this).attr('type'), ', tag =', $(this).prop('tagName'));
        });

        // file upload
        $('input[id$="_uploadFile"]').hide();
        $('.file-upload').hide();
        $('input[id$="_setReadOnlyFlag"]').val('Y');

        // datepicker
        $(".datepicker").each(function() {
            $(this).hide();
            $(this).after($(this).val());
        });
        $(".ui-datepicker-trigger").hide();

        // inline popup button
        $(".ibtn").each(function () {
            $(this).hide();
        });

        // auth-save button
        $(".auth").each(function () {
            var index = jQuery.inArray($(this).attr('id'), excludes);
            if (0 > index) {
                $(this).hide();
            }
        });
    } else {
        $(':input').each(function() {// input
            var type = $(this).attr('type');
            var tag = $(this).prop('tagName');
            var index = jQuery.inArray($(this).attr('id'), excludes);
            if (0 > index) {
                if (!(type && tag === "INPUT" && type.toUpperCase() === 'HIDDEN')) {
                    // 공통 처리
                    $(this).attr('disabled', false);
                    $(this).attr('readonly', false);
                    $(this).removeClass('inputView');
                    if (type) {
                        if (type.toUpperCase() === 'RADIO') {// 라디오버튼 일때
                            //console.log("RADIO");
                        } else if (type.toUpperCase() === 'CHECKBOX') {
                            //console.log("CHECKBOX");
                        }
                    } else {
                        if (tag === "SELECT") {
                            //console.log("SELECT");
                        } else if (tag === "TEXTAREA") {
                            //console.log("TEXTAREA");
                            //$(this).css('border', 'solid 1px #c6c6c6');
                        }
                    }
                }
            } else { //excludes
                $(this).attr('disabled', false);
                $(this).attr('readonly', true);
                $(this).addClass('readonly');
            }
            //console.log('id =', $(this).attr('id'), ', index =', index, ', type =', $(this).attr('type'), ', tag =', $(this).prop('tagName'));
        });
    } 
};


//트리 텍스트 검색
var cfnSearchTree = function(treeView, scrName) {
	var ret = treeView.getDataProvider().searchData({fields:["deptNm"], value:scrName, wrap:true});
	if (ret) {
	    var rowId = ret.dataRow;
	    var parents = treeView.getDataProvider().getAncestors(rowId);
	    if (parents) {
	        for (var i = parents.length - 1; i >= 0 ; i--) {
	            treeView.expand(treeView.getItemIndex(parents[i]));
	        }
	        treeView.setCurrent({itemIndex:treeView.getItemIndex(rowId), fieldIndex:ret.fieldIndex});
	    }
	}
};

/**
 * 콤보 Option 모두 제거
 */
var removeAllComboOption = function(objId) {
	$("#" + objId + " option").each(function() {
		$(this).remove();
	});
};

/**
 * 처번째 Option 제외하고 나머지 제거
 */
var removeAllComboOptionExcludeFirstCd = function(objId) {
	$("#" + objId + " option").each(function(idx) {
		if( idx != 0 ) {
			$(this).remove();
		}
	});
};

/**
 * 콤보 option 생성
 */
var fnMakeComboOption = function(objId, codeList, keyCol, valueCol, selectedValue, firstCode, firstValue) {
	
   if (isNotEmpty(codeList)) {

	   removeAllComboOption(objId);

	   if( firstCode != null || firstCode == "undefined") {
        	
		   $("#" + objId).append("<option value='" + firstCode + "' selected='selected' >" + firstValue + "</option>");
       }
        
       for ( var i = 0; i < codeList.length; i++) {
            var codeObj = codeList[i];
            
            var strKey = codeObj[keyCol];
            var strVal = codeObj[valueCol];
            /*
            if( isNotEmpty(keyCol)) {
            	strKey = codeObj[keyCol];
            }
            
            if( isNotEmpty(valueCol)) {
            	strVal = codeObj[valueCol];
            }
            */	
            if (strKey == selectedValue) {
            	$("#" + objId).append("<option value='" + strKey + "' selected='selected'>" + strVal + "</option>");
            } else {
            	$("#" + objId).append("<option value='" + strKey + "'>" + strVal + "</option>");
            }
        }
    } else {
    	removeAllComboOption(objId);
    	$("#" + objId).append("<option value='' selected='selected' >" + "전체" + "</option>");
    }
};



//grid dropdown 코드 설정
function fnSetGridDropdownValue(grid, colName, codeList, keyCol, valueCol, firstCode, firstValue) {
	
	//console.log( "fnSetGridDropdownValue");
	var localValues = new Array();
	var localLabels = new Array();
		
	if (isNotEmpty(codeList)) {

	   if( firstCode != null || firstCode == "undefined") {
        	
		   localValues.push(firstCode); 
		   localLabels.push(firstValue);
       }
        
       for ( var i = 0; i < codeList.length; i++) {
            var codeObj = codeList[i];
            
            //console.log( "fnSetGridDropdownValue codeObj =" + JSON.stringify( codeObj));
            var strKey = codeObj[keyCol];
            var strVal = codeObj[valueCol];

            localValues.push(strKey); 
 		   	localLabels.push(strVal);
        }
    }
	
	var column = grid.columnByName(colName);
	column.values = localValues;
	column.labels = localLabels;
	grid.setColumn(column);
}

//숫자로 변환
function fnToNumber(value) {
	var retVal = Number( value);
	
	if( isNaN( retVal) ) {
		return 0;
	}
	
	return retVal;
}

//절사 
function fnFloor( value, precision ) {
	
	var retVal = value;

	if( isNotEmpty( precision) ) {
		if( precision > 0 ) {
			retVal = Math.floor( fnToNumber(value) * Math.pow( 10, precision)) / Math.pow(10, precision);
		} else if ( precision == 0 ) {
			retVal = Math.floor( fnToNumber(value));
		} else {
			retVal = Math.floor( fnToNumber(value) / Math.pow( 10, Math.abs(precision))) * Math.pow(10, Math.abs(precision));
		}
	} else {
		retVal = Math.floor( fnToNumber(value));
	}
	return retVal;
}

//법인세 여부
function isCorpTax(fgTax) {
	var retVal = false;

	if( fgTax == '14' || fgTax == '15') {  // 14:영세(세금계산서), 15:영세(수출)
		retVal = true;
	}
	
	return retVal;
}

//원화 환산 금액 계산
function fnCalculExchangeAmt(cdExch, rtRate, exAmt) {
	
	var retVal = fnToNumber(exAmt) * fnToNumber(rtRate);

	if( isNotEmpty(cdExch) ) {
		if( cdExch == '002' || cdExch == 'JPY' || cdExch == 'IDR' || cdExch == 'VND' ) {
			retVal = retVal / 100;
		}
	} 	
	
	return retVal;
}

// 원화 -> 외화 
function fnCalculExchangeKRWAmt(cdExch, rtRate, amt) {
	
	var retVal = fnToNumber(amt) / fnToNumber(rtRate);

	if( isNotEmpty(cdExch) ) {
		if( cdExch == '002' || cdExch == 'JPY' || cdExch == 'IDR' || cdExch == 'VND' ) {
			retVal = retVal * 100;
		}
	} 	
	
	return retVal;
}

function pop_open_modal(obj,wid,hei){

	var dHeight = $(document).height();
	var dWidth = $(document).width();
	var sHeight = $(document).scrollTop();
	var objWidth = wid;
	
	$('<div class="popModal" style="position:fixed; top:40px;z-index:200000;"><p class="dragHandler" style="width:91%; height:38px; position:absolute; cursor:move"></p><iframe id="test" src="'+obj+'" width="'+wid+'" height="'+hei+'" frameborder="0"></iframe></div>').appendTo('body');
	$('body').append('<div class="popBg pngFix" style="background:url(/static/images/common/bg_modal.png) repeat left top;position:absolute;left:0;top:0;z-index:2000;"></div>');
	$('.popBg').css({ width: dWidth, height: dHeight });

	var wHeight = $(window).height();
	var posX = $('.popBg').width();
	var posY = $('.popBg').height();
	var posTop = sHeight + ((wHeight - hei) / 2); //(sHeight + wHeight / 2) - posY / 2;
	if(posTop < 50){posTop = 50};

	$('.popModal').show()
//	$('.popModal').css({top: '-1600px',zIndex:'5000',width:wid,height:hei});
	$('.popModal').css("left", (posX - wid) / 2)

	// 팝업장 드래그 엔 드롭
	$('.popModal').draggable({
		handle: "p.dragHandler",
		containment: "body", 
		scroll: false
	});
	
	// 팝업창 리사이징
	/*$("#test").load(function(){
		setTimeout(function(){
			var heiSize = $('#test').contents().find('#popWrap').height();
			heiSize = heiSize + 2;
			$("#test, .popModal").css("height",+heiSize);
			//console.log(heiSize);
		},300);
	});*/
	

} //모달팝업 오픈

function pop_close_modal(){
    $("body .popBg:last").css('background', 'none').remove();
    $('.popModal:last').remove();
} //모달팝업 닫기


//ORACLE NVL 기능
function nvl(str, defaultStr) {
	if(typeof str == "undefined" || str == null || str == "") {
		return defaultStr;
	} else {
		return str;
	}
}

//PRINT OPRION
function printOption() {
	var Dwidth  = parseInt(document.body.scrollWidth);
	var Dheight = parseInt(document.body.scrollHeight);
	
	var divEl = document.createElement("div");	//document안의 "div"의 객체,변수,메소드를
	divEl.style.position = "absolute";			//divEI에게 넘겨준다. 여기서 "div"는 popup창 body전체
	divEl.style.left = "50px";
	divEl.style.top = "150px";
	divEl.style.width = "100%";
	divEl.style.height = "100%";
	document.body.appendChild(divEl);			//appendChild : body에다가 divEI를 적용시키겠다
	
	window.resizeBy(Dwidth-divEl.offsetWidth, Dheight-divEl.offsetHeight); 
	document.body.removeChild(divEl); 
}

//숫자만 입력
function onlyNumberInput2( Ev ) {
	if (window.event) {// IE코드
		var code = window.event.keyCode;
	} else {// 타브라우저
		var code = Ev.which;
	}

	if ((code > 34 && code < 41) || (code > 47 && code < 58)
			|| (code > 95 && code < 106) || code == 8 || code == 9
			|| code == 13 || code == 46) {
		window.event.returnValue = true;
		return;
	}

	if (window.event) {
		window.event.returnValue = false;
	} else {
		Ev.preventDefault();
	}
}

function getLength2Bytes(chkstr) {
    var j, lng = 0;

    for (j=0; j<chkstr.length; j++){
        if (chkstr.charCodeAt(j) > 255){
            ++lng;
        }
		++lng;
    }

    return lng;
}

/**
 * 말풍선 기본 옵션 정의 함수
 * focus : 포커스인 이벤트 발생시 말풍선 표시
 * hover : 포커스인 일시 말풍선 표시 및 아웃일시 표시삭제
 * none : 기본적으로 표시 하지 않음
 * jQueryObject.poshytip('show'), jQueryObject.poshytip('hide') 로 표시 수동조절 
 */
var getPoshyOption = function(msg, showOpt) {
	if (isEmpty(showOpt)) {
		showOpt = "none";
	}
	
	var poshyOption = {
		content: msg,
		className: "tip-yellow",
		alignTo: "target",
		alignX: 'inner-left',
		showOn: showOpt, // none, hover, focus
		offsetY: 0
	}
	return poshyOption;
};


/**
 * input text 숫자만 입력받기  [ex : onkeydown="javascript:setOnlyNumber(this)"  ]
 */

var setOnlyNumber = function(obj){
	$(obj).keyup(function(){
        $(this).val($(this).val().replace(/[^0-9]/g,""));
   });
};

/**
 * 숫자형으로 캐스팅
 */
var toNumber = function(intObj) {
	if (isEmpty(intObj) == true) {
		return 0;
	} else {
		intObj = removeComma(intObj);
		if (isNaN(intObj) == true) {
			return 0;
		} else {
			return Number(intObj);
		}
	}
}

var setCheckbox = function(objId, checked) {
	document.getElementById(objId).checked = checked;
}




/**
 * 기본실행 이벤트 정의
 */
$(document).ready(function() {
	/**
	 * setOnlyNumber 함수 Class 정의버전
	 * 사용예) <input type="text" id="NON_PRICE_RATE" class="formNum"/>
	 */
	$(".formNum").keyup(function(){
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	});
	$(".telNum").keyup(function(){
		$(this).val($(this).val().replace(/[^0-9|-]/g,""));
	});
	$(".percentForm").keyup(function(){
		$(this).val($(this).val().replace(/[^0-9|.]/g,""));
	});
	
	/**
	 * setCommaFormat 함수 Class 정의버전
	 * 사용예) 총금액: <input type="text" id="AMT" class="onlyAmt"/>
	 */
	$(".formAmt").each(function() {
		setCommaFormat($(this).attr("id"));
	});
	
	//기본닫기 버튼 이벤트정의
	$(".close").on("click", function() {
		window.close();
	});
});



/* 숫자입력체크 숫자면 true */
var NumberChecked  = function (num) {
    var numCode;
    for (i = 0; i < num.length; i++) {
        numCode = num.charCodeAt(i);
        if (numCode <= 57 && numCode >= 48) {
            return true;
        } else {
            alert("숫자만 입력이 가능합니다.");
            return false;
        }
    }
}

//사업자 번호 체크
var BusinessNumber  = function (str) {                                                                                                                  
    // 사업자번호 오류검증                                                                                                                   
    // 아래 공식으로 계산후 10의 배수가 나오면 검증일치                                                                                      
    var num = new Array();                                                                                                                   
        num[0] = 1;                                                                                                                          
        num[1] = 3;                                                                                                                          
        num[2] = 7;                                                                                                                          
        num[3] = 1;                                                                                                                          
        num[4] = 3;                                                                                                                          
        num[5] = 7;                                                                                                                          
        num[6] = 1;                                                                                                                          
        num[7] = 3;                                                                                                                          
        num[8] = 5;                                                                                                                          
    var totalNumber = 0;                                                                                                                     
    var _num        = 0;                                                                                                                     
    for (i = 0; i < str.length-1; i++) {                                                                                                     
        _num = parseInt(str.charAt(i)) * num[i];                                                                                             
        _num = "" + _num;                                                                                                                    
        if (i < 8) {                                                                                                                         
            totalNumber = totalNumber + parseInt(_num.charAt(_num.length-1));                                                                
        } else {                                                                                                                             
            totalNumber = (_num.charAt(_num.length-2) == "") ? totalNumber + 0 : totalNumber + parseInt(_num.charAt(_num.length-2));         
            totalNumber = totalNumber + parseInt(_num.charAt(_num.length-1));                                                                
        }                                                                                                                                    
    }                                                                                                                                        
    totalNumber = totalNumber + parseInt(str.charAt(str.length-1));                                                                          
    var num1    = str.substring(0,3);                                                                                                        
    var num2    = str.substring(3,5);                                                                                                        
    var num3    = str.substring(5,10);                                                                                                       
    if (str == "") {                                                                                                                         
        alert("사업자번호를 입력하세요.");                                                                                                   
        return false;                                                                                                                        
    } else if (num1.length != 3 || num2.length != 2 || num3.length != 5) {                                                                   
        alert("유효하지 않은 사업자 번호입니다.");                                                                                           
        return false;                                                                                                                        
    } else if (!this.NumberChecked(str)) {                                                                                                   
        alert("유효하지 않은 사업자 번호입니다.");                                                                                           
        return false;                                                                                                                        
    } else if (totalNumber%10 != 0) {                                                                                                        
        alert("유효하지 않은 사업자 번호입니다.");                                                                                           
        return false;                                                                                                                        
    } else {                                                                                                                                 
        return true;                                                                                                                         
    }                                                                                                                                        
}                                                                                                                                            
	
//법인번호 검사
function checkCorNo(sRegNo) {
     var re = /-/g;
     sRegNo = sRegNo.replace('-', '');
     if (sRegNo.length != 13) {
           return false;
     }
     var arr_regno = sRegNo.split("");
     var arr_wt = new Array(1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2);
     var iSum_regno = 0;
     var iCheck_digit = 0;
     for (i = 0; i < 12; i++) {
           iSum_regno += eval(arr_regno[i]) * eval(arr_wt[i]);
     }
     iCheck_digit = 10 - (iSum_regno % 10);
     iCheck_digit = iCheck_digit % 10;
     if (iCheck_digit != arr_regno[12]) {
           return false;
     }
     return true;
}



/* 법인번호 체크 */                                                                                                                          
var CorporationNumber  = function (str) {                                                                                                          
    // 법인번호 오류검증 공식                                                                                                                
    // 법인번호에서 마지막 자리를 제외한                                                                                                     
    // 앞에 모든 자리수를 1과 2를 순차적으로 곱한다.                                                                                         
    // 예) 1234567890123                                                                                                                     
    //     ************                                                                                                                      
    //     121212121212                                                                                                                      
    //     각각 곱한 수를 모든 더하고 10으로 나눈 나머지 수를 구한다.                                                                        
    //     (각각더한수 % 10)                                                                                                                 
    //     나눈 나머지 수와 법인번호 마지막 번호가 일치하면 검증일치                                                                         
    var totalNumber = 0;                                                                                                                     
    var num = 0;                                                                                                                             
    for (i = 0; i < str.length-1; i++) {                                                                                                     
        if (((i + 1) % 2) == 0) {                                                                                                            
            num = parseInt(str.charAt(i)) * 2;                                                                                               
        } else {                                                                                                                             
            num = parseInt(str.charAt(i)) * 1;                                                                                               
        }                                                                                                                                    
        if (num > 0) {                                                                                                                       
            totalNumber = totalNumber + num;                                                                                                 
        }                                                                                                                                    
    }                                                                                                                                        
    totalNumber = (totalNumber%10 < 10) ? totalNumber%10 : 0;                                                                                
    if (str == "") {                                                                                                                         
        alert("법인번호를 입력하세요.");                                                                                                     
        return false;                                                                                                                        
    } else if (str.length != 13) {                                                                                                           
        alert("유효하지 않은 법인 번호입니다.");                                                                                             
        return false;                                                                                                                        
    } else if (!this.NumberChecked(str)) {                                                                                                   
        alert("유효하지 않은 법인 번호입니다.");                                                                                             
        return false;                                                                                                                        
    } else if (totalNumber != str.charAt(str.length-1)) {                                                                                    
        alert("유효하지 않은 법인 번호입니다.");                                                                                             
        return false;                                                                                                                        
    } else {                                                                                                                                 
        return true;                                                                                                                         
    }                                                                                                                                        
}     



//
// resize 기능 추가 김태헌
// 
//
function initView() {

	if($(".content").length > 0 || $(".popWrap").length > 0 ) contentsResize();

	$(window).on("resize", function() {
		contentsResize();
	});
}


function contentsResize(contentId) {
	//console.log( "contentsResize contentId =" + contentId);
	if (_dynamicResizeTarget != null && _dynamicResizeTarget.length > 0 ) {
		
		if($(".content").find(".contentBlock").length > 0 ) {
			try{
				customResize();
			} catch( e) {
			}
		} else {
		   	var $contents = null;
		   	
		   	var header_height = 0;
		   	var footer_height = 0;
		   	var extend_size = 0;
		   	if( contentId != undefined && contentId != null ) {
		   		$contents = $("#" + contentsId);
		   	} else { 
		   		
		   		if($(".content").length > 0 ) {
		   			$contents = $(".content");
		   			header_height = $(".header").height();
		   			extend_height = 120;
		   			
		   		} 
		   		else if($(".popCont").length > 0) {
		   			$contents = $(".popCont");
		   			header_height = $(".popHead").height();
		   			extend_height = 30;
		   		}
		   		
		   	}
		
		   	//console.log( "header_height = " + header_height);
		   	//console.log( "extend_height = " + extend_height);
		   	
		   	var $gridArea = $(".realGridArea");
		   	if( $gridArea.length > 0 ) {
		
				var body_height = $(window).height();
				//console.log( "body_height = " + body_height);
				var footer_height = 0
				if( $(".footer").length > 0 ) {
					footer_height = $(".footer").height();
					
					//console.log( "footer_height = " + footer_height);
				}
				var gridAreaHeight = body_height - header_height - footer_height - (($gridArea.offset() !== undefined ) ? $gridArea.offset().top : 0);
				//console.log( "gridAreaHeight = " + gridAreaHeight);
				
				gridAreaHeight += extend_height;
				
				//console.log( "gridAreaHeight = " + gridAreaHeight);
				$gridArea.css("height", gridAreaHeight);
				resizeGrid();
		   	}
		}
	}
}


function initViewHorizental(upRate) {
	if($(".content").length > 0 || $(".popCont").length > 0 ) contentsResizeHorizental(upRate);

	$(window).on("resize", function() {
		contentsResizeHorizental(upRate);

	});
}


function contentsResizeHorizental(upRate, contentId) {
	//console.log( "contentsResize contentId =" + contentId);
	if (_dynamicResizeTarget != null && _dynamicResizeTarget.length > 0 ) {
	   	var $contents = null;
	   	
	   	var header_height = 0;
	   	var footer_height = 0;
	   	var extend_size = 0;
	   	if( contentId != undefined && contentId != null ) {
	   		$contents = $("#" + contentsId);
	   	} else { 
	   		
	   		if($(".content").length > 0 ) {
	   			$contents = $(".content");
	   			header_height = $(".header").height();
	   			extend_height = 49;
	   		} 
	   	}
	
	   	var isResizeGrid = false;
	  	if($contents.find(".contentHorizentalBlock").length > 0 ) {
			var body_height = $(window).height();
			   	
			var footer_height = 0
			if( $(".footer").length > 0 ) {
				footer_height = $(".footer").height();
			}
			
			var $contentBlock = $contents.find(".contentHorizentalBlock").eq(0);
			var total_height = body_height - header_height - footer_height - (($contentBlock.offset() !== undefined ) ? $contentBlock.offset().top : 0);
			total_height += extend_height;
			
			var height1 = Math.ceil( total_height * ( upRate /100.0) );
			var height2 = total_height - height1;
			
			//console.log( "contentHorizentalBlock height1 = " + height1);
			//console.log( "contentHorizentalBlock height2 = " + height2);
			var blockHeight = [height1, height2];
			
			$contents.find(".contentHorizentalBlock").each(function(idx) {
				var obj = $(this);	
				var gridHeight = blockHeight[idx];
				
				var titleHeight = 0;
				if( obj.find(".sub_tit").length > 0 ) {
					titleHeight = 43;
				}
				//console.log( "contentHorizentalBlock titleHeight = " + titleHeight);
				gridHeight = gridHeight - titleHeight;
				//console.log( "contentHorizentalBlock gridHeight = " + gridHeight);
				if( obj.find(".realGridArea").length > 0 ) {
					obj.find(".realGridArea").css("height", gridHeight);
				}
			});
			
			isResizeGrid = true;
			//resizeGrid();
	  	}	

	  	if($contents.find(".contentBlock").length > 0 ) {

			var body_height = $(window).height();
			   	
			var footer_height = 0
			if( $(".footer").length > 0 ) {
				footer_height = $(".footer").height();
			}
			
			var $contentBlock = $contents.find(".contentBlock").eq(0);
			var total_height = body_height - header_height - footer_height - (($contentBlock.offset() !== undefined ) ? $contentBlock.offset().top : 0);
			total_height += extend_height;
			
			$contents.find(".contentBlock").each(function(idx) {
				var obj = $(this);	
				var gridHeight = total_height;
				
				var titleHeight = 0;
				if( obj.find(".sub_tit").length > 0 ) {
					titleHeight = obj.find(".sub_tit").outerHeight() + 7;

				}
				//console.log( "contentlBlock titleHeight = " + titleHeight);
				gridHeight = gridHeight - titleHeight;
				//console.log( "contentlBlock gridHeight = " + gridHeight);
				if( obj.find(".realGridArea").length > 0 ) {
					obj.find(".realGridArea").css("height", gridHeight);
				}
			});
			
			isResizeGrid = true;
	  	}
	  	
	  	if( isResizeGrid == true) {
	  		resizeGrid();
	  	}
	}
}

var dialogPopOpen = function(url, wid, hei){
	var dHeight = $(document).height();
	var dWidth = $(document).width();
	var sHeight = $(document).scrollTop();
	var objWidth = wid;
	
	
	$("<div id='dialog' class='dialog'></div>").appendTo('body');
	
	$("#dialog").dialog({
        autoOpen: false,
        resizable: true,
        modal : true,
        height:hei, //팝업 가로
        width: wid, //팝업 높이 
        close: function(){
        	$('.dialog:last').remove();
        },
    });
	
	 var jqxhr = $.get(url+"?G_MENU_CD="+$("#G_MENU_CD").val(), function(data) {
		 $("#dialog").append(data);
		 $(".ui-dialog-title").html($(".pop-head h2").text());
		 $(".pop-head").remove();
	 });
	
	$("#dialog").dialog().dialog("open");
}

var checkBroswer = function(){

    var agent = navigator.userAgent.toLowerCase(),
        name = navigator.appName,
        browser = '';
  
    // MS 계열 브라우저를 구분
    if(name === 'Microsoft Internet Explorer' || agent.indexOf('trident') > -1 || agent.indexOf('edge/') > -1) {
        browser = 'ie';
        if(name === 'Microsoft Internet Explorer') { // IE old version (IE 10 or Lower)
            agent = /msie ([0-9]{1,}[\.0-9]{0,})/.exec(agent);
            browser += parseInt(agent[1]);
        } else { // IE 11+
            if(agent.indexOf('trident') > -1) { // IE 11
                browser += 11;
            } else if(agent.indexOf('edge/') > -1) { // Edge
                browser = 'edge';
            }
        }
    } else if(agent.indexOf('safari') > -1) { // Chrome or Safari
        if(agent.indexOf('opr') > -1) { // Opera
            browser = 'opera';
        } else if(agent.indexOf('chrome') > -1) { // Chrome
            browser = 'chrome';
        } else { // Safari
            browser = 'safari';
        }
    } else if(agent.indexOf('firefox') > -1) { // Firefox
        browser = 'firefox';
    }

    return browser;
}

//json data의 key와 동일한 html element id의 값을 셋팅, span 태그 text처리 포함.
function fnSetElementVal(data){
	$.each(data, function(key, val) {
        if (isEmpty(val) == false) {
        	//radio 옵션
            if ($('input:radio[name="'+key+'"]').length){
            	$('input:radio[name="'+key+'"][value="' + val + '"]').prop("checked", true);
            }else{
            	//input,sapn
	            if ($("#"+key).length){
	                if ($("#"+key).prop('tagName') == 'SPAN'){
	                    $("#"+key).text(val);
	                }else{
	                    $("#"+key).val(val);
	                    if ($("#"+key+"_span").length){
	                        $("#"+key+"_span").text(val);
	                    }
	                    //if ($("#"+key).hasClass('phone')) {$("#"+key).change();}
	                }
	            }
            }
            
        }
    });
}
//strs : ','로 구분된 문자열
//search : 찾을 문자열
//
function isContains(strs, search){
	var arrStr = strs.split(',');
	for(var i=0; i < arrStr.length; i++){
		if (arrStr[i] == search){
			return true;
		}
	}
	return false;
}
//검색시작일,종료일 둘 다 입력여부 체크
//from - 시작일 object
//to - 종료 object
//name - 입력값명
//isBothRequired - 둘 다 필수입력 여부체크 (true,false)
function checkDateFromToParam(from, to, name, isBothRequired){
	if (isEmpty(from.val()) && !isEmpty(to.val())){
		alert(name+ ' 시작일을 입력하세요.');
		from.focus();
		return false;
	}
	if (!isEmpty(from.val()) && isEmpty(to.val())){
        alert(name+ ' 종료일을 입력하세요.');
        to.focus();
        return false;
    }
	if (isBothRequired){
		if (isEmpty(from.val()) && isEmpty(to.val()) ){
			alert(name + ' 입력하세요.');
			from.focus();
			return false;
		}
	}
	return true;
}

/**
 * 삭제전 체크(그리드의 데이터)
 * @param 그리드뷰, 체크된 데이터
 * @returns boolean
 */
function fnDeleteCheck(gridView) {
	
	var checkList = gridView.getCheckedItems(false);
	if( checkList.length == 0 ) {
	    alert("삭제 대상을 선택하셔야 합니다.");
	    return false;
	} else {
		if (confirm("삭제 하시겠습니까?")) {
			return true;
	    }
	}   
}

/**
 * 저장 전 체크
 * @param 그리드뷰, 필수 값 array
 * @returns boolean
 */
function fnSaveCheck(gridView, requiredVal, oneRowcheck) {
	
	var bValue = false;
	if (oneRowcheck == null || oneRowcheck == "undefined") {
		bValue = false;
	} else {
		bValue = oneRowcheck;
	}
	
	// 한개 행 체크만 가능한 경우
	if (bValue && gridView.getSelectedRows().length > 1) {
		alert("한 건씩만 처리가 가능합니다. 확인 후 다시 시도하십시오.");
		return false;		
	}
	
	if( gridView.getCheckedItems(false).length == 0 ) {
		alert("체크된 데이터가 없습니다.");
		return false;
	} else if(fnValidationCheck(gridView, gridView.getColumnNames(), requiredVal) == false){
		return false;
	} else {
		return true;
	}
}

/**
 * GRID 필수 체크
 * @param 그리드뷰, 컬럼 array, 필수 값 array
 * @returns boolean
 */
function fnValidationCheck(gridView, colArray, requiredVal) {
	
	for(var i = 0; i < requiredVal.length; i++){
		gridView.setColumnProperty(requiredVal[i], "required", true);	
	}
	
	for(var i = 0; i < colArray.length; i++){
		if(gridView.getColumnProperty(colArray[i], "required") == true){
			
			for (var checkRow=0 ; checkRow < gridView.getSelectedItems().length; checkRow++) {
				if(isEmpty(gridView.getValue(gridView.getSelectedItems()[0].itemIndex,colArray[i]))){
					alert(gridView.getColumnProperty(colArray[i], "header").text + "값은 필수 입니다.");
					for(var z = 0; z < requiredVal.length; z++){
						gridView.setColumnProperty(requiredVal[z], "required", false);	
					}
					gridView.setFocus();
					gridView.showEditor();
					return false;
				}
			}
		}
	}
	
	for(var i = 0; i < requiredVal.length; i++){
		gridView.setColumnProperty(requiredVal[i], "required", false);	
	}
	
	return true;
	
}

/**
 * 문자열을 Array형태로 변환
 * @param String형태의 콤보 데이터
 * @returns Array형태의 콤보 데이터
 */
function stringToArray(arraylist, attr01, attr02, attr03, attr04) {
	var sValue = arraylist;
	sValue = sValue.replace("[", "");
	sValue = sValue.replace("]", "");
	var temp = sValue.split("}, ");
	var tempValue = [];
	var retValue  = [];
	
	for (var i=0 ; i < temp.length; i++) {
		var rObj = temp[i];
		rObj = rObj.replace("{", "");
		rObj = rObj.replace("}", "");
		
		var temp1 = rObj.split(", ");
		
		var tObj = {};
		for (var j=0 ; j < temp1.length; j++) {
			var obj = temp1[j];
			var temp2 = obj.split("=");
			var keyCol = temp2[0];
			var valCol = temp2[1];
			
			tObj[keyCol] = valCol;
		}
		tempValue.push(tObj);
	}
	
	for (var i=0 ; i < tempValue.length; i++) {
		if(attr01 == null && attr02 == null && attr03 == null && attr04 == null){
			retValue.push(tempValue[i]);
		} else if(tempValue[i].ATTR01 == attr01 && attr02 == null && attr03 == null && attr04 == null){
			retValue.push(tempValue[i]);
		} else if(tempValue[i].ATTR01 == attr01 && tempValue[i].ATTR02 == attr02 && attr03 == null && attr04 == null){
			retValue.push(tempValue[i]);
		} else if(tempValue[i].ATTR01 == attr01 && tempValue[i].ATTR02 == attr02 && tempValue[i].ATTR03 == attr03 && attr04 == null){
			retValue.push(tempValue[i]);
		} else if(tempValue[i].ATTR01 == attr01 && tempValue[i].ATTR02 == attr02 && tempValue[i].ATTR03 == attr03 && tempValue[i].ATTR04 == attr04){
			retValue.push(tempValue[i]);
		}
		
	}
	
	return retValue;
}

/**
 * 문자열을 Array형태로 변환하여 콤보 값 세팅
 * @param String형태의 콤보 데이터
 * @returns Array형태의 콤보 데이터
 * ex) getComboSetCodes("${CODELIST_E102}", "CODE", "ALL", "ATTR01");
 */
function getComboSet(arraylist, gubn, attr01, attr02, attr03, attr04) {
	var retValue = new Array();
	
	if(isEmpty(attr01)){
		var tempArray = stringToArray(arraylist);
	} else if(isNotEmpty(attr01) && isNotEmpty(attr02) && isNotEmpty(attr03) && isNotEmpty(attr04)){
		var tempArray = stringToArray(arraylist, attr01, attr02, attr03, attr04);
	} else if(isNotEmpty(attr01) && isNotEmpty(attr02) && isNotEmpty(attr03)){
		var tempArray = stringToArray(arraylist, attr01, attr02, attr03);
	} else if(isNotEmpty(attr01) && isNotEmpty(attr02)){
		var tempArray = stringToArray(arraylist, attr01, attr02);
	} else if(isNotEmpty(attr01)){
		var tempArray = stringToArray(arraylist, attr01);
	}
	
	if(gubn == "CODE"){
		for(var i = 0; i < tempArray.length; i++){
			retValue.push(tempArray[i].CODE); 
		}
	} else if(gubn == "CODE_NM"){
		for(var i = 0; i < tempArray.length; i++){
			retValue.push(tempArray[i].CODE_NM); 
		}
	}
	
	return retValue;
}

/**
 * 버튼에 이벤트 생성
 * @param 전송받은 data
 * @returns
 */
function alertErrMsg(data) {
    if (typeof data.status != 'undefined' && 'SUCC' !== data.status) {
        alert(data.errMsg);
        return;
    }
}

/**
 * 버튼에 이벤트 생성
 * @param 
 * @returns
 */
function makeBtnClickEvent() {
	
	var tempArray = new Array();
	tempArray = document.getElementsByTagName("button");
	
	for (var i=0; i < tempArray.length; i++) {
		if (tempArray[i].hasAttribute('id')) {
			eval("$('#" + tempArray[i].getAttribute('id') + "').click(function(e){ fn" + tempArray[i].getAttribute('id').substring(3) + "(); });");
		}
	}
	
	var tempArray2 = new Array();
	tempArray2 = document.getElementsByClassName('bbtn');	
	
	for (var j=0; j < tempArray2.length; j++) {
		if (tempArray2[j].hasAttribute('id')) {
			if (tempArray2[j].getAttribute('id').substring(0,3) == "btn") {
				eval("$('#" + tempArray2[j].getAttribute('id') + "').click(function(e){ fn" + tempArray2[j].getAttribute('id').substring(3) + "(); });");
			}
		}
	}	
	
	eval('$("input[type=\'text\']").keydown(function(e){ if (e.keyCode == 13 ) {fnSearch(); } });');
}

/**
 * 컴포넌트 값 초기화 (input 형태의 데이터)
 * @param 
 * @returns
 */
function setClearValue(targetList) {
	for (var i=0; i < targetList.length; i++) {
		eval("$('#" + targetList[i] + "').val('');");
	}
}

/**
 * td tag 값 초기화
 * @param 
 * @returns
 */
function setClearHtml(targetList) {
	for (var i=0; i < targetList.length; i++) {
		eval("$('#" + targetList[i] + "').html('');");
	}
}

/**
 * 콤보 셀렉션 처리
 * @param 
 * @returns
 */
function setSelectedCombo(targetList) {
	for (var i=0; i < targetList.length; i++) {
		eval('$("select[name=\'' + targetList[i] + '\']").find("option:eq(0)").prop("selected", true);');
	}
}


/**
 * 컴포넌트 값 SETTING (input 형태의 데이터)
 * @param 
 * @returns
 */
function setAllCompValue(obj, targetList) {
	
	if (targetList == null || targetList == "undefined") {
		Object.keys(obj).forEach(function (key) {
			eval("$('#" + key + "').val(obj." + key + ");");
		});
	} else {
		for (var i=0; i < targetList.length; i++) {
			eval("$('#" + targetList[i] + "').val(obj." + targetList[i] + ");");
		}		
	}

}

/**
 * 부모창의 function 호출
 * @param functionId, params, popupClose(default ture)
 * @returns
 */
function parentCallback(functionId, params, popupClose) {
    
    var cbFunc = 'opener.' + functionId;
    if ('function' === typeof(eval(cbFunc))) {
    	if (params == null || params == "undefined") {
    		try{ eval(cbFunc).call(); }catch(e){}
    	} else {
    		try{ eval(cbFunc).call(this, params); }catch(e){}
    	}
    }
    
    var pClose = booleanCheck(popupClose, true)
    if (pClose) {
    	window.close();
    }
    
}

/**
 * 체크된 데이터 추출(저장 시)
 * @param grid
 * @returns
 */
function fnGetSaveData(grid) {
	var checkedRows = grid.getCheckedItems(false);
	//console.log( "checkedRows = " + JSON.stringify(checkedRows));
    var jData;
	var jInsertData = [];
	var jUpdateData = [];
	var jResponse = {};
	var isDataExist = false;
	
	if (checkedRows.length > 0) {
		checkedRows.forEach(function (i){
			var rowId = grid.getValues(i).__rowId;
			jData = grid._dataSource.getOutputRow({datetimeFormat: "yyyyMMdd"}, rowId);
			
			jData.rowId = rowId;
			jData.itemIndex = i;
			
			if (jData.CRUD == 'R') {
				jData.state = 'updated';
				jUpdateData.push(jData);
			} else if (jData.CRUD == 'I') {
				jData.state = 'created';
				jInsertData.push(jData);
			}
		});
		$.extend(jResponse, {"UPDATED":jUpdateData});
		$.extend(jResponse, {"CREATED":jInsertData});
		isDataExist = true;
	}
	
	if (isDataExist) {
		return jResponse;
	} else {
		return null;	
	}
}

/**
 * 체크된 데이터 추출(저장 시)
 * @param grid
 * @returns
 */
function fnGetSaveAllData(grid) {
	var checkedRows = grid.getCheckedItems(false);
    var jData;
	var jAllData = [];
	var jResponse = {};
	var isDataExist = false;
	
	if (checkedRows.length > 0) {
		checkedRows.forEach(function (i){
			var rowId = grid.getValues(i).__rowId;
			jData = grid._dataSource.getOutputRow({datetimeFormat: "yyyyMMdd"}, rowId);
			
			jData.rowId = rowId;
			jData.itemIndex = i;
			
			if (jData.CRUD == 'R') {
				jData.state = 'updated';
			} else if (jData.CRUD == 'I') {
				jData.state = 'created';
			}			
			jAllData.push(jData);	
		});
		$.extend(jResponse, {"ALLDATA":jAllData});
		isDataExist = true;
	}
	
	if (isDataExist) {
		return jResponse;
	} else {
		return null;	
	}
}

/**
 * 체크된 데이터 추출(팝업 전달시)
 * @param grid
 * @returns
 */
function fnGetGridCheckSendPopupData(grid) {
	var checkedRows = grid.getCheckedItems(false);
	//console.log( "checkedRows = " + JSON.stringify(checkedRows));
    var jData;
	var jUpdateData = [];
	var jResponse = {};
	
	if (checkedRows.length > 0) {
		checkedRows.forEach(function (i){
			var rowId = grid.getValues(i).__rowId;
			jData = grid._dataSource.getOutputRow({datetimeFormat: "yyyyMMdd"}, rowId);
			
			jData.rowId = rowId;
			jData.itemIndex = i;
			
			if (jData.CRUD == 'R') {
				jData.state = 'updated';
			} else if (jData.CRUD == 'I') {
				jData.state = 'created';
			}			
			jUpdateData.push(jData);			
			
		});
		$.extend(jResponse, {"CHECK_LIST":JSON.stringify(jUpdateData)});
	}
	
	return jResponse;
}

/**
 * 체크된 데이터 추출후 저장시 사용
 * @param grid
 * @returns
 */
function fnGetGridCheckData(grid) {
	var checkedRows = grid.getCheckedItems(false);
	//console.log( "checkedRows = " + JSON.stringify(checkedRows));
    var jData;
	var jUpdateData = [];
	var jResponse = {};
	
	if (checkedRows.length > 0) {
		checkedRows.forEach(function (i){
			var rowId = grid.getValues(i).__rowId;
			jData = grid._dataSource.getOutputRow({datetimeFormat: "yyyyMMdd"}, rowId);
			
			jData.rowId = rowId;
			jData.itemIndex = i;
			
			if (jData.CRUD == 'R') {
				jData.state = 'updated';
			} else if (jData.CRUD == 'I') {
				jData.state = 'created';
			}			
			jUpdateData.push(jData);			
			
		});
		$.extend(jResponse, {"CHECK_LIST":jUpdateData});
	}
	
	return jResponse;
}

/**
 * 체크된 데이터 추출(삭제 시)
 * @param grid
 * @returns
 */
function fnGetDeleteData(grid) {
	
	// 신규 행추가는 삭제처리
	fnAddRowDelete(grid);
	
	var checkedRows = grid.getCheckedItems();
	//console.log( "checkedRows = " + JSON.stringify(checkedRows));
    var jData;
	var jDeleteData = [];
	var jResponse = {};
	var isDataExist = false;
	
	if (checkedRows.length > 0) {
		checkedRows.forEach(function (i){
			var rowId = grid.getValues(i).__rowId;
			jData = grid._dataSource.getOutputRow({datetimeFormat: "yyyyMMdd"}, rowId);
			
			jData.rowId = rowId;
			jData.itemIndex = i;
			
			jData.state = 'deleted';
			jDeleteData.push(jData);
		});
		$.extend(jResponse, {"DELETED":jDeleteData});
		isDataExist = true;
	}
	
	if (isDataExist) {
		return jResponse;
	} else {
		return null;	
	}
}

/**
 * 신규 행추가된 ROW 삭제
 * @param grid
 * @returns
 */
function fnAddRowDelete(grid) {
	var checkedRows = grid.getCheckedItems();
    var jData;
	if (checkedRows.length > 0) {
		for (var rowIndex = checkedRows.length-1; rowIndex > -1 ; rowIndex--) {
			var rowId = grid.getValues(checkedRows[rowIndex]).__rowId;
			jData = grid._dataSource.getOutputRow({datetimeFormat: "yyyyMMdd"}, rowId);
			
			if (jData.CRUD == 'I') {
				grid.deleteRow(rowId);
			}			
		}
	}
	
	grid.commit();
}

/*
* 비밀번호 유효성 검증
*
* @param uidObjId -
*            사용자 아이디 Object ID
* @param upwObjId -
*            입력된 비밀번호 Object ID
*/
var chkPwValidate = function(uidObjId, upwObjId) {

  var uid = $("#" + uidObjId).val();
  var upw = $("#" + upwObjId).val();

  if (/^(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/.test(upw) == false) {
      alert('비밀번호는 숫자와 영문자, 특수문자 조합으로 8자리 이상을 사용해야 합니다.');
      return false;
  }

  if (/(\w)\1\1\1/.test(upw)) {
      alert('비밀번호에 같은 문자를 4번 이상 사용하실 수 없습니다.');
      return false;
  }

  if (upw.search(uid) > -1) {
      alert('ID가 포함된 비밀번호는 사용하실 수 없습니다.');
      return false;
  }

  return true;
}

/**
 * 신규 행추가
 * @param
 * @returns
 */
function fnAddRow(grid, val, num, chk){
	if(num == null || num == "undefined"){
		num = 0;
	}
	
	if(val == null || val == "undefined"){
		val = {};
	}
	
	if(chk == null || chk == "undefined"){
		chk = true;
	}	
	
    grid.addRow(val);
    grid.checkItem(grid.getRowCount() - 1, chk);
    
    setTimeout(function() {
    	grid.setTopItem(grid.getRowCount());
    }, 100
);
    
}


/**
 * 그리드 로우 param Merge
 * @param
 * @returns
 */
function fnGetGridParams(gridView) {
	var curr = gridView.getCurrent();
	var params = {};
	
	for(var i = 0; i < gridView.getColumns().length; i++){
		params[gridView.getColumns()[i].name] = nvl(gridView.getValues(curr.itemIndex)[gridView.getColumns()[i].name],'');
	}
	
	return params;
}

/**
 * 그리드 로우 param Merge
 * @param
 * @returns
 */
function fnGetGridRowParams(gridView, rowIndex) {
	var params = {};
	
	for(var i = 0; i < gridView.getColumns().length; i++){
		params[gridView.getColumns()[i].name] = nvl(gridView.getValues(rowIndex)[gridView.getColumns()[i].name],'');
	}
	
	return params;
}

/**
 * 전화번호 검증 함수 
 * 휴대전화 / 일반전화 포함 
 */
var checkPhoneNumber = function(number) {
	var regExp = /^\d{3}-\d{3,4}-\d{4}$/;
	
	if (isEmpty(number)) {
		return false;
		
	} else if (!regExp.test(number)) {
		return false;
	}
	return true;
};

/**
 * 날짜 포맷 맞추기
 */
var getDiffMon = function(flag, cnt, delimiter) {
	return getMonFormatData(flag, cnt, delimiter);
}

/**
 * 날짜 포맷 맞추기
 */
var getMonFormatData = function(flag, cnt, delimiter) {
	if (delimiter == undefined) delimiter = "-";
	
	var dateObj = new Date();
	
	var y1 = dateObj.getFullYear();
	var m1 = dateObj.getMonth();
	
	if (flag == "y") {
		dateObj.setYear(y1 + cnt);
		
	} else if (flag == "m") {
		dateObj.setMonth(m1 + cnt);
		
	} 
	y1 = dateObj.getFullYear();
	m1 = dateObj.getMonth() + 1;
	
	return y1 + delimiter + this.formatLen(m1);
};

/**
 * 그리드 로우 editable false
 * @param
 * @returns
 */
function fnEditableFalse(grid) {
	for(var i = 0; i < grid.getColumns().length; i++){
		grid.setColumnProperty(grid.getColumns()[i].name, "editable", false);
	}
}

/**
 * 그리드 editable style
 * @param
 * @returns
 */
function fnEditableStyle(grid) {
	var colNames = grid.getColumnNames();
	for(var i = 0; i < colNames.length; i++){
	    if(grid.getColumnProperty(colNames[i],"editable")){
	    	grid.setColumnProperty(colNames[i],"styles",{background:"#d5e2f2"});
	    }
	}    	
}

/**
 *  지정된 소수점 자리수 이하 제거 
 * @param event
 */
function setTrunc (val, num) {
    var temp = val.split(".");
    if (temp[1] != null) {
        return setZeroToNull(temp[0] + "." +  temp[1].substring(0, num));
    } else {
        return setZeroToNull(val);
    }
}

/**
 *  숫자로 변경시 값이 0이면 공백으로 대체
 * @param event
 */
function setZeroToNull (val) {

	if (toNumber(val) == 0) {
		return '';
	} else {
		return val;
	}
}

/**
 *  arrayList에서 특정 컬럼의 값과 일치하는 index 추출 
 * @param event
 */
function getComboIndex (arr, col, val) {
	var resultIndex = -1;
	for (var i=0; i < arr.length; i++) {
		if (eval('arr['+ i + '].' + col) == val) {
			resultIndex = i;
			return resultIndex;
		}
	}
	
	return resultIndex;
}

/**
 *  arrayList에서 해당 index의 컬럼 값 추출 
 * @param event
 */
function getComboValue (arr, col, idx) {
	var resultValue;
	for (var i=0; i < arr.length; i++) {
		if (i == idx) {
			resultValue = eval('arr[' + i + '].' + col);
			return resultValue;
		}
	}
	
	return resultValue;
}

/**
 *  arrayList에서 해당 index 컬럼 값 셋팅 
 * @param event
 */
function setComboValue (arr, col, idx, val) {
	var resultValue;
	if (idx > -1) {
		for (var i=0; i < arr.length; i++) {
			if (i == idx) {
				eval('arr[' + idx + '].' + col + '=' + val);
				break;
			} else {
				continue;
			}
		}		
	}
}

function loading(){
	$(".loading-area").show();
}

function loadingEnd(){
	$(".loading-area").hide();
}

/**
 *   스타일 세팅
 * @param event
 */
function setDefaultStyle(grid, str, defaultStyle){
	for(var i = 0; i < grid.getColumns().length; i++){
		grid.setColumnProperty(grid.getColumns()[i].name, str, defaultStyle);
	}
} 


/**
 * 체크된 ROW 삭제
 * @param grid
 * @returns
 */
function fnCheckRowDelete(grid) {
	var checkedRows = grid.getCheckedItems();
    var jData;
	if (checkedRows.length > 0) {
		for (var rowIndex = checkedRows.length-1; rowIndex > -1 ; rowIndex--) {
			var rowId = grid.getValues(checkedRows[rowIndex]).__rowId;
			jData = grid._dataSource.getOutputRow({datetimeFormat: "yyyyMMdd"}, rowId);
			grid.deleteRow(rowId);
		}
	}
	
	grid.commit();
}

/**
 * 입력한 날짜의 달의 마지막날을 리턴
 */
var lastDayByMonth = function(toDate, delimiter) {
	if (delimiter == undefined) delimiter = "-";
	
	var arrDate1 = toDate.split("-");
	var dateObj = new Date();
	dateObj.setFullYear(parseInt(arrDate1[0]));
	dateObj.setMonth(parseInt(arrDate1[1]) - 1);
	dateObj.setDate(0);
	
	return dateObj.getFullYear() + delimiter + this.formatLen(dateObj.getMonth()+1) + delimiter + this.formatLen(dateObj.getDate());
}


/**
 * 필수 체크
 * @param 컬럼 array, 필수 값 array
 * @returns boolean
 */
function fnValidationCheckForm(requiredVal) {
	
	for(var i = 0; i < requiredVal.length; i++){
		if(isEmpty($("#"+requiredVal[i]).val())){
			alert($("#"+requiredVal[i])[0].name + " (은)는 필수입니다.");
			$("#"+requiredVal[i]).focus();
			return false;
		}
	}
	
	return true;
	
}

//팝업 로딩바
function popupLoading(opener) {
	if(opener){
    	var progressingDivHtml = 
            '<div class="loading-area">'
           +   '<div class="loading">' 
           +   '<strong>처리 진행중 입니다.</strong>' 
           +   '<p>잠시만 기다려주시기 바랍니다.</p>' 
           +   '</div>' 
           +'</div>'
           $(progressingDivHtml).appendTo('body');

	}
}

/**
 * 저장 전 체크
 * @param table 형태 필수 체크
 * @returns boolean
 */
function fnSaveCheckTable(requiredVal) {
	for(var i = 0; i < requiredVal.length; i++){
		if(isEmpty($("#"+requiredVal[i]).val())){
			alert($("#"+requiredVal[i] + "_H").text() + "은(는) 필수입력입니다.");
			return false;
		}
	}
	return true;
}

function fnSendMailSuccess(result) {
	
}

function fnSendMailFail(data) {
	
}

function fnGridSortFalse(grid){
	grid.setSortingOptions({enabled: false});
}