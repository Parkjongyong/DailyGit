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

var errorCallback = function() {
  alert("서버와의 연결이 해지되었습니다.");
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
