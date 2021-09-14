<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form id="${formName}" name="${formName}" method="POST">
    <input type="hidden" id="${formName}_appSeq" name="appSeq" size="30" value="${APP_SEQ}"/>
    <input type="hidden" id="${formName}_fileName" name="fileName" size="20" value="${FILE_NAME}"/>
    <input type="hidden" id="${formName}_oldAppSeq" name="oldAppSeq" size="10"/>
    <input type="hidden" id="${formName}_setReadOnlyFlag" name="setReadOnlyFlag" value="${READ_ONLY}" />
    <input type="hidden" id="${formName}_singleFlie" name="singleFile" value="Y" />
    
<%--     <input id="${formName}_uploadFile" placeholder="선택된 파일" disabled="disabled" size="30" /> --%>
    <div id="${formName}_uploadDiv" class="file-upload tBtn btn-primary">
<!--         <span>파일추가</span> -->
<%--         <input id="${formName}_uploadBtn" name="files[]" type="file" class="upload" /> --%>
        
        <span class="fileinput-button ui-button ui-corner-all ui-widget" role="button">
        <span class="ui-button-icon ui-icon ui-icon-plusthick"></span>
        <span class="ui-button-icon-space"></span>
        <span>파일추가</span>
            <input id="${formName}_uploadBtn" type="file" name="files[]" multiple />
        </span>
        
    </div>
    <div id="${formName}_fileInfo"></div>
</form>
<script>
    $(function(){
        var frm=$('#${formName}');
            
        frm.ajaxForm({
            url:"${pageContext.request.contextPath}/upload/singlefile.do"
            ,enctype:"multipart/form-data"
            ,success:function(result, state){
                ${formName}_FileuploadCallback(result, state);
            }
        });
        
        if (""!=$("#${formName}_fileName").val() || "Y" == "<c:out value='${READ_ONLY}' />" ) {
            $("#${formName}_uploadFile").hide();
            $("#${formName}_uploadDiv").hide();

            ${formName}_btnShowHide();
        }
    });
    
    var ${formName}_display = function(appSeq) {
        
        $("#${formName}_appSeq").val(appSeq);
        $.ajax({
            type:'GET',
            url:"${pageContext.request.contextPath}/upload/file.do",
            data:{APP_SEQ:appSeq},
            dataType : 'json',
            cache: false,
            success : function(result) {
                for(var i in result.files) {
                    
                    $("#${formName}_fileName").val(result.files[i].name);
                }
                ${formName}_btnShowHide();
            }
        });
    }

    var ${formName}_reset = function () {
        $("#${formName}_appSeq").val("");
        $("#${formName}_fileName").val("");
        $("#${formName}_oldAppSeq").val("");
        $("#${paramMap.RESPONSE_PARAM_ID}").val("");
        $("#${formName}_fileInfo").empty();
        $("#${formName}_uploadFile").show();
        $("#${formName}_uploadDiv").show();
    };

    $("#${formName}_uploadBtn").on('change', function() {
        var fileValue = this.value.split("\\");
        var fileName = fileValue[fileValue.length-1].split("."); // 파일명
        
        var fileExt = fileName[fileName.length-1];
    
        var acceptFileTypes = "bmp|gif|jpg|jpeg|png|pdf|xls|xlsx|xlsb|xps|ppt|pptx|doc|docx|hwp|txt|pdf|zip|htx|mht|msg";
        
        if (acceptFileTypes.indexOf(fileExt)<0) {
            alert("허용되지 않은 확장자 입니다.\n\n업로드 가능 확장자\n================================\nbmp,gif,jpg,jpeg,png,pdf,xls,xlsx,xlsb,xps,ppt,pptx,doc,docx,hwp,txt,pdf,zip,htx,mht,msg ");
            return;
        }
        
        $("#${formName}_uploadFile").val(this.value);

        $("#${formName}").submit();
    });

    var ${formName}_FileuploadCallback = function (result,state) {
        if (result=="error"){
            var addMsg = "첨부 가능한 파일 확장자는 아래와 같습니다.\nbmp,gif,jpg,jpeg,png,pdf,xls,xlsx,xlsb,xps,ppt,pptx,doc,docx,hwp,txt,pdf,zip,msg"
            alert("파일등록중 오류가 발생하였습니다.\n파일이 등록되지 못했습니다.\n\n"+addMsg);
            return false;
        }
        var parsedResult = jQuery.parseJSON(result.replace(/<\/?pre>/ig, '')) //tmp.appSeq
        $("#${formName}_appSeq").val(parsedResult.APP_SEQ);
        $("#${formName}_fileName").val(parsedResult.files[0].name);
        $("#${paramMap.RESPONSE_PARAM_ID}").val(parsedResult.APP_SEQ);

        $("#${formName}_imgLoading").attr("src" , "");

        ${formName}_btnShowHide();

        if (""!="${paramMap.CALL_BACK_FUNC}") {
            ${paramMap.CALL_BACK_FUNC}(result);
        }

        $("#${formName}_uploadBtn").replaceWith($("#${formName}_uploadBtn").clone(true));
        $("#${formName}_uploadFile").val("");

    };

    var ${formName}_btnShowHide = function () {
        
        $("#${formName}_uploadFile").hide();
        $("#${formName}_uploadDiv").hide();

        $("#${formName}_fileInfo").empty();

        var delUrl = "javascript:oneFileDownload(\""+$("#${formName}_appSeq").val()+"\");";

        var t_fileName = $("#${formName}_fileName").val();
        t_fileName = t_fileName.replace(/&#39/g,"`");
        
        var tmpStr = "";
        
        tmpStr += "<a href='"+delUrl+"' title='파일명을 클릭하면 첨부파일을 다운받습니다.' style='color: blue'>"+t_fileName+"</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
        
        if ("Y"!=$("#${formName}_setReadOnlyFlag").val()) {
            tmpStr += "<button type='button' class='btn' onclick='javascript:${formName}_delete();'><em class='icon04'></em>삭제</button>";
        }
        
        $("#${formName}_fileInfo").append(tmpStr);
    }

    var ${formName}_submit = function () {
        if (""!=$("#${formName}_uploadBtn").val()) {
            $("#${formName}").submit();
        } else if (""!=$("#${formName}_oldAppSeq").val()) {
            $.ajax({
                url:'${pageContext.request.contextPath}/delete.do?APP_SEQ='+$("#${formName}_appSeq").val(),
                type:'GET',
                data:JSON.stringify({APP_SEQ:$("#${formName}_appSeq").val(),fileSeq:1}),
                async:false,
                contentType:'application/json;charset=UTF-8',
                dataType:'json',
                success: function () {
                    $("#${formName}_oldAppSeq").val("");
                }
            });
        }
    };

    var ${formName}_delete = function () {
        if (!confirm("첨부파일을 삭제하시겠습니까?")) {
            return;
        } else { //JSON.stringify(params),
            if (""!=$("#${formName}_appSeq").val()) {
                $.ajax({
                    url:"${pageContext.request.contextPath}/download.do",
                    type:'DELETE',
                    //data:JSON.stringify({APP_SEQ:$("#${formName}_fileMngKey").val(),fileSeq:1}),
                    data:{APP_SEQ:$("#${formName}_appSeq").val()},
                    async:false,
                    contentType:'application/json;charset=UTF-8',
                    dataType:'json',
                    success: function () {
                        $("#${formName}_appSeq").val("");

                        $("#${formName}_fileName").val("");
                        $("#${paramMap.RESPONSE_PARAM_ID}").val("");

                        $("#${formName}_fileInfo").empty();

                        $("#${formName}_uploadFile").show();
                        $("#${formName}_uploadDiv").show();
                        $("#${formName}_uploadBtn").val("");
                    }
                });
            }
        }
    };
</script>
