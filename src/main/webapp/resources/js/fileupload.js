/*
 * jQuery File Upload Plugin JS Example
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2010, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * https://opensource.org/licenses/MIT
 */

/* global $, window */

$(function () {
    'use strict';

    // Initialize the jQuery File Upload widget:
    $('#fileupload').fileupload({
        // Uncomment the following to send cross-domain cookies:
        //xhrFields: {withCredentials: true},
        url: 'upload/file.do'
    });

    // Enable iframe cross-domain access via redirect option:
    $('#fileupload').fileupload(
        'option',
        'redirect',
        window.location.href.replace(
            /\/[^\/]*$/,
            '/cors/result.html?%s'
        )
    );

    if (window.location.hostname === 'blueimp.github.io') {
        // Demo settings:
        $('#fileupload').fileupload('option', {
            url: '//jquery-file-upload.appspot.com/',
            // Enable image resizing, except for Android and Opera,
            // which actually support image resizing, but fail to
            // send Blob objects via XHR requests:
            disableImageResize: /Android(?!.*Chrome)|Opera/
                .test(window.navigator.userAgent),
            maxFileSize: 999000,
            acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i
        });
        // Upload server status check for browsers with CORS support:
        if ($.support.cors) {
            $.ajax({
                url: '//jquery-file-upload.appspot.com/',
                type: 'HEAD'
            }).fail(function () {
                $('<div class="alert alert-danger"/>')
                    .text('Upload server currently unavailable - ' +
                            new Date())
                    .appendTo('#fileupload');
            });
        }
    } else {
    	// Load existing files:
        $('#fileupload').fileupload('option', {
            acceptFileTypes: /(\.|\/)(bmp|gif|jpg|jpeg|png|pdf|xls|xlsx|xlsb|xps|ppt|pptx|doc|docx|hwp|txt|pdf|zip|htx|mht|msg)$/i
        });
        $('#fileupload').bind('fileuploaddone', function (e, data) {
        	if (data.result && data.result.APP_SEQ) {
        		$('#APP_SEQ').val(data.result.APP_SEQ);
        		processCallBack(data.result);
        	} else {
        		processCallBack(data.result);
        	}
        });
        $('#fileupload').bind('fileuploadadd', function (e, data) {
        	$(".th_test").hide();
        });
        $('#fileupload').bind('fileuploaddestroyed', function (e, data) {
        	//u_define_delete(data.appseq ,data.attachmentseq);
        	processCallBack(data);
        });
    	$('#fileupload').addClass('fileupload-processing');
        $.ajax({
            // Uncomment the following to send cross-domain cookies:
            //xhrFields: {withCredentials: true},
            url: $('#fileupload').fileupload('option', 'url'),
            dataType: 'json',
            async: false,
            context: $('#fileupload')[0]
        }).always(function () {
            $(this).removeClass('fileupload-processing');
        }).done(function (result) {
        	try {
	        	if (result.files.length > 0) {
	        		$(".th_test").hide();
	        	}
	            $(this).fileupload('option', 'done')
	                .call(this, $.Event('done'), {result: result});
        	} catch (e) {
        		console.log(e);
        	}
        });
    }
});
