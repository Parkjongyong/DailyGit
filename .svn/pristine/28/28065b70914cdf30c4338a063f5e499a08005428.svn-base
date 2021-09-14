<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<div class="pop-wrap" style="width:100%;"><!-- 팝업 크기에 맞게 조절 -->
    <div class="pop-head">
        <h2>파일업로드</h2>
    </div>
    <div class="pop-cont">
        <!-- The file upload form used as target for the file upload widget -->
        <form id="fileupload" action="upload/file.do" method="POST" enctype="multipart/form-data">
            <input type="hidden" id="APP_SEQ" name="APP_SEQ" value="${APP_SEQ}"/>
            <input type="hidden" id="APP_TYPE" name="APP_TYPE" value=""/>
            <input type="hidden" id="SEND_OUT_FLAG" name="SEND_OUT_FLAG" value="${SEND_OUT_FLAG}"/>
            <!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
            <div class="fileupload-buttonbar">
                <div class="fileupload-buttons">
                    <div class="sub-tit first">
                        <div class="left">
		                    <span class="fileinput-button">
		                        <span>파일추가</span>
		                        <input type="file" name="files[]" multiple />
		                    </span>
		                    <button type="submit" class="start">업로드</button>
		                    <button type="reset" class="cancel">업로드취소</button>
		                    <button type="button" class="delete">선택삭제</button>
		                    <input type="checkbox" class="toggle">
		                    <!-- The global file processing state -->
		                    <span class="fileupload-process"></span>
                        </div>
                    </div>
                </div>
                <!-- The global progress state -->
                <div class="fileupload-progress fade" style="display:none">
                    <!-- The global progress bar -->
                    <div class="progress" role="progressbar" aria-valuemin="0" aria-valuemax="100"></div>
                    <!-- The extended global progress state -->
                    <div class="progress-extended">&nbsp;</div>
                </div>
            </div>
            <!-- The table listing the files available for upload/download -->
            <table role="presentation" class="table-fileload">
                <tbody class="files">
                </tbody>
            </table>
        </form>
        <div>파일 업로드 공통 upload 가능파일 (bmp,gif,jpg,jpeg,png,pdf,xls,xlsx,xlsb,xps,ppt,pptx,doc,docx,hwp,txt,pdf,zip,htx,mht,msg)</div>
        
        <!-- The template to display files available for upload -->
        <script id="template-upload" type="text/x-tmpl">

{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-upload fade">
        <td>
            <div class="attach-box">
                <span class="preview"></span>
                <div class="attach">
                {% if (window.innerWidth > 480 || !o.options.loadImageFileTypes.test(file.type)) { %}
                    <p class="name">{%=file.name%}</p><span class="size">Processing...</span>
                {% } %}
                    <strong class="error"></strong>
                </div>
            </div>
        </td>
        <td class="t_right">
            {% if (!i && !o.options.autoUpload) { %}
                <button class="start" disabled>업로드</button>
            {% } %}
            {% if (!i) { %}
                <button class="cancel">업로드취소</button>
            {% } %}
        </td>
    </tr>
{% } %}
    </script>
        <!-- The template to display files available for download -->
        <script id="template-download" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-download fade">
        <td>
            <div class="attach">
            {% if (window.innerWidth > 480 || !file.thumbnailUrl) { %}
                <p class="name">
                    <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" {%=file.thumbnailUrl?'data-gallery':''%}>{%=file.name%}</a>
                </p><span class="size">{%=o.formatFileSize(file.size)%}</span>
            {% } %}
            {% if (file.error) { %}
               <span class="error">Error</span> {%=file.error%}
            {% } %}
            </div>
        </td>
        <td class="t_right">
            <button class="delete" data-type="{%=file.deleteType%}" data-url="{%=file.deleteUrl%}"{% if (file.deleteWithCredentials) { %} data-xhr-fields='{"withCredentials":true}'{% } %}>삭제</button>
            <input type="checkbox" name="delete" value="1" class="toggle">
        </td>
    </tr>
{% } %}
        </script>
        <script src="/resources/js/jquery-3.2.1.min.js"></script>
        <script src="/resources/plugin/jquery-ui-1.12.1/jquery-ui.min.js"></script>
        <!-- The Templates plugin is included to render the upload/download listings -->
        <script src="/resources/js/blueimp.tmpl.min.js"></script>
        <!-- The Load Image plugin is included for the preview images and image resizing functionality -->
        <script src="/resources/js/blueimp.load-image.all.min.js"></script>
        <!-- The Canvas to Blob plugin is included for image resizing functionality -->
        <script src="/resources/js/blueimp.canvas-to-blob.min.js"></script>
        <!-- blueimp Gallery script -->
        <script src="/resources/js/blueimp-gallery.min.js"></script>
        <!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
        <script src="/resources/plugin/jQuery-File-Upload-master/js/jquery.iframe-transport.js"></script>
        <!-- The basic File Upload plugin -->
        <script src="/resources/plugin/jQuery-File-Upload-master/js/jquery.fileupload.js"></script>
        <!-- The File Upload processing plugin -->
        <script src="/resources/plugin/jQuery-File-Upload-master/js/jquery.fileupload-process.js"></script>
        <!-- The File Upload image preview & resize plugin -->
        <script src="/resources/plugin/jQuery-File-Upload-master/js/jquery.fileupload-image.js"></script>
        <!-- The File Upload audio preview plugin -->
        <script src="/resources/plugin/jQuery-File-Upload-master/js/jquery.fileupload-audio.js"></script>
        <!-- The File Upload video preview plugin -->
        <script src="/resources/plugin/jQuery-File-Upload-master/js/jquery.fileupload-video.js"></script>
        <!-- The File Upload validation plugin -->
        <script src="/resources/plugin/jQuery-File-Upload-master/js/jquery.fileupload-validate.js"></script>
        <!-- The File Upload user interface plugin -->
        <script src="/resources/plugin/jQuery-File-Upload-master/js/jquery.fileupload-ui.js"></script>
        <!-- The File Upload jQuery UI plugin -->
        <script src="/resources/plugin/jQuery-File-Upload-master/js/jquery.fileupload-jquery-ui.js"></script>
        <!-- The main application script -->
        <script src="/resources/js/fileupload.js"></script>
        <script>
          var console = window.console || {log: function() {}};
          jQuery.ajaxSetup({cache:false});
          jQuery.ajaxSetup({
            data: {APP_SEQ:"${APP_SEQ}"},
          });
        
          $(function () {
        	  var strUrl = window.opener.document.URL.split(".do");
        	  strUrl = strUrl[0].split("/");
        	  
        	  $('#APP_TYPE').val(strUrl[strUrl.length - 1]);
        	  
        	  $('.button').click(function(e) {
        		  e.preventDefault();
        	  });
            
        	  var $appSeq = $('#APP_SEQ');
        	  if ($appSeq.val() === "undefined" || $.trim($appSeq.val()) === "") {
        		  ajaxJsonCall(
        				  'upload/keygen.do'
        				  , {}
        				  , function (data) {
        					  $appSeq.val(data["fields"]["APP_SEQ"]);
        				  });
        	  }
          });
          
          var u_define_delete = function (appSeq,attachmentSeq) {
            
        	  $.ajax({
        		  url:"${pageContext.request.contextPath}/delete.do",
        		  type:'GET',
        		  //data:JSON.stringify({APP_SEQ:$("#${formName}_fileMngKey").val(),fileSeq:1}),
        		  data:{APP_SEQ:appSeq,ATTACHMENT_SEQ:attachmentSeq},
        		  async:false,
        		  contentType:'application/json;charset=UTF-8',
        		  dataType:'json',
        		  success: function () {
        		  }
        	  });
          };
        
          function processCallBack(result) {
        	  var callback    = "${CALLBACK}";
        	  var dataFormat  = "${DATA_FORMAT}";
        	  var keyId       = "${KEY_ID}";
        	  var tableId       = "${TABLE_ID}";
        	  
        	  var fnCallBack = ''
        	  if (callback !== '' && opener && opener.window) fnCallBack = opener.window[callback];
        
        	  if (result.result=="fail") {
        		  var errMsg = result.err_msg;
                
        		  if (errMsg=="common") {
        			  errMsg = "파일등록중 오류가 발생하였습니다.\n파일이 등록되지 못했습니다.";
        		  }
                
        		  alert(errMsg);
        		  return;
        	  }
            
        	  if (!result.type) {
        		  if (opener) {
        			  var obj = $("#" + keyId, opener.document);
        			  if (obj) {
        				  obj.val(result.APP_SEQ);
        			  }
        		  }
        	  }
            
        	  if (fnCallBack) {
        		  var data;
        		  if ("table" === dataFormat) {
        			  data = $('#presentation').html();
        		  } else if ("raw" === dataFormat) {
        			  if (!result.type) data = result.files;
        			  else data = result.type;
        		  }
        		  fnCallBack(data, keyId, tableId);
        	  }
          }
        
          /**
           * ajax post통신
           */
          var ajaxJsonCall = function(url, param, successCallback, errorCallback) {
        	  $.ajax({
        		  type : 'POST',
        		  url : url,
        		  //contentType : "application/json; charset=utf-8",
        		  data : param,
        		  dataType : 'json',
        		  cache: false,
        		  async: false,
        		  success : function(data) {
        			  //console.log('ajaxJsonCall.success:', data);
        			  try {
        				  if (data) {
        					  if (data["status"] == "SUCC") {
        						  successCallback(data);
        					  } else {
        						  alert(data["ERR_MSG"]);
        					  }
        				  }
        			  } catch (e) {
        				  alert(e.message);
        			  }
        		  },
        		  error : function(xhr, status, error) {
        			  //console.log('ajaxJsonCall.error:', xhr, status, error);
        			  if (401 === xhr.status) {
        				  alert('401 오류');
        				  location.href = "<s:url value='/login'/>";
        			  } else {
        				  errorCallback(xhr, status, error)
        			  }
        		  }
        	  });
          };
        
          var errorCallback = function() {
        	  alert("서버와의 연결이 해지되었습니다.");
          };
        
        </script>
        
        <!-- The XDomainRequest Transport is included for cross-domain file deletion for IE 8 and IE 9 -->
        <!--[if (gte IE 8)&(lt IE 10)]>
        <script src="/resources/plugin/jQuery-File-Upload-master/js/cors/jquery.xdr-transport.js"></script>
        <![endif]-->
        </div> <!-- popCont -->
    </div> <!-- popWrap -->