
//layer popup
function layer_open(el) {
   $('#layer1, #layer2, #layer3, #layer4, #layer5, #layer6, #layer7, #layer8, #layer9, #layer10, #layer11, #layer12, #layer13, #layer14, #layer15, #layer16, #layer17, #layer18, #layer19, #layer20, #layer21').css('display', 'none'); //레이어 팝업 갯수
	var temp = $('#' + el);
	var bg = temp.parents('bg');
	if (bg) {
		$('.layer-wrap').fadeIn();
	} else {
		temp.fadeIn();
	}

	temp.css('display', 'block');
	if (temp.outerHeight() < $(document).height()) temp.css('margin-top', '-' + temp.outerHeight() / 2 + 'px');
	else temp.css('top', '0px');
	if (temp.outerWidth() < $(document).width()) temp.css('margin-left', '-' + temp.outerWidth() / 2 + 'px');
	else temp.css('left', '0px');

	$('.layer-wrap .bg').click(function (e) {
		$('.layer-wrap').fadeOut();
		e.preventDefault();
	});

	$('.login-close').click(function(){
		$('.layer-wrap').fadeOut();
	});
};




