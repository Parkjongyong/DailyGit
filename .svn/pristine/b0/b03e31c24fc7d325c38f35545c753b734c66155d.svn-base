$(function(){
	//tab
	$( ".tabs" ).tabs();	
	

	//팝업 링크 스크롤
	$(".page-link a").click(function(){
		$("html, body").animate({
			scrollTop: $( $.attr(this, "href") ).offset().top - 105
		}, 500);
		return false;
	});
	
	//탭
	$(".tab-content").hide();
	$(".tab-content:first").show();

	$("#tab-area li").click(function () {
		$("#tab-area li").removeClass("tab-on");
		$(this).addClass("tab-on");
		$(".tab-content").hide();
		var activeTab = $(this).attr("rel");
		
		$("#" + activeTab).fadeIn(function(){
			$(".info-box-tit a").hide();
			$("." + activeTab).show();
		});
	});
	
	$(".tabs-cont").hide();
	$(".tabs-cont:first").show();
	
	$(".new-tabs li a").on('click',function(){
	
		$(".new-tabs li a").removeClass("on");
		$(this).addClass("on");
		$(".tabs-cont").hide();
		var activeTabs = $(this).attr("rel");
		$("#" + activeTabs).fadeIn();
	
	});
	
	//jquery validator 
	$.validator.setDefaults({
	    onkeyup: false,
	    onclick: false,
	    onfocusout: false,
	    showErrors: function(errorMap,errorList){
	        if(this.numberOfInvalids()){ // 에러가 있으면
	            alert(errorList[0].message); // 경고창으로 띄움
	            errorList[0].element.focus();
	        }
	    }
	});
	
	//jquery validator 영문대문자만 사용가능 메소드
	$.validator.addMethod(
		    'uppercase', function (value, element) {
		        return this.optional(element) || /^[A-Z\s]+$/.test(value);
		    }, '영문대문자만 사용가능합니다.'
		);

	$.validator.addMethod(
		    'uppercaseNumBar', function (value, element) {
		        return this.optional(element) || /^[A-Z0-9-\s]+$/.test(value);
		    }, '영문대문자만,양의정수,-만사용가능합니다.'
		);

	$.validator.addMethod('lessThanEqual', function(value, element, param) {
	    if (this.optional(element)) return true;
	    var i = parseInt(value);
	    var j = parseInt($(param).val());
	    return i <= j;
	}, "입력값 {0}은 {1}보다 작거나 같아야 합니다.");

	
	$(function(){
		var preVal;
		$("input.upper").keyup(function(){
			var selStart = this.selectionStart;
			var selEnd = this.selectionEnd;
			$(this).val($(this).val().toUpperCase());
			this.selectionStart = selStart;
			this.selectionEnd = selEnd;
			
		}).blur(function(){
			$(this).val($(this).val().toUpperCase());
			if(preVal != $(this).val()) $(this).change();
			preVal = $(this).val();
		});
		
		$("input.number").number(true, 0, ".", "").keyup(function(){
			if($(this).val().indexOf("-") > -1)
				$(this).val(0);
		});
		
		$("input.double").number(true, 3, ".", "").keyup(function(){
			if($(this).val().indexOf("-") > -1)
				$(this).val(0);
		});
	});
	
	$(function(){
		
		$(".input-change").on("change keyup paste", function() {
			var oldVal;
		    var currentVal = $(this).val();
		    if(currentVal == oldVal) {
		        return;
		    }
		    
		    oldVal = currentVal;
		    return;
		    
		});
		
		$(".input-change").on("propertychange change keyup paste input", function() {
			var oldVal;
			var currentVal = $(this).val();
		    if(currentVal == oldVal) {
		        return;
		    }
		 
		    oldVal = currentVal;
		    
		    var index = 1;
		    $.each($(this).closest("td").find("input"),function(key, value){
		    	if(index == 1){
		    		this.value = "";
		    		return false;
		    	}
		    	
		    	index++;
		    });
		});
		
		$(".input-change2").on("change keyup paste", function() {
			var oldVal;
		    var currentVal = $(this).val();
		    if(currentVal == oldVal) {
		        return;
		    }
		    
		    oldVal = currentVal;
		    return;
		    
		});
		
		$(".input-change2").on("propertychange change keyup paste input", function() {
			var oldVal;
			var currentVal = $(this).val();
		    if(currentVal == oldVal) {
		        return;
		    }
		 
		    oldVal = currentVal;
		    
		    var index = 1;
		    $.each($(this).closest("td").find("input"),function(key, value){
		    	if(index == 2){
		    		this.value = "";
		    		return false;
		    	}
		    	
		    	index++;
		    });
		});
	});
	
	//사이트맵
	$('.top-menu .menu').on('click',function(){
		$(this).toggleClass('on');
		$('.sitemap-area').toggleClass('on');
		$('.sitemap-bg').toggleClass('on');
	});

});

/*
 * 첨부파일명만 리턴하는 함수
 */
function getAttachExcelFileName(full_path, target){
	
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
/*
 * 전자결재 호출
 */
function gfnSubmitApproval(params){
	
	var url = getContextPath() + "/wf/FromIPRO_ToWF_POP.do";
	
    var oHiddenFrame = $("#"+params["APRV_DOC_TYP" ] + "hiddenFrame");
    if(oHiddenFrame.length != 1){
        $("<iframe name='"+params["APRV_DOC_TYP" ] + "hiddenFrame"+"' id='"+params["APRV_DOC_TYP" ] + "hiddenFrame"+"' width='0' height='0'></iframe>").appendTo('body');
    }
	
    var oApprovalForm = $("#_CALL_WF_APPROVAL_");

    if(oApprovalForm.length != 1){
    	var formHtml = 
        '<form name="_CALL_WF_APPROVAL_" id="_CALL_WF_APPROVAL_" action="'+url+'" method = "post" target="'+params["APRV_DOC_TYP" ] + "hiddenFrame"+'" onsubmit="">'
       +   '<input type="hidden"  name="APRV_DOC_TYP"  value="'+ params["APRV_DOC_TYP" ]+'">' 
       +   '<input type="hidden"  name="APPROVALTITLE" value="'+ params["APPROVALTITLE"]+'">' 
       +   '<input type="hidden"  name="APPROVALKEY01" value="'+ params["APPROVALKEY01"]+'">' 
       +   '<input type="hidden"  name="APPROVALKEY02" value="'+ params["APPROVALKEY02"]+'">' 
       +   '<input type="hidden"  name="APPROVALKEY03" value="'+ params["APPROVALKEY03"]+'">' 
       +   '<input type="hidden"  name="CLOSEYN"       value="'+ params["CLOSEYN"]+'">'
       +'</form>'
       $(formHtml).appendTo('body');
    }else{
    	oApprovalForm.find("input[name=APRV_DOC_TYP]").val(params["APRV_DOC_TYP" ]);
    	oApprovalForm.find("input[name=APPROVALTITLE]").val(params["APPROVALTITLE" ]);
    	oApprovalForm.find("input[name=APPROVALKEY01]").val(params["APPROVALKEY01" ]);
    	oApprovalForm.find("input[name=APPROVALKEY02]").val(params["APPROVALKEY02" ]);
    	oApprovalForm.find("input[name=APPROVALKEY03]").val(params["APPROVALKEY03" ]);
    	oApprovalForm.find("input[name=CLOSEYN]").val(params["CLOSEYN" ]);
    }
    var oApprovalForm = $("#_CALL_WF_APPROVAL_");
    oApprovalForm.submit();
}


function gfnShowProgressing(){
	var oProgressingDiv = $(".loading-area");
	
	if(oProgressingDiv.length != 1){
    	var progressingDivHtml = 
            '<div class="loading-area">'
           +   '<div class="loading">' 
           +   '<strong>처리 진행중 입니다.</strong>' 
           +   '<p>잠시만 기다려주시기 바랍니다.</p>' 
           +   '</div>' 
           +'</div>'
           $(progressingDivHtml).appendTo('body');
		
	}else{
		oProgressingDiv.show();
	}
	
}

function gfnCloseProgressing(){
	var oProgressingDiv = $(".loading-area");
	oProgressingDiv.hide();
}


//일괄다운로드
function gfnMultipleDownload(pId){
	var fileList = $("#"+pId).find("a").toArray();
	downloadAll(fileList);
}

function downloadAll(pHrefList){  
   if(pHrefList.length == 0) return;
   
   var oFileLink = pHrefList.pop();
   
   var oMulitDownCheckbox = $(oFileLink).closest("tr").find("input:checkbox");
   if(oMulitDownCheckbox.length == 1){
	   if(oMulitDownCheckbox.prop("checked")) window.location = $(oFileLink).attr("href");
	   
   }else{
	   window.location = $(oFileLink).attr("href");
   }
   setTimeout(function() {
	   downloadAll(pHrefList);
	 }, 700);   
}  

function gfnCheckAll(pSourceName,pTargetName){
	$("input[name='"+pTargetName+"']").prop("checked",$("input[name='"+pSourceName+"']").prop("checked"));
}
function gfnLimitTextAreaCol(pTextAreaObj,pLimitLength){
	
    var value = $(pTextAreaObj).val();
    var reVal = "";
    var isOver = false;
    
    var rows = value.split('\n'); 
    for(var ii=0;ii<rows.length;ii++){
    	if(rows[ii].length>pLimitLength){
            reVal = reVal + rows[ii].substr(0,pLimitLength) + '\n';
            isOver = true;
    	}else{
    		reVal = reVal + rows[ii] + '\n';
    	}
    }
    if(isOver){
        $(pTextAreaObj).val(reVal);
        alert(pLimitLength + " 컬럼까지만 입력 가능합니다.");
    }
}


(function(global, $) {
    var $menu = $('.page-link a'),
        $contents = $('.scrolls'),
        $doc = $('html, body');
    $(function() {
        // 해당 섹션으로 스크롤 이동
        $menu.on('click', 'a', function(e) {
            var $target = $(this).parent(),
                idx = $target.index(),
                section = $contents.eq(idx),
                offsetTop = section.offset().top;
            $doc.stop()
                .animate({
                    scrollTop: offsetTop -105
                }, 300);
            return false;
        });
    });
    // menu class 추가
    $(window).scroll(function() {
        var scltop = $(window).scrollTop();
        $.each($contents, function(idx, item) {
            var $target = $contents.eq(idx),
                i = $target.index(),
                targetTop = $target.offset().top-200;
            if (targetTop <= scltop) {
                $menu.removeClass('on');
                $menu.eq(idx).addClass('on');
            }
            if (!(0 <= scltop)) {
                $menu.removeClass('on');
            }
        })
    });
}(window, window.jQuery));

function isValidDateC(param) {
    try {
        param = param.replace(/-/g,'');
        // 자리수가 맞지않을때
        if( isNaN(param) || param.length!=8 ) {
            return false;
        }
         
        var year = Number(param.substring(0, 4));
        var month = Number(param.substring(4, 6));
        var day = Number(param.substring(6, 8));

        var dd = day / 0;

         
        if( month<1 || month>12 ) {
            return false;
        }
         
        var maxDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        var maxDay = maxDaysInMonth[month-1];
         
        // 윤년 체크
        if( month==2 && ( year%4==0 && year%100!=0 || year%400==0 ) ) {
            maxDay = 29;
        }
         
        if( day<=0 || day>maxDay ) {
            return false;
        }
        return true;

    } catch (err) {
        return false;
    }                       
}

/*
 * grid : Grid Object
 * cols : Column List
 * prop : property
 * val : 속성값 
 */
var setGridColumnProperty = function(grid, cols, prop, val){
	if(isEmpty(grid) || isEmpty(cols) || isEmpty(prop) || isEmpty(val)){
		return false;
	}
	
	for(var i in cols){
		grid.setColumnProperty(cols[i], prop, val);
	}
};