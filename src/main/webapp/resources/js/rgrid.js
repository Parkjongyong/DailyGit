RealGridJS.setTrace(false);
RealGridJS.setRootContext(getContextPath() + "/resources/plugin/realgrid");

var g_gridList = [];

var globalStyle = 
{"grid": {
	"background":"#ff666666"
	,"paddingRight":"2"
	,"iconLocation":"left"
	//,"border":"#ff000000,1"
		,"border":"#ffbfbfbf,1"
	,"selectedForeground":"#ffffffff"
	,"iconAlignment":"center"
	,"foreground":"#ff000000"
	,"inactiveForeground":"#ff808080"
	,"iconOffset":"0"
	,"fontFamily":"Malgun Gothic"
	,"textAlignment":"near"
	,"selectedBackground":"#ff696969"
	,"lineAlignment":"center"
	,"inactiveBackground":"#ffd3d3d3"
	,"selectionDisplay":"mask"
	,"hoveredMaskBorder":"#335292f7,1"
	,"iconPadding":"2"
	,"hoveredMaskBackground":"#1f5292f7"
	,"fontSize":"12"
	,"contentFit":"auto"
	,"paddingTop":"2"
	,"figureBackground":"#ff000000"
	,"paddingBottom":"2"
	,"iconIndex":"0"}

	,"panel":{
		"background":"#ffd0d0d0"
		,"iconLocation":"left"
		,"border":"#88888888,0"
		,"iconAlignment":"center"
		,"borderBottom":"#ff969696,1"
		,"fontFamily":"Malgun Gothic"
		,"iconPadding":"2"
		,"selectedBackground":"#ff696969"
		,"contentFit":"auto"
		,"inactiveBackground":"#ffd3d3d3"
		,"iconOffset":"0"
		,"selectionDisplay":"mask"
		,"hoveredMaskBackground":"#1f5292f7"
		,"fontSize":"12"
		,"hoveredMaskBorder":"#335292f7,1"
		,"figureBackground":"#ff000000"
		,"paddingBottom":"5"
		,"paddingTop":"4"
		,"paddingRight":"2"
		,"selectedForeground":"#ffffffff"
		,"foreground":"#ff7d7d7d"
		,"inactiveForeground":"#ff808080"
		,"textAlignment":"near"
		,"lineAlignment":"center"
		,"borderRight":"#ff777777,0"
		,"iconIndex":"0"}
		
	,"body":{
		"background":"#ffffffff"
		,"iconLocation":"left"
		,"border":"#88888888,0"
		,"iconAlignment":"center"
		,"borderBottom":"#ffe5e5e5,1"
		,"fontFamily":"Malgun Gothic"
		,"borderTop":"#ff000000,0"
		,"selectedBackground":"#ff696969"
		,"contentFit":"auto"
		,"inactiveBackground":"#ffd3d3d3"
		,"iconOffset":"0"
		,"selectionDisplay":"mask"
		,"iconPadding":"2"
		,"hoveredMaskBackground":"#1f5292f7"
		,"fontSize":"12"
		,"hoveredMaskBorder":"#335292f7,1"
		,"figureBackground":"#ff000000"
		,"paddingBottom":"2"
		,"paddingTop":"2"
		,"paddingRight":"2"
		,"selectedForeground":"#ffffffff"
		,"foreground":"#ff5d5d5d"
		,"inactiveForeground":"#ff808080"
		,"line":"#ff696969,1"
		,"textAlignment":"near"
		,"lineAlignment":"center"
		,"borderRight":"#ffbfbfbf,1"
		,"iconIndex":"0"
			, "line": "#ffbfbfbf,1"
		,"empty":{
			"background":"#ffffffff"
			,"iconLocation":"left"
			,"border":"#88888888,0"
			,"iconAlignment":"center"
		
			,"borderBottom":"#ff999999,1"
			,"fontFamily":"Malgun Gothic"
			,"iconPadding":"2"
			,"selectedBackground":"#ff696969"
			,"contentFit":"auto"
			,"inactiveBackground":"#ffd3d3d3"
			,"iconOffset":"0"
			,"selectionDisplay":"mask"
			,"hoveredMaskBackground":"#1f5292f7"
			,"fontSize":"12"
			,"hoveredMaskBorder":"#335292f7,1"
			,"figureBackground":"#ff000000"
			,"paddingBottom":"2"
			,"paddingTop":"2"
			,"paddingRight":"2"
			,"selectedForeground":"#ffffffff"
			,"foreground":"#ff000000"
			,"inactiveForeground":"#ff808080"
			//,"textAlignment":"near"  <-- 수정
			//,"lineAlignment":"near"  <-- 수정
			,"borderRight":"#ff999999,1"
			,"iconIndex":"0"

			      , "textAlignment":"center"  // 추가
			      , "fontSize" : 15           // 추가
			      //, "fontBold" : true       // 추가
			}
		}
		
	,"fixed": {
        "background": "#ffd3d3d3",
        "paddingRight": "2",
        "iconLocation": "left",
        "border": "#88888888,1",
        "selectedForeground": "#ffffffff",
        "iconAlignment": "center",
        "foreground": "#ff000000",
        "inactiveForeground": "#ff808080",
        "borderBottom": "#ff999999,1",
        "textAlignment": "center",
        "selectedBackground": "#ff696969",
        "lineAlignment": "center",
        "inactiveBackground": "#ffd3d3d3",
        "iconOffset": "0",
        "selectionDisplay": "mask",
        "hoveredMaskBorder": "#335292f7,1",
        "iconPadding": "0",
        "hoveredMaskBackground": "#1f5292f7",
        "contentFit": "auto",
        "paddingTop": "2",
        "borderRight": "#ff999999,1",
        "figureBackground": "#ff008800",
        "paddingBottom": "2",
        "iconIndex": "0",
        "colBar": {
            "background": "#ffffffff",
            "paddingRight": "2",
            "iconLocation": "left",
            "border": "#ff313539,1",
            "selectedForeground": "#ffffffff",
            "iconAlignment": "center",
            "foreground": "#ff000000",
            "inactiveForeground": "#ff808080",
            "borderBottom": "#ff808080,1",
            "textAlignment": "center",
            "selectedBackground": "#ff696969",
            "lineAlignment": "center",
            "inactiveBackground": "#ffd3d3d3",
            "iconOffset": "0",
            "selectionDisplay": "mask",
            "hoveredMaskBorder": "#335292f7,1",
            "iconPadding": "0",
            "hoveredMaskBackground": "#1f5292f7",
            "contentFit": "auto",
            "paddingTop": "2",
            "borderRight": "#ff808080,1",
            "figureBackground": "#ff008800",
            "paddingBottom": "2",
            "iconIndex": "0",
            "borderLeft": "#ff808080,1"
        },
        "rowBar": {
            "background": "#ffd3d3d3",
            "paddingRight": "2",
            "iconLocation": "left",
            "border": "#88888888,1",
            "selectedForeground": "#ffffffff",
            "iconAlignment": "center",
            "foreground": "#ff000000",
            "inactiveForeground": "#ff808080",
            "borderBottom": "#ff999999,1",
            "textAlignment": "center",
            "selectedBackground": "#ff696969",
            "lineAlignment": "center",
            "inactiveBackground": "#ffd3d3d3",
            "iconOffset": "0",
            "selectionDisplay": "mask",
            "hoveredMaskBorder": "#335292f7,1",
            "iconPadding": "0",
            "hoveredMaskBackground": "#1f5292f7",
            "contentFit": "auto",
            "paddingTop": "2",
            "borderRight": "#ff999999,1",
            "figureBackground": "#ff008800",
            "paddingBottom": "2",
            "iconIndex": "0"
        }
    }

	,"header":{
		"background":"linear,#fff5f5f5,#ffe2e2e2,90"
		,"iconLocation":"left"
		,"border":"#88888888,0"
		,"iconAlignment":"center"
		,"borderBottom":"#ff747474,1"
		,"fontFamily":"Malgun Gothic"
		,"iconPadding":"2"
		,"selectedBackground":"linear,#ffa2a2a2,#ff939393,90"
		,"contentFit":"auto"
		,"inactiveBackground":"#ffd3d3d3"
		,"iconOffset":"0"
		,"selectionDisplay":"mask"
		,"hoveredMaskBackground":"linear,#ffdadada,#ffc7c7c7,90"
		,"fontSize":"12"
		,"paddingTop":"2"
		,"fontBold":"true"
		,"figureBackground":"#ff656565"
		,"paddingBottom":"2"
		,"hoveredMaskBorder":"#335292f7,1"
		,"paddingRight":"2"
		,"selectedForeground":"#ffffffff"
		,"foreground":"#ff111111"
		,"inactiveForeground":"#ff808080"
		,"textAlignment":"center"
		,"lineAlignment":"center"
		,"borderRight":"#ff888888,1"
		,"textWrap":"normal"
		,"iconIndex":"0"
		,"group":{
			"background":"linear,#fff5f5f5,#ffe2e2e2,90"
			,"iconLocation":"left"
			,"border":"#88888888,0"
			,"iconAlignment":"center"
			,"borderBottom":"#ff747474,1"
			,"fontFamily":"Malgun Gothic"
			,"iconPadding":"2"
			,"selectedBackground":"linear,#ffa2a2a2,#ff939393,90"
			,"contentFit":"auto"
			,"inactiveBackground":"#ffd3d3d3"
			,"iconOffset":"0"
			,"selectionDisplay":"mask"
			,"hoveredMaskBackground":"linear,#ffdadada,#ffc7c7c7,90"
			,"fontSize":"12"
			,"paddingTop":"2"
			,"fontBold":"true"
			,"figureBackground":"#ff606060"
			,"paddingBottom":"2"
			,"hoveredMaskBorder":"#335292f7,1"
			,"paddingRight":"2"
			,"selectedForeground":"#ffffffff"
			,"foreground":"#ff111111"
			,"inactiveForeground":"#ff808080"
			,"textAlignment":"center"
			,"lineAlignment":"center"
			,"borderRight":"#ff888888,1"
			,"textWrap":"normal"
			,"iconIndex":"0"}
		}
	
	,"footer":{
		"background":"linear,#ffd3d3d3,#ffcccccc,90"
		,"iconLocation":"left"
		,"border":"#88888888,0"
		,"iconAlignment":"center"
		,"iconOffset":"0"
		,"fontFamily":"Malgun Gothic"
		,"borderTop":"#ff999999,1"
		,"selectedBackground":"#ff696969"
		,"contentFit":"auto"
		,"inactiveBackground":"#ffd3d3d3"
		,"selectionDisplay":"mask"
		,"iconPadding":"2"
		,"hoveredMaskBackground":"#1f5292f7"
		,"fontSize":"12"
		,"hoveredMaskBorder":"#335292f7,1"
		,"figureBackground":"#ff717171"
		,"paddingBottom":"1"
		,"paddingTop":"2"
		,"paddingRight":"2"
		,"selectedForeground":"#ffffffff"
		,"foreground":"#ff717171"
		,"inactiveForeground":"#ff808080"
		,"textAlignment":"far"
		,"lineAlignment":"center"
		,"borderRight":"#ffababab,1"
		,"iconIndex":"0"
	}

	,"rowGroup":{
		"header":{
			"background":"#ffe4e4e4"
			,"iconLocation":"left"
			,"border":"#88888888,0"
			,"iconAlignment":"center"
			,"borderBottom":"#ffbcbcbc,1"
			,"fontFamily":"Malgun Gothic"
			,"iconPadding":"2"
			,"selectedBackground":"#ff696969"
			,"contentFit":"auto"
			,"inactiveBackground":"#ffd3d3d3"
			,"iconOffset":"0"
			,"selectionDisplay":"mask"
			,"hoveredMaskBackground":"#1f5292f7"
			,"fontSize":"12"
			,"hoveredMaskBorder":"#335292f7,1"
			,"figureBackground":"#ffffffff"
			,"paddingBottom":"2"
			,"paddingTop":"2"
			,"paddingRight":"2"
			,"selectedForeground":"#ffffffff"
			,"foreground":"#ff3d3d3d"
			,"inactiveForeground":"#ff808080"
			,"textAlignment":"near"
			,"lineAlignment":"center"
			,"borderRight":"#ff696969,0"
			,"iconIndex":"0"
		}
		,"footer":{
			"background":"#fff4f4f4"
			,"iconLocation":"left"
			,"border":"#88888888,0"
			,"iconAlignment":"center"
			,"borderBottom":"#ffb7b7b7,1"
			,"fontFamily":"Malgun Gothic"
			,"iconPadding":"2"
			,"selectedBackground":"#ff696969"
			,"contentFit":"auto"
			,"inactiveBackground":"#ffd3d3d3"
			,"iconOffset":"0"
			,"selectionDisplay":"mask"
			,"hoveredMaskBackground":"#1f5292f7"
			,"fontSize":"12"
			,"hoveredMaskBorder":"#335292f7,1"
			,"figureBackground":"#ff5d5d5d"
			,"paddingBottom":"2"
			,"paddingTop":"2"
			,"paddingRight":"2"
			,"selectedForeground":"#ffffffff"
			,"foreground":"#ff5d5d5d"
			,"inactiveForeground":"#ff808080"
			,"textAlignment":"far"
			,"lineAlignment":"center"
			,"borderRight":"#ffb7b7b7,1"
			,"iconIndex":"0"
		}
		,"head":{
			"background":"linear,#fff5f5f5,#ffe2e2e2,90"
			,"iconLocation":"left"
			,"border":"#88888888,0"
			,"iconAlignment":"center"
			,"borderBottom":"#ff747474,1"
			,"fontFamily":"Malgun Gothic"
			,"iconPadding":"2"
			,"selectedBackground":"linear,#ffa2a2a2,#ff939393,90"
			,"contentFit":"auto"
			,"inactiveBackground":"#ffd3d3d3"
			,"iconOffset":"0"
			,"selectionDisplay":"mask"
			,"hoveredMaskBackground":"linear,#ffdadada,#ffc7c7c7,90"
			,"fontSize":"12"
			,"hoveredMaskBorder":"#335292f7,1"
			,"figureBackground":"#ff606060"
			,"paddingBottom":"2"
			,"paddingTop":"2"
			,"paddingRight":"2"
			,"selectedForeground":"#ffffffff"
			,"foreground":"#ff111111"
			,"inactiveForeground":"#ff808080"
			,"textAlignment":"center"
			,"lineAlignment":"center"
			,"borderRight":"#ff888888,1"
			,"textWrap":"normal"
			,"iconIndex":"0"
		}
		,"foot":{
			"background":"linear,#ffd3d3d3,#ffcccccc,90"
			,"iconLocation":"left"
			,"border":"#88888888,0"
			,"iconAlignment":"center"
			,"iconOffset":"0"
			,"fontFamily":"Malgun Gothic"
			,"borderTop":"#ff999999,1"
			,"selectedBackground":"#ff696969"
			,"contentFit":"auto"
			,"inactiveBackground":"#ffd3d3d3"
			,"selectionDisplay":"mask"
			,"iconPadding":"2"
			,"hoveredMaskBackground":"#1f5292f7"
			,"fontSize":"12"
			,"hoveredMaskBorder":"#335292f7,1"
			,"figureBackground":"#ff717171"
			,"paddingBottom":"1"
			,"paddingTop":"2"
			,"paddingRight":"2"
			,"selectedForeground":"#ffffffff"
			,"foreground":"#ff717171"
			,"inactiveForeground":"#ff808080"
			,"textAlignment":"far"
			,"lineAlignment":"center"
			,"borderRight":"#ffababab,1"
			,"iconIndex":"0"
		}
		,"headerBar":{
			"background":"#ffe4e4e4"
			,"iconLocation":"left"
			,"border":"#88888888,0"
			,"iconAlignment":"center"
			,"borderBottom":"#ffbcbcbc,0"
			,"fontFamily":"Malgun Gothic"
			,"iconPadding":"2"
			,"selectedBackground":"#ff696969"
			,"contentFit":"auto"
			,"inactiveBackground":"#ffd3d3d3"
			,"iconOffset":"0"
			,"selectionDisplay":"mask"
			,"hoveredMaskBackground":"#1f5292f7"
			,"fontSize":"12"
			,"hoveredMaskBorder":"#335292f7,1"
			,"paddingRight":"2"
			,"paddingBottom":"2"
			,"paddingTop":"2"
			,"figureBackground":"#ff606060"
			,"selectedForeground":"#ffffffff"
			,"foreground":"#ffffffff"
			,"inactiveForeground":"#ff808080"
			,"textAlignment":"near"
			,"lineAlignment":"center"
			,"iconIndex":"0"
		}
		,"footerBar":{
			"background":"#fff4f4f4"
			,"iconLocation":"left"
			,"border":"#88888888,0"
			,"iconAlignment":"center"
			,"borderBottom":"#ffb7b7b7,1"
			,"fontFamily":"Malgun Gothic"
			,"iconPadding":"2"
			,"selectedBackground":"#ff696969"
			,"contentFit":"auto"
			,"inactiveBackground":"#ffd3d3d3"
			,"iconOffset":"0"
			,"selectionDisplay":"mask"
			,"hoveredMaskBackground":"#1f5292f7"
			,"fontSize":"12"
			,"hoveredMaskBorder":"#335292f7,1"
			,"figureBackground":"#ff808080"
			,"paddingBottom":"2"
			,"paddingTop":"2"
			,"paddingRight":"2"
			,"selectedForeground":"#ffffffff"
			,"foreground":"#ff000000"
			,"inactiveForeground":"#ff808080"
			,"textAlignment":"far"
			,"lineAlignment":"center"
			,"borderRight":"#ffb7b7b7,0"
			,"iconIndex":"0"
		}
		,"bar":{
			"background":"#ffe4e4e4"
			,"iconLocation":"left"
			,"border":"#88888888,0"
			,"iconAlignment":"center"
			,"iconOffset":"0"
			,"fontFamily":"Malgun Gothic"
			,"iconPadding":"2"
			,"selectedBackground":"#ff696969"
			,"contentFit":"auto"
			,"inactiveBackground":"#ffd3d3d3"
			,"selectionDisplay":"mask"
			,"hoveredMaskBackground":"#1f5292f7"
			,"fontSize":"12"
			,"hoveredMaskBorder":"#335292f7,1"
			,"paddingRight":"2"
			,"paddingBottom":"2"
			,"paddingTop":"2"
			,"figureBackground":"#ffffffff"
			,"selectedForeground":"#ffffffff"
			,"foreground":"#ffffffff"
			,"inactiveForeground":"#ff808080"
			,"textAlignment":"near"
			,"lineAlignment":"center"
			,"borderRight":"#ffbcbcbc,1"
			,"iconIndex":"0"
		}
		,"panel":{
			"background":"linear,#fff5f5f5,#ffe2e2e2,90"
			,"iconLocation":"left"
			,"border":"#ff8d8d8d,1"
			,"iconAlignment":"center"
			,"borderBottom":"#ff808080,0"
			,"fontFamily":"Malgun Gothic"
			,"iconPadding":"2"
			,"selectedBackground":"#ff696969"
			,"contentFit":"auto"
			,"inactiveBackground":"#ffd3d3d3"
			,"iconOffset":"0"
			,"selectionDisplay":"mask"
			,"hoveredMaskBackground":"linear,#ffdadada,#ffc7c7c7,90"
			,"fontSize":"12"
			,"hoveredMaskBorder":"#335292f7,1"
			,"figureBackground":"#ff000000"
			,"paddingBottom":"1"
			,"paddingTop":"1"
			,"paddingRight":"1"
			,"selectedForeground":"#ffffffff"
			,"foreground":"#ff111111"
			,"inactiveForeground":"#ff808080"
			,"line":"#ff8d8d8d,1"
			,"textAlignment":"center"
			,"lineAlignment":"center"
			,"borderRight":"#ff808080,0"
			,"textWrap":"normal"
			,"iconIndex":"0"
		}
	}

	,"indicator":{
		"background":"linear,#ffffffff,#ffe7e7e7,360"
		,"iconLocation":"left"
		,"border":"#88888888,0"
		,"iconAlignment":"center"
		,"borderBottom":"#ffc0c0c0,1"
		,"fontFamily":"Malgun Gothic"
		,"iconPadding":"2"
		,"selectedBackground":"#ffffffff"
		,"contentFit":"auto"
		,"inactiveBackground":"#ffd3d3d3"
		,"iconOffset":"0"
		,"selectionDisplay":"mask"
		,"hoveredMaskBackground":"linear,#ffe4e4e4,#ffc8c8c8,360"
		,"fontSize":"12"
		,"hoveredMaskBorder":"#335292f7,1"
		,"figureBackground":"#ff606060"
		,"paddingBottom":"2"
		,"paddingTop":"2"
		,"paddingRight":"2"
		,"selectedForeground":"#ff606060"
		,"foreground":"#ff7d7d7d"
		,"inactiveForeground":"#ff808080"
		,"textAlignment":"center"
		,"lineAlignment":"center"
		,"borderRight":"#ffc0c0c0,1"
		,"iconIndex":"0"
		,"head":{
			"background":"linear,#fff5f5f5,#ffe2e2e2,90"
			,"iconLocation":"left"
			,"border":"#88888888,0"
			,"iconAlignment":"center"
			,"borderBottom":"#ff747474,1"
			,"fontFamily":"Malgun Gothic"
			,"iconPadding":"2"
			,"selectedBackground":"linear,#ffa2a2a2,#ff939393,90"
			,"contentFit":"auto"
			,"inactiveBackground":"#ffd3d3d3"
			,"iconOffset":"0"
			,"selectionDisplay":"mask"
			,"hoveredMaskBackground":"linear,#ffdadada,#ffc7c7c7,90"
			,"fontSize":"12"
			,"hoveredMaskBorder":"#335292f7,1"
			,"figureBackground":"#ff606060"
			,"paddingBottom":"2"
			,"paddingTop":"2"
			,"paddingRight":"2"
			,"selectedForeground":"#ffffffff"
			,"foreground":"#ff111111"
			,"inactiveForeground":"#ff808080"
			,"textAlignment":"center"
			,"lineAlignment":"center"
			,"borderRight":"#ff888888,1"
			,"textWrap":"normal"
			,"iconIndex":"0"
		}
		,"foot":{
			"background":"linear,#ffd3d3d3,#ffcccccc,90"
			,"iconLocation":"left"
			,"border":"#88888888,0"
			,"iconAlignment":"center"
			,"iconOffset":"0"
			,"fontFamily":"Malgun Gothic"
			,"borderTop":"#ff999999,1"
			,"selectedBackground":"#ff696969"
			,"contentFit":"auto"
			,"inactiveBackground":"#ffd3d3d3"
			,"selectionDisplay":"mask"
			,"iconPadding":"2"
			,"hoveredMaskBackground":"#1f5292f7"
			,"fontSize":"12"
			,"hoveredMaskBorder":"#335292f7,1"
			,"figureBackground":"#ff717171"
			,"paddingBottom":"1"
			,"paddingTop":"2"
			,"paddingRight":"2"
			,"selectedForeground":"#ffffffff"
			,"foreground":"#ff717171"
			,"inactiveForeground":"#ff808080"
			,"textAlignment":"far"
			,"lineAlignment":"center"
			,"borderRight":"#ffababab,1"
			,"iconIndex":"0"
		}
	}

	,"checkBar":{
		"background":"#ffffffff"
		,"iconLocation":"left"
		,"border":"#88888888,0"
		,"iconAlignment":"center"
		,"borderBottom":"#ffcacaca,1"
		,"fontFamily":"Malgun Gothic"
		,"iconPadding":"2"
		,"selectedBackground":"#ff696969"
		,"contentFit":"auto"
		,"inactiveBackground":"#ffd3d3d3"
		,"iconOffset":"0"
		,"selectionDisplay":"mask"
		,"hoveredMaskBackground":"#1f5292f7"
		,"fontSize":"12"
		,"hoveredMaskBorder":"#335292f7,1"
		,"figureBackground":"#ff606060"
		,"paddingBottom":"2"
		,"paddingTop":"2"
		,"paddingRight":"2"
		,"figureSize":"12"
		,"selectedForeground":"#ffffffff"
		,"foreground":"#ff000000"
		,"inactiveForeground":"#ff808080"
		,"textAlignment":"center"
		,"lineAlignment":"center"
		,"borderRight":"#ffbcbcbc,1"
		,"iconIndex":"0"
		,"head":{
			"background":"linear,#fff5f5f5,#ffe2e2e2,90"
			,"iconLocation":"left"
			,"border":"#88888888,0"
			,"iconAlignment":"center"
			,"borderBottom":"#ff747474,1"
			,"fontFamily":"Malgun Gothic"
			,"iconPadding":"2"
			,"selectedBackground":"#ff696969"
			,"contentFit":"auto"
			,"inactiveBackground":"#ffd3d3d3"
			,"iconOffset":"0"
			,"selectionDisplay":"mask"
			,"hoveredMaskBackground":"#1f5292f7"
			,"fontSize":"12"
			,"paddingTop":"2"
			,"figureBackground":"#ff606060"
			,"paddingBottom":"2"
			,"hoveredMaskBorder":"#335292f7,1"
			,"paddingRight":"2"
			,"figureSize":"12"
			,"selectedForeground":"#ffffffff"
			,"foreground":"#ff000000"
			,"inactiveForeground":"#ff808080"
			,"textAlignment":"center"
			,"lineAlignment":"center"
			,"borderRight":"#ff888888,1"
			,"textWrap":"normal"
			,"iconIndex":"0"
		}
		,"foot":{
			"background":"linear,#ffd3d3d3,#ffcccccc,90"
			,"iconLocation":"left"
			,"border":"#88888888,0"
			,"iconAlignment":"center"
			,"iconOffset":"0"
			,"fontFamily":"Malgun Gothic"
			,"borderTop":"#ff999999,1"
			,"selectedBackground":"#ff696969"
			,"contentFit":"auto"
			,"inactiveBackground":"#ffd3d3d3"
			,"selectionDisplay":"mask"
			,"iconPadding":"2"
			,"hoveredMaskBackground":"#1f5292f7"
			,"fontSize":"12"
			,"hoveredMaskBorder":"#335292f7,1"
			,"figureBackground":"#ff717171"
			,"paddingBottom":"1"
			,"paddingTop":"2"
			,"paddingRight":"2"
			,"selectedForeground":"#ffffffff"
			,"foreground":"#ff717171"
			,"inactiveForeground":"#ff808080"
			,"textAlignment":"far"
			,"lineAlignment":"center"
			,"borderRight":"#ffababab,1"
			,"iconIndex":"0"
		}
	}

	,"statusBar":{
		"background":"#ffffffff"
		,"iconLocation":"left"
		,"border":"#88888888,0"
		,"iconAlignment":"center"
		,"borderBottom":"#ffcacaca,1"
		,"fontFamily":"Malgun Gothic"
		,"iconPadding":"2"
		,"selectedBackground":"#ff696969"
		,"contentFit":"auto"
		,"inactiveBackground":"#ffd3d3d3"
		,"iconOffset":"0"
		,"selectionDisplay":"mask"
		,"hoveredMaskBackground":"#1f5292f7"
		,"fontSize":"12"
		,"hoveredMaskBorder":"#335292f7,1"
		,"figureBackground":"#ff606060"
		,"paddingBottom":"2"
		,"paddingTop":"2"
		,"paddingRight":"2"
		,"selectedForeground":"#ffffffff"
		,"foreground":"#ff606060"
		,"inactiveForeground":"#ff808080"
		,"textAlignment":"center"
		,"lineAlignment":"center"
		,"borderRight":"#ffcacaca,1"
		,"iconIndex":"0"
		,"head":{
			"background":"linear,#fff5f5f5,#ffe2e2e2,90"
			,"iconLocation":"left"
			,"border":"#ff747474,1"
			,"iconAlignment":"center"
			,"borderBottom":"#ff808080,1"
			,"fontFamily":"Malgun Gothic"
			,"iconPadding":"2"
			,"selectedBackground":"#ff696969"
			,"contentFit":"auto"
			,"inactiveBackground":"#ffd3d3d3"
			,"iconOffset":"0"
			,"selectionDisplay":"mask"
			,"hoveredMaskBackground":"#1f5292f7"
			,"fontSize":"12"
			,"hoveredMaskBorder":"#335292f7,1"
			,"figureBackground":"#ff606060"
			,"paddingBottom":"2"
			,"paddingTop":"2"
			,"paddingRight":"2"
			,"selectedForeground":"#ffffffff"
			,"foreground":"#ff606060"
			,"inactiveForeground":"#ff808080"
			,"textAlignment":"center"
			,"lineAlignment":"center"
			,"borderRight":"#ff888888,1"
			,"textWrap":"normal"
			,"iconIndex":"0"
		}
		,"foot":{
			"background":"linear,#ffd3d3d3,#ffcccccc,90"
			,"iconLocation":"left"
			,"border":"#88888888,0"
			,"iconAlignment":"center"
			,"iconOffset":"0"
			,"fontFamily":"Malgun Gothic"
			,"borderTop":"#ff999999,1"
			,"selectedBackground":"#ff696969"
			,"contentFit":"auto"
			,"inactiveBackground":"#ffd3d3d3"
			,"selectionDisplay":"mask"
			,"iconPadding":"2"
			,"hoveredMaskBackground":"#1f5292f7"
			,"fontSize":"12"
			,"hoveredMaskBorder":"#335292f7,1"
			,"figureBackground":"#ff717171"
			,"paddingBottom":"1"
			,"paddingTop":"2"
			,"paddingRight":"2"
			,"selectedForeground":"#ffffffff"
			,"foreground":"#ff717171"
			,"inactiveForeground":"#ff808080"
			,"textAlignment":"far"
			,"lineAlignment":"center"
			,"borderRight":"#ffababab,1"
			,"iconIndex":"0"
		}
	}

	,"selection":{
		"background":"#2f1e90ff"
		,"paddingRight":"0"
		,"iconLocation":"left"
		,"border":"#5f1e90ff,2"
		,"selectedForeground":"#ffffffff"
		,"iconAlignment":"center"
		,"foreground":"#ff000000"
		,"inactiveForeground":"#ff808080"
		,"iconOffset":"0"
		,"fontFamily":"Malgun Gothic"
		,"textAlignment":"center"
		,"selectedBackground":"#ff696969"
		,"lineAlignment":"center"
		,"inactiveBackground":"#ffd3d3d3"
		,"selectionDisplay":"mask"
		,"hoveredMaskBorder":"#335292f7,1"
		,"iconPadding":"2"
		,"hoveredMaskBackground":"#1f5292f7"
		,"fontSize":"12"
		,"contentFit":"auto"
		,"paddingTop":"0"
		,"figureBackground":"#ff008800"
		,"paddingBottom":"0"
		,"iconIndex":"0"
	}
};



/*gridImgList, gridIconStyles는 페이러 존재해야 함.
 * 
 **/
var _gridImgList = new RealGridJS.ImageList("gridImgList","/resources/images/icon/");

_gridImgList.addUrls([
	"IcoBlank.gif"
   ,"IcoDetail.png" 
   ,"IcoFileDown.png"
   ,"IcoSrch.png"
]);

var _gridIconStyles = [
	 { criteria: "value=''"			, styles	: "iconIndex=3"}
	,{ criteria: "value=null"		, styles	: "iconIndex=3"}
	,{ criteria: "value='DETAIL'"	, styles	: "iconIndex=3"}
	,{ criteria: "value='FILEDOWN'"	, styles	: "iconIndex=2"}
];    

var _gridIconPopStyles = [
	 { criteria: "value=''"			, styles	: "iconIndex=0"}
	,{ criteria: "value=null"		, styles	: "iconIndex=0"}
	,{ criteria: "value='DETAIL'"	, styles	: "iconIndex=3"}
	,{ criteria: "value='FILEDOWN'"	, styles	: "iconIndex=2"}
];    


/**
 * obj, fieldName, headerStyle, width, dataType, colStyles, extraOption
 * addField(colField ,'field2' ,{fixedHeight: 40,text: "Order2",subText: "(* 추가설명)"} ,200 ,'text' ,{textAlignment: "center"} ,{visible:false,sortable:false});
 */
var addField = function(obj, fieldName, headerStyle, width, dataType, colStyles, extraOptions, editType, editOptions) {
	if (typeof obj == null) { alert("모델이 없습니다."); return false;}
	if (null == fieldName || '' == fieldName) { alert("필드명이 없습니다."); return false;}
	if (null == headerStyle || '' == headerStyle) { alert("헤더정보가 없습니다."); return false;}
	
	var _defaultWidth 	= "100";
	var _headerStyle	= headerStyle;
	var _width			= width;
	var _dataType		= dataType;
	var _colStyles		= colStyles;
	var _extraOptions	= extraOptions;
	var _editType		= editType;
	var _editOptions	= editOptions;
	
	if (undefined == _headerStyle || '' == _headerStyle) 	_headerStyle = {text:fieldName};
	if (undefined == _width || '' == _width) 				_width = _defaultWidth;
	if (undefined == _dataType || '' == _dataType) 			_dataType = 'text';
	if (undefined == _colStyles || '' == _colStyles) 		_colStyles = null;
	if (undefined == _extraOptions || '' == _extraOptions) 	_extraOptions = null;
	if (undefined == _editType || '' == _editType) 			_editType = null;
	if (undefined == _editOptions || '' == _editOptions) 	_editOptions = null;
	
	obj.push({fieldName		:	fieldName 
			 ,dataType		:	_dataType
			 ,header		:	_headerStyle
			 ,width			:	_width
			 ,styles		:	_colStyles
			 ,extraOption	:	_extraOptions
			 ,editType		:	_editType
			 ,editOption	:	_editOptions
			});
};


var addGroup = function(obj, _groupInfo) {
	$.extend(obj, {"_COLUMN_GROUP":true, "GROUP_INFO":_groupInfo});
};

/*
 * 
 */
RealGridJS.GridView.prototype.rgrid = function (options) {
	var _indicatorDp = "index";
	var _selectStyle = "block";
	var _datetimeFormat = "yyyy-MM-dd";
	var _editDateTimeFormat = "yyyyMMdd";
	var _dbDateTimeFormat = "yyyyMMddhhmmss";
	var _numberFormat = '#,##0.##';
	var _integerFormat = '#,##0';
	var _defaultRowHeight = _G_GRID_ROW_HEIGHT;
	var _defaultHeaderHeight = _G_GRID_HEADER_HEIGHT;
	var _columnNames;
	var _gridDefaultWith = "100%";
	var _defaultFitStyle = "even";
	
	
    var toggle = false;
	
	// pagesize
	var _pageSize		= _G_PAGE_SIZE;
	var _pageUnit       = _G_PAGE_UNIT;
	
	var _detailIcon	= {images:
						[{	name	: "상세",
				            up 		: "/resources/images/icon/IcoDetail.png",
				            hover	: "/resources/images/icon/IcoDetail.png",
				            down	: "/resources/images/icon/IcoDetail.png"
			        	}]
					};
	var _fileDownIcon = {images: 
						[{
					        name	: "파일다운",
					        up 		: "/resources/images/icon/IcoFileDown.png",
					        hover	: "/resources/images/icon/IcoFileDown.png",
					        down	: "/resources/images/icon/IcoFileDown.png"
					    }]
					};
	
	var _defaultContextMenu = [
		 {label	:	"Search"	, tag:	"searchVal"}
		,{label	:	"Col Fix"	, tag:	"columnFix"}
		,{label	:	"Row Fix"	, tag:	"rowFix"}
		,{label	:	"Cancel Fix", tag:	"cancelFix"}
		,{label	:	"-"}
	];
    
	var _defaultHeaderContextMenu = [
		 {label	:	"Excel"	, tag:	"exportExcel"}
		,{label	:	"Filter"	, tag:	"filter"}
		,{label	:	"Hide col.", tag:	"hideCol"}
		,{label	:	"Show all col.", tag:	"showAllCol"}
		,{label	:	"-"}
	];
	
	var dataProvider = new RealGridJS.LocalDataProvider();
	this.setDataSource(dataProvider);  
	
	options = options || {};
	
	//DB로 부터의 날짜 포멧옵션 기본은 "YYYYMMDDHH24MISS"
	dataProvider.setOptions({
         datetimeFormat			: options.sqlDateTimeFormat === undefined?_dbDateTimeFormat:options.sqlDateTimeFormat      
        ,commitBeforeDataEdit	: true
    });
	
	//if (options.editable!==undefined && options.editable) {
		//console.log("dataprovider edit mode setting");
		dataProvider.setOptions({
		  	 softDeleting			: true
		  	,deleteCreated			: true 				
		});
	//}
		
    
	if (options.width !== undefined) _gridDefaultWith = options.width;
	else if (options.width === undefined || options.width  === "100%") {
		//console.log(this._gv._name + "/ [%o]", this); //_gv._container._containerDiv.id
		_dynamicResizeTargetWidth.push({gridName:this._gv._container._containerDiv.id,gridDivId:options.gridId});
	}
	
	if (options.gridId !== undefined) {
		$("#"+options.gridId).css({ width: _gridDefaultWith, height: options.height===undefined?getGridHeight(options.gridId):options.height});
	}
	
	if (options.columns === undefined) {
    	alert("정의된 컬럼이 없습니다.");
    	return;
    }
    
    var _fields = [];
    var _columns = [];
    var _columDynmic = {};	
    for (var cols=0;cols<options.columns.length;cols++) {
    	var _curColumn = options.columns[cols];
    	
    	if (_curColumn.dataType == "datetime") {
    		_fields.push({fieldName:_curColumn.fieldName, dataType:_curColumn.dataType});
    	} else if (_curColumn.dataType == "textLink" || _curColumn.dataType == "fileLink" || _curColumn.dataType == "popupLink" || _curColumn.dataType == "searchLink" ) { 
    		_fields.push({fieldName:_curColumn.fieldName});
    	} else if (_curColumn.dataType == "number" || _curColumn.dataType == "integer") {
    		if (_curColumn.header.calculateExpression!==undefined) {
    			_fields.push({fieldName:_curColumn.fieldName, dataType:"numeric", calculateExpression:_curColumn.header.calculateExpression});
    		} else 	if (_curColumn.header.calculateCallback!==undefined) {
    			_fields.push({fieldName:_curColumn.fieldName, dataType:"numeric", calculateCallback:_curColumn.header.calculateCallback});
    		} else {
    			_fields.push({fieldName:_curColumn.fieldName, dataType:"number"});
    		}
    	} else {
        	_fields.push({fieldName:_curColumn.fieldName});
    	}
    	
    	var _tmpCol = {name:_curColumn.fieldName,fieldName:_curColumn.fieldName,header:_curColumn.header,width:_curColumn.width};
    	
    	// style 적용
    	if (_curColumn.styles != null) {
    		_tmpCol["styles"] = _curColumn.styles;
    		
    		if (_curColumn.dataType == 'number') {
    			_tmpCol["styles"]["textAlignment"] 	= _curColumn.styles.textAlignment==null?'far':_curColumn.styles.textAlignment;
    			_tmpCol["styles"]["numberFormat"] 	= _curColumn.styles.numberFormat==null?_numberFormat:_curColumn.styles.numberFormat;
    		} 
    		else if (_curColumn.dataType == 'integer') {
    			_tmpCol["styles"]["textAlignment"] 	= _curColumn.styles.textAlignment==null?'far':_curColumn.styles.textAlignment;
    			_tmpCol["styles"]["numberFormat"] 	= _curColumn.styles.numberFormat==null?_integerFormat:_curColumn.styles.numberFormat;
    		}
    		else if (_curColumn.dataType == 'datetime') {
    			_tmpCol["styles"]["textAlignment"] 	= _curColumn.styles.textAlignment==null?'center':_curColumn.styles.textAlignment;
    			_tmpCol["styles"]["datetimeFormat"] = _curColumn.styles.datetimeFormat==null?_datetimeFormat:_curColumn.styles.datetimeFormat
    		}
    		else if (_curColumn.dataType == 'text') {
    			//_tmpCol["styles"] = _curColumn.styles;
    		}
    		else if (_curColumn.dataType == 'textLink') {
    			//_tmpCol["styles"] = _curColumn.styles;
    			if (null==_curColumn.styles.fontUnderline) _tmpCol["styles"]["fontUnderline"] = true;
    			if (null==_curColumn.styles.foreground) _tmpCol["styles"]["foreground"] = "#0000ff"; 
    			if (null==_curColumn.cursor) _tmpCol["cursor"] = "pointer"; 
    		}
    		else if (_curColumn.dataType == 'fileLink') {
    			//_tmpCol["styles"] = _curColumn.styles;
    		}
    		else if (_curColumn.dataType == 'popupLink') {
    			//_tmpCol["styles"] = _curColumn.styles;
    		}
    		else if (_curColumn.dataType == 'searchLink') {
    			_tmpCol["editable"] = false;
    			_tmpCol["styles"] = {iconIndex:3, iconLocation:"right"};
    			_tmpCol["imageList"] = "gridImgList";
    			_tmpCol["renderer"] = {type: "icon", textvisible:true};
    			_tmpCol["dynamicStyles"] = _gridIconStyles;
    			_tmpCol["cursor"] = "pointer";
    			_tmpCol["styles"]["textAlignment"] 	= _curColumn.styles.textAlignment==null?'center':_curColumn.styles.textAlignment;
    			
        		//정의된 dynamic 처리
    		}
    		else if (_curColumn.dataType == 'check') {
    			_tmpCol["editable"] = true;
    			//체크안한것은 음영 체크가 아니라 음영 체크 없는것
    			_tmpCol["styles"]["figureInactiveBackground"] 	= "#00000000";
    			_tmpCol["renderer"] = {type: "check", shape:"box", trueValues: "Y", falseValues:"N"};
    		}
    		//else _tmpCol["styles"] = {textAlignment:'center'};
    		//정의된 dynamic 처리
    		 if (_curColumn["styles"]["dynamicOpt"] != undefined ) {
    			 var oDyamicOpt = _curColumn["styles"]["dynamicOpt"];
    			 _columDynmic[_curColumn.fieldName] = oDyamicOpt;
        		 
        		 _tmpCol["dynamicStyles"] = function(grid, index, value){
            		 var _dyInputMode = _columDynmic[index.column].inputMode;
            		 var _dyDisplayType = _columDynmic[index.column].displayType;
            		 var _dyAmtChkCol = _columDynmic[index.column].amtChkCol;
            		 var _dyAmtChkVal = _columDynmic[index.column].amtChkVal;
            		 
        		     var ret = {};
        			 var col1Value;
        		     if(_dyAmtChkCol != ''){
        		    	 col1Value = grid.getValue(index.itemIndex, _dyAmtChkCol);
        		     }
        		     var editOption = grid.getEditOptions();
        		     var colEditOption = grid.getColumnProperty(index.column, "editable");
 
        		     if(_dyInputMode == "R" && value == ""){
       			    	ret.background = "#FAEBD7";
       			     }
       			     if(_dyInputMode == "I" && value == "" && (editOption.editable != false && colEditOption != false )){
       			    	ret.background = "#F0F8FF";
       			     }
    			     if(_dyDisplayType == "AMT"){
        		    	 switch (col1Value) {
        			     case _dyAmtChkVal:
        			         //에디트시 소수점 입력 자리수 변경
        			         ret.editor = {type:"number",editFormat:"#,##0"};
        		             //화면에 보여지는 동적 스타일
        		             ret.numberFormat = "#,##0";
        			         break;
        			     default :
        		 	         ret.editor = {type:"number",editFormat:"#,##0.##"};
        		             ret.numberFormat = "#,##0.##";
        			     }
       			     }
    			     
    			     if(_dyDisplayType == "QTY" || _dyDisplayType == "QNT"){
    			         ret.editor = {type:"number",editFormat:"#,##0.###"};
    		             ret.numberFormat = "#,##0.###";
    			     }
    			     if(_columDynmic[index.column].edgeMask == "1"){
    			    	 var colValEdge = "";
    			    	 if(_columDynmic[index.column].edgeMaskCol != ""){
    			    		 colValEdge = grid.getValue(index.itemIndex, _columDynmic[index.column].edgeMaskCol);
    			    	 }
    			    	 if(colValEdge == _columDynmic[index.column].edgeMaskVal){
        			    	 ret.figureName = "rightTop";
        			    	 ret.figureBackground = "#FF0000FF";
        			    	 ret.figureSize = "7";
    			    	 }
    			     }

        			 return ret;

        		 };
    		 }
    		
    	} else {
    		if (_curColumn.dataType == 'number') {
    			_tmpCol["styles"] = {textAlignment:'far',numberFormat:_numberFormat};
    		}
    		else if (_curColumn.dataType == 'integer') {
    			_tmpCol["styles"] = {textAlignment:'far',numberFormat:_integerFormat};
    		}
    		else if (_curColumn.dataType == 'datetime') {
    			_tmpCol["styles"] = {textAlignment:'center',datetimeFormat:_datetimeFormat};
    		}
    		else if (_curColumn.dataType == 'textLink') {
    			_tmpCol["styles"] = {fontUnderline:true,foreground:"#0000ff"};
    			_tmpCol["cursor"] = "pointer";
    		}
    		else if (_curColumn.dataType == 'fileLink') {
    			_tmpCol["editable"] = false;
    			_tmpCol["styles"] = {iconIndex:2, iconLocation:"center"};
    			_tmpCol["imageList"] = "gridImgList";
    			_tmpCol["renderer"] = {type: "icon"};
    			_tmpCol["dynamicStyles"] = _gridIconStyles;
    			_tmpCol["cursor"] = "pointer";
    		}
    		else if (_curColumn.dataType == 'popupLink') {
    			_tmpCol["editable"] = false;
    			_tmpCol["styles"] = {iconIndex:1, iconLocation:"center"};
    			_tmpCol["imageList"] = "gridImgList";
    			_tmpCol["renderer"] = {type: "icon"};
    			_tmpCol["dynamicStyles"] = _gridIconPopStyles;
    			_tmpCol["cursor"] = "pointer";
    		}
    		else if (_curColumn.dataType == 'searchLink') {
    			_tmpCol["editable"] = false;
    			_tmpCol["styles"] = {iconIndex:3, iconLocation:"right"};
    			_tmpCol["imageList"] = "gridImgList";
    			_tmpCol["renderer"] = {type: "icon", textvisible:true};
    			_tmpCol["dynamicStyles"] = _gridIconStyles;
    			_tmpCol["cursor"] = "pointer";
    		}
    		else _tmpCol["styles"] = _curColumn.styles;
    	}
    	
    	// editor 적용
    	if (_curColumn.editType == null) {
    		//그리드 기본 적용
    		if (_curColumn.editOption != null) {
    			_tmpCol["editor"] = _curColumn.editOption;
    		} 
    	} else {
    		if (_curColumn.editType === 'text') {
        		if (_curColumn.editOption != null) {
        			_tmpCol["editor"] = _curColumn.editOption;
        		}
        	} else if (_curColumn.editType === 'number') {
        		if (_curColumn.editOption != null) {
        			_tmpCol["editor"] = _curColumn.editOption;
        		} else {
	                _tmpCol["editor"] = {
	    				 type: "number"
	    				,textAlignment: "far"
	                };
    				if (_curColumn.dataType=="integer") _tmpCol["editor"]["editFormat"]=_integerFormat;
    				else _tmpCol["editor"]["editFormat"]=_numberFormat;
    			}
        	} else if (_curColumn.editType === 'date') {
        		if (_curColumn.editOption != null) {
        			_tmpCol["editor"] = _curColumn.editOption;
        		} else {
        			_tmpCol["editor"] = {
    					type: "date"
    		    	   ,datetimeFormat: _editDateTimeFormat
    		    	   ,yearNavigation:true
    		    	   ,maxLength:8
        			}
        		}	
            } else if (_curColumn.editType === 'dropDown') {
            	if (_curColumn.editOption != null) {
        			_tmpCol["editor"] = _curColumn.editOption;
        		} else {
        			_tmpCol["editor"] = {
    					 type		: "dropDown"
    					,domainOnly	: true
    					,textReadOnly:true
        		    }
        		}
            	
        	} else if (_curColumn.editType === 'multiline') {
        		if (_curColumn.editOption != null) {
        			_tmpCol["editor"] = _curColumn.editOption;
        		} else {
        			_tmpCol["editor"] = {
        				type: "multiline"
        			}
        		}
        	} else {
        		if (_curColumn.editOption != null) {
        			_tmpCol["editor"] = _curColumn.editOption;
        		} 
        	}
    	}
    		
    	if (_curColumn.extraOption != null) {
    		for (var _key in _curColumn.extraOption) {
    		    _tmpCol[_key] = _curColumn.extraOption[_key];
    		} 
    	}
    	
		if (options.showTooltip !== undefined && options.showTooltip) {
			if (undefined ===_tmpCol["renderer"] || null == _tmpCol["renderer"]) {
				_tmpCol["renderer"] = {showTooltip:true};
			} else {
				if (undefined ===_tmpCol["renderer"]["showTooltip"] || null ==_tmpCol["renderer"]["showTooltip"]) {
					$.extend(_tmpCol["renderer"], {showTooltip:true});	
				} 
			}
		}

    	_columns.push(_tmpCol);
    }
    
    //Grid header area Properties
    if (options.headerHeight !== undefined) this.setHeader({height: options.headerHeight});
    else this.setHeader({height:_defaultHeaderHeight});
    
    this.setStyles(globalStyle);
    if (options.dynamicRowStyle !== undefined) {
    	this.setStyles(options.dynamicRowStyle);
    }
    
    //Grid Properties
    var _gridAppendable = options.appendable===undefined?false:options.appendable;
	if (options.editable!==undefined && options.editable) {
		this.setOptions({ 
			edit:{
			 	 enterToTab	: true
		        ,insertable	: _gridAppendable
		        ,appendable	: _gridAppendable
		        ,updatable	: true
		        ,deletable	: _gridAppendable
		        ,deleteRowsConfirm: true
		        ,deleteRowsMessage: "선택한 행(들)을 삭제하시겠습니까?"
			}
	  		,hideDeletedRows	: true
		});
	}
    this.setOptions({
    	 footer		:{visible:options.footerVisible			== undefined?false:options.footerVisible		}
    	,stateBar	:{visible:options.stateBarVisible		== undefined?false:options.stateBarVisible		}
    	,panel		:{visible:options.panelVisible			== undefined?false:options.panelVisible			}
    	,indicator	:{displayValue:options.indicatorDp		== undefined?_indicatorDp:options.indicatorDp	}
    	,body		:{rowStylesFirst:options.rowStylesFirst	== undefined?false:options.rowStylesFirst		}
    	,sorting	:{handleVisibility:"visible"	, enabled:options.sortEnabled==undefined?true:options.sortEnabled	}
    	,summaryMode:options.summaryMode ==undefined?"none":eval("RealGridJS.SummaryMode"+options.summaryMode)
    });

    
    this.setDisplayOptions({
	   	 columnMovable	: options.columnMovable		== undefined?true:options.columnMovable
	   	,columnResizable: options.columnResizable	== undefined?true:options.columnResizable
	   	,rowHeight		: options.rowHeight			== undefined?_defaultRowHeight:options.rowHeight
	   	,fitStyle		: options.fitStyle			== undefined?_defaultFitStyle:options.fitStyle
	   	//,showEmptyMessage : true
	   	//,emptyMessage : '조회된 데이터가 없습니다.'
    });
    this.setCheckBar({visible: options.checkBar==undefined?true:options.checkBar
    				, exclusive:options.exclusive==undefined?false:options.exclusive});
    this.setEditOptions({editable: options.editable==undefined?false:options.editable });
    this.setEditorOptions({
    	 useCssStyleDropDownList: true
		,useCssStyleDatePicker: true
    });
    this.setCopyOptions({singleMode: options.copySingle==undefined?true:options.copySingle, copyDisplayText: true});
    //붙여넣기 가능 옵션은 그리드의 에디터블 여부에 함께 적용됨.
    this.setPasteOptions({enabled: options.editable==undefined?false:options.editable
    					, checkReadOnly:true});
    this.setSelectOptions({style: options.selectStyle==undefined?_selectStyle:options.selectStyle});
        
    dataProvider.setFields(_fields);
        
    //lookup이 존재하면 lookup 추가
    if (options.lookups !== undefined) this.setLookups(options.lookups);
    
    //column header group 존재할 경우 header 생성
    if (options.columns._COLUMN_GROUP!==undefined && options.columns._COLUMN_GROUP) {
    	
    	for (_groupName in options.columns.GROUP_INFO) {
    		var _groupHeader = {
					  type	: "group"
			         ,name	: _groupName
				};
    		var _groupColumns = [];
			var _i = 0;
			var _startPoint = -1;
    		var _groupSize = options.columns.GROUP_INFO[_groupName].length;
    		var _targetStartFieldName = options.columns.GROUP_INFO[_groupName][_i++];
    		var _groupWidth = 0;
    		
    		for (_row_col in _columns) {
    			if (_columns[_row_col].name === _targetStartFieldName) {
    				_groupColumns.push(_columns[_row_col]);
    				_groupWidth += Number(_columns[_row_col].width);
					if (_i >= _groupSize) {
						_groupHeader["width"] = _groupWidth;
	    				_groupHeader["columns"] = _groupColumns;
    					//_columns[1].splice(1, 1);
    					_columns.splice(_startPoint, _groupSize, _groupHeader);
    					break;
    				}
    				_targetStartFieldName = options.columns.GROUP_INFO[_groupName][_i++];
    				if (-1==_startPoint) _startPoint=_row_col;
    			}  
    		}
    	}
    }
    
    this.setColumns(_columns);    
    _columnNames = this.getColumnNames(false);
    
    this.registerImageList(_gridImgList);
    
	this.resetSize();

	//context menu
	if (options.contextMenu == undefined || (options.contextMenu !=undefined && options.contextMenu.visible)) {
		this.onContextMenuItemClicked = function (grid, data, index) {
            if (data.tag == "excel") {
                grid.exportGrid({
                    type: "excel",
                    target: "local",
                    fileName: "gridExportSample.xlsx"
                });
            } else if (data.tag == "filter" && index.column) {
                this.createColumnFilter(grid, index.column);
            } else if (data.tag == "visibleTrue") {
                //var columns = grid.getColumns();
                //화면에서 이미 숨기고 시작한건과 구별
                var columns = grid.columnsByTag("hide");
                for (var i in columns) {
                    grid.setColumnProperty(columns[i].name, "visible", true);
                    grid.setColumnProperty(index.column, "tag", "");
                }
                toggle = false;
                setHeaderCellContextMenu(grid, toggle);
            } else if (data.tag == "visibleFalse") {
                grid.setColumnProperty(index.column, "visible", false);
                //화면에서 이미 숨기고 시작한건과 구별
                grid.setColumnProperty(index.column, "tag", "hide");

                toggle = true;
                setHeaderCellContextMenu(grid, toggle);
            } else if (data.tag == "fixedCol") {
                var count = grid.getColumnProperty(index.column, "displayIndex") + 1;
                grid.setFixedOptions({ colCount: count });
            } else if (data.tag == "fixedRow") {
                var count = index.itemIndex + 1;
                grid.setFixedOptions({ rowCount: count });
            } else if (data.tag == "fixedCancel") {
                grid.setFixedOptions({ colCount: 0, rowCount: 0 });
            } else if (data.tag == "search"){
                this.search(grid, index.column);
            } else if (data.tag == "exportExcel"){
            	this.exportToExcel(grid);
            }
        }

        this.onContextMenuPopup = function (grid, x, y, elementName) {
            if (elementName == "HeaderCell") {
            	this.setHeaderCellContextMenu(this, toggle);
            } else if (elementName == "DataCell") {
                this.setDataCellContextMenu(this);
            } else {
                return false;
            }
        };
        
        this.setHeaderCellContextMenu = function (grid, val) {
        	  var contextMenu = [{
                  label: "필터 만들기",
                  tag: "filter"
              }, {
                  label: "-"
              }, {
                  label: "컬럼 숨기기",
                  tag: "visibleFalse"
              }, {
                  label: "컬럼 모두 보이기",
                  tag: "visibleTrue",
                  enabled: val
              }];

              this.setContextMenu(contextMenu);
           };
           this.setDataCellContextMenu = function (grid) {
        	     var contextMenu = [
        	    	{
        	            label: "검색",
        	            tag: "search"
        	        }, {
        	            label: "열 고정",
        	            tag: "fixedCol"
        	        }, {
        	            label: "행 고정",
        	            tag: "fixedRow"
        	        }, {
        	            label: "고정 취소",
        	            tag: "fixedCancel"
        	        },
        	        {label	:	"Excel"	, tag:	"exportExcel"}
        	        ];

        	        this.setContextMenu(contextMenu);
            };
            this.setDataCellContextMenu(this);
            this.excelDown = function exportToExcel(grid) {
                this.exportToExcel(grid);
            }
            this.search = function (grid, colName) {

            	var findPopId = this.getGridId() +"_findPop";
            	var oGridFindPop = $("#"+findPopId);
            	var thisObj = this;
            	
            	//찾기 레이어팝업생성
            	if(oGridFindPop.length==0){
                	$("<div id='"+findPopId+ "' class='dialog'>"
//                	   + "<div class='pop-cont'>"
                       + "<div class='text-sch-box'>"
                       + "<input type='text' class='wp100' id='"+findPopId+"Text"+"'/>"
                       + "<div class='text-sch'>"
                           
                       + "<input type='text'   id='"+findPopId+"CntText"+"' value='' disabled 'style='margin-left:3px;'/>"
                       +"<button class='search-icon'      id='btn"+findPopId+"findText'style='margin-left:3px;'></button>"
                       +"<button class='search-icon prev' id='btn"+findPopId+"findPre' disabled style='margin-left:3px;'>이전</button>"
                       +"<button class='search-icon next' id='btn"+findPopId+"findNext' disabled style='margin-left:3px;'>다음</button>"
                       + "</div>"
//                       + "</div>"
                	 +"</div>").appendTo('body');
            	}
            	
                

            	

            	$("#"+findPopId).dialog({
                    autoOpen: false,
                    resizable: false,
                    modal : true,
                    height:110, //팝업 높이
                    width: 360, //팝업 너비 
                    close: function(){
                    	$('.dialog:last').remove();
                    },
                });
            	
            	var thisObj = this;
                $("#btn"+findPopId+"findText").click(function(e) {
                    _gridFnFindText(thisObj,$("#"+findPopId+"Text").val());
                });
                
                //Enter 이벤트
                //keyup 이벤트시 한글만입력한경우 이벤트 두번타개됨
                $("#"+findPopId+"Text").keypress(function(e) {
                	if(e.keyCode == 13){
                       	_gridFnFindText(thisObj,$("#"+findPopId+"Text").val());
                        return false;
                	}
                });

                $("#btn"+findPopId+"findPre").click(function(e) {
                    _gridFnFindPreText(thisObj);
                });
                $("#btn"+findPopId+"findNext").click(function(e) {
                    _gridFnFindNextText(thisObj);
                });
            	

                $("#"+findPopId).dialog().dialog("open");
      		    $(".ui-dialog-title").html("TEXT SEARCH");
    		    $(".pop-head").remove();
            }

		
		//this.setContextMenu((options.contextMenu ==undefined || options.contextMenu.menuList==undefined)?_defaultContextMenu:options.contextMenu.menuList);
	}

	this.createColumnFilter = function (grid, colName) {
        var fieldName = grid.getColumnProperty(colName, "fieldName");
        var distinctValues = dataProvider.getDistinctValues(fieldName);
        var filters = [];

        for (var i = 0; i < distinctValues.length; i++) {
            filters.push({ name: distinctValues[i], criteria: "value = " + "'" + distinctValues[i] + "'" });
        }

        gridView.setColumnFilters(colName, filters);
    }
	
	
	if (options.dynamicResize!==undefined && options.dynamicResize) {
		//console.log( "_gv._name = " + this._gv._name);
		//console.log( "gridDivId = " + options.gridId);
		//console.log( JSON.stringify( _dynamicResizeTarget));
		var isPaging = false;
		if( options.pager !== undefined) {
			isPaging = true;
		}		
		_dynamicResizeTarget.push({gridName:this._gv._name,gridDivId:options.gridId, gridPaging:isPaging});
		
		//console.log( JSON.stringify( _dynamicResizeTarget));
	}
	
	var _pageNavi = "";
    
    if (options.pager!==undefined) {
    	//gridId, page_size, current_page, total_count, search_url
    	if (options.pager.visible!==undefined && options.pager.visible) {
    		if (options.pager.pageSize!==undefined && options.pager.pageSize!='') {
    			_pageSize = options.pager.pageSize;
    		}
    		if (options.pager.pageUnit!==undefined && options.pager.pageUnit!='') {

    			_pageUnit = options.pager.pageUnit;
    		}
    		drawPageNavi(options.gridId, _pageSize, 0, 0, options.pager.searchLink, _pageUnit);
    	}
    }
    
    if (options.viewList!==undefined) {
    	//gridId, page_size, current_page, total_count, search_url
    	if (options.viewList.visible!==undefined && options.viewList) {
    		drawViewList(options.gridId, options.viewList.viewOptions, options.viewList.all);
    	}
    }
    
    
    this.setSoftDeleting = function( isSoftDel) {
    	dataProvider.setOptions({
   	  		softDeleting			: isSoftDel
    	});
    };
    
    this.setProviderOptions = function( option ) {
    	dataProvider.setOptions( option );
    };
    
    this.restoreUpdatedRows = function( rows ) {
    	dataProvider.restoreUpdatedRows( row );
    };
    
    
    this.restoreUpdatedItem = function( itemIndex ) {
    	var rows = [];
    	rows.push(this.getDataRow(itemIndex));
    	dataProvider.restoreUpdatedRows( rows );
    };
    
    
    this.setPageNavi = function(currentPage) {
    	//gridId, page_size, current_page, total_count, search_url
    	drawPageNavi(options.gridId, _pageSize, 0, 0, options.pager.searchLink, _pageUnit);
    };
    
    this.setPageRows = function(data) {
    	//data.appendRecords 건수 많은경우 append 페이지 사용할 경우에만 값이 있음 일반은 없음
    	this.setRows(data.rows, data.records,data.appendRecords);
    	this.setPages(data);
    	this.setAllCheck(false);
    };

    this.setRows = function(rowInfo, records,appendRecords) {
/*    	var _stime = new Date();
    	var _smils = _stime.getMilliseconds();
*/    	
    	dataProvider.setRows(rowInfo);
/*    	var _etime = new Date();
    	var _emils = _etime.getMilliseconds();
    	console.log(options.gridId + ":ELASPED TIME:" + (_emils-_smils));
*/    
    	this.setAllCheck(false);
    	this.resetSize();
    	this.refresh();

    	//*********************************************
    	//그리드에 건수 표시 처리
    	//*********************************************
        //fitwidth,fitstyle
    	//그리드에 건수 표시 여부 확인
   		if(options.viewCount != undefined && options.viewCount == true){
   	        var oGrid = $("#"+options.gridId);
   	        var oParentGrid = oGrid.closest(".realgrid-area");
   	        var oCountDiv = $(oParentGrid).find(".view-count");
	   	     
   	        if(appendRecords != undefined && appendRecords > 0){
   	        	if(oCountDiv.length == 1){
   	   	            oCountDiv.html('<p class="count-desc"><span class="count" id="rowCount">'+dataProvider.getRowCount()+' / ' + appendRecords +'</span> 건이 조회 되었습니다.</p>');
   	   	        }else{
   	   	        	oParentGrid.append('<div class="view-count"></div>')
   	   	            var oCountDiv = $(oParentGrid).find(".view-count");
   	   	            oCountDiv.html('<p class="count-desc"><span class="count" id="rowCount">'+dataProvider.getRowCount()+' / ' + appendRecords +'</span> 건이 조회 되었습니다.</p>');
   	   	        }
   	        }else{
   	        	if(oCountDiv.length == 1){
   	        		oCountDiv.html('<p class="count-desc"><span class="count" id="rowCount">'+dataProvider.getRowCount()+'</span> 건이 조회 되었습니다.</p>');
   	        	}else{
   	        		oParentGrid.append('<div class="view-count"></div>')
   	        		var oCountDiv = $(oParentGrid).find(".view-count");
   	        		oCountDiv.html('<p class="count-desc"><span class="count" id="rowCount">'+dataProvider.getRowCount()+'</span> 건이 조회 되었습니다.</p>');
	   	        }
   	        }
   		}
    	//*********************************************
    	//그리드에 건수 표시 처리
    	//*********************************************
    	
    	this.setDisplayOptions({
   	   		showEmptyMessage : true
   	   		,emptyMessage : '조회된 데이터가 없습니다.'
        });
    };
    
    this.setPages = function(pageInfo) {
    	if (options.pager===undefined || !options.pager) {
    		
    	} else {
    		drawPageNavi(options.gridId, _pageSize, pageInfo.page, pageInfo.records, options.pager.searchLink, _pageUnit);
    		
        	this.setIndicator({
                indexOffset: ( pageInfo.page - 1 ) * _pageSize
            });
    	}
    };

    this.setPageSize = function(size) {
    	_pageSize = size;
    	this.setPaging(true, size);
    };
    
    this.getPageSize = function() {
    	return _pageSize;
    };
    
    this.fieldNameByColumnIndex = function(colIndex) {
    	//return _columnNames[colIndex];
    	var colNames = this.getColumnNames(true);
    	return colNames[colIndex];
    };
    
    this.getDataProvider = function () {
    	return dataProvider;
    };
    
    // dataProvider 의 모든 데이터 (삭제포함)
    this.getAllRows = function () {
    	//dataProvider.clearRowStates(true, false);
    	return dataProvider.getRows();
    };
    
    // 모든 데이터 건수 ( 삭제된 것 포함)
    this.getRowCount = function() {
    	return dataProvider.getRowCount();
    };
    
    
    // 모든 데이터  (삭제된것 포함)
    this.getAllJsonRows = function () {
    	//dataProvider.clearRowStates(true, false);
    	//return dataProvider.getJsonRows(0,-1);
    	return dataProvider.getOutputRows({datetimeFormat: "yyyyMMdd"});
    };
    
    
	// DataProvider상의 데이터를 json으로 return 함. (삭제된 것 제외) 
    this.getAllJsonRowsExcludeDeleteRow = function () {
	    var dataObj = [];
		var dataCnt = this.getRowCount();
		var state = "";
		
		for( var i=0; i<dataCnt ; i++) {
			state = dataProvider.getRowState(i);
			if( !((state == "deleted") || (state == "createAndDeleted")) ) {
				var rowValue = dataProvider.getOutputRow({datetimeFormat: "yyyyMMdd"}, i);
				rowValue.rowId = i;
				rowValue.itemIndex = this.getItemIndex(i);
				dataObj.push(rowValue);
			}
		}
		return dataObj;
    };
    
    
    // view 상에 보이는 데이터 건수(삭제건 제외) 
    this.getItemDataCount = function () {
    	return ( dataProvider.getRowCount() 
    			- dataProvider.getRowStateCount("deleted")
    			- dataProvider.getRowStateCount("createAndDeleted") );
    };
    
    // view 상에 보이는 데이터를 json으로 return 함
    this.getAllJsonItemData = function () {
    	var itemData = [];
    	var itemCnt = this.getItemCount(); // (rowGroup의 header, footer가 있는 경우 itemCount에 포함된다.) 
    	for( var i = 0; i < itemCnt; i++) {
    		var bGroupItem = this.isGroupItem(i);
    		if( bGroupItem == false ) {
	    		//console.log( "i=" + i + " values = " + JSON.stringify(this.getValues(i)));
	    		//itemData.push(this.getValues(i));
	    		var rowValue = dataProvider.getOutputRow({datetimeFormat: "yyyyMMdd"}, this.getValues(i).__rowId);
	    		rowValue.rowId = this.getValues(i).__rowId;
	    		rowValue.itemIndex = i;
	    		itemData.push(rowValue);
    		}
    	}
    	return itemData;
    };
    
    // 지정 row의 상태 
    this.getRowState = function(itemIndex) {
    	return dataProvider.getRowState(this.getDataRow(itemIndex));
    };
    
    // 지정된 rowStates에 해당하는 Row의 건수를 가져온다.
    this.getRowStateCount = function(state) {
    	return dataProvider.getRowStateCount(state);
    };
    
    // 행들의 RowState를 모두 제거
    this.clearRowStates = function (deleteRows, rowEvents) {
    	dataProvider.clearRowStates(deleteRows, rowEvents);
    };
    
    
    this.onShowTooltip = function (grid, index, value) {
        return value;
    };

    this.getCurrentRow = function () {
    	if (this.getCurrent().dataRow!=-1)
    		return dataProvider.getOutputRow({datetimeFormat: "yyyyMMdd"}, this.getCurrent().dataRow);
    };
    
    
    // check 된 rows 를 리턴
    // dataProvider 상의 순서
    this.getSelectedRows = function () {
    	var checkedRows = this.getCheckedRows(false, false, true);   
    	
    	//console.log( "getSelectedRows = " + JSON.stringify(checkedRows));
    	var state;
        var jData;
    	var jRowsData = [];
    	
    	var gridObj = this;
    	
    	if (checkedRows.length > 0) {
    		checkedRows.forEach(function (row){
    			//jData = dataProvider.getJsonRow(row);
    			jData = dataProvider.getOutputRow({datetimeFormat: "yyyyMMdd"}, row);
    			jData.state = "selected";
    			jData.rowId = row;
    			jData.itemIndex = gridObj.getItemIndex(row);
                jRowsData.push(jData);
			});
    	} else {
    		return jRowsData;
    	}
    	
    	return jRowsData;
    };

    // check 된 rows 를 리턴
    // gridView 상의 순서
    this.getSelectedItems = function () {
    	var checkedRows = this.getCheckedItems(false);
    	//console.log( "checkedRows = " + JSON.stringify(checkedRows));
        var jData;
    	var jRowsData = [];
    	
    	var pThis = this;
    	
    	if (checkedRows.length > 0) {
    		checkedRows.forEach(function (i){
    			//jData = dataProvider.getJsonRow(row);
    			var rowId = pThis.getValues(i).__rowId;
    			jData = dataProvider.getOutputRow({datetimeFormat: "yyyyMMdd"}, rowId);
    			jData.state = dataProvider.getRowState(rowId);
    			jData.rowId = rowId;
    			jData.itemIndex = i;
    			
                jRowsData.push(jData);
			});
    	} else {
    		return jRowsData;
    	}
    	
    	return jRowsData;
    };
    
   
    // row의 상태 변경
    this.setRowState = function(row, state){
    	dataProvider.setRowState(row, state, false);
    };
    
    // grid 데이터 변경여부
    this.isDataChanged = function() {
    	var cnt = dataProvider.getRowStateCount("created");
    	if( cnt > 0 ) {
    		return true;
    	}
    	
    	cnt = dataProvider.getRowStateCount("updated");
    	if( cnt > 0 ) {
    		return true;
    	}
    	
    	cnt = dataProvider.getRowStateCount("deleted");
    	if( cnt > 0 ) {
    		return true;
    	}
    	
    	return false;
    };    
    
    
    this.getStateRows = function(state) {
    	var state;
        var jData;
        var jResponse = {};
        var isDataExist = false;
        
        var gridObj = this;
        
    	var rows;
    
    	if (state != null && state != '') {
    		if (state != "created" && state != "updated" && state != "deleted") {
    			alert("잘못된 인수입니다.\n사용 인수는 아래와 같습니다.\n\ncreated\nupdated\ndeleted");
    			return;
    		} else {
    			rows = dataProvider.getStateRows(state);
    			
    			var jRowsData = [];
    			
    			if (rows.length > 0) {
    				
        			rows.forEach(function (r){
        				//jData = dataProvider.getJsonRow(r);
        				jData = dataProvider.getOutputRow({datetimeFormat: "yyyyMMdd"}, r);
        				jData.rowId = r;
            			jData.itemIndex = gridObj.getItemIndex(r);
    	    			jRowsData.push(jData);
    				});
        			
        			isDataExist = true;
    	    	} else {
    	    		return null;
    	    	}
    			jResponse[state.toUpperCase()] = jRowsData;
    			//$.extend(jResponse, {state:jRowsData});
    		}
    	} else {
    		rows = dataProvider.getAllStateRows();

    		if (rows.updated.length > 0) {
        		var jRowsData = [];
                $.each(rows.updated, function(k, v) {
                    //jData = dataProvider.getJsonRow(v);
                	jData = dataProvider.getOutputRow({datetimeFormat: "yyyyMMdd"}, v);
                    jData.state = "updated";
                  	jData.rowId = v;
        			jData.itemIndex = gridObj.getItemIndex(v);                    
                    jRowsData.push(jData);
                });
                $.extend(jResponse, {"UPDATED":jRowsData});
                isDataExist = true;
        	}

    		if (rows.deleted.length > 0) {
            	var jRowsData = [];
                $.each(rows.deleted, function(k, v) {
                    //jData = dataProvider.getJsonRow(v);
                    jData = dataProvider.getOutputRow({datetimeFormat: "yyyyMMdd"}, v);
                    jData.state = "deleted";
                	jData.rowId = v;
        			jData.itemIndex = gridObj.getItemIndex(v);                    
                    jRowsData.push(jData);
                });
                $.extend(jResponse, {"DELETED":jRowsData});
                isDataExist = true;
            }

            if (rows.created.length > 0) {
            	var jRowsData = [];
                $.each(rows.created, function(k, v) {
                    //jData = dataProvider.getJsonRow(v);
                    jData = dataProvider.getOutputRow({datetimeFormat: "yyyyMMdd"}, v);
                    jData.state = "created";
                	jData.rowId = v;
        			jData.itemIndex = gridObj.getItemIndex(v);                    
                    jRowsData.push(jData);
                });
                $.extend(jResponse, {"CREATED":jRowsData});
                isDataExist = true;
            }
            
            /*
            if (jResponse.length == 0) {
                dataProvider.clearRowStates(true);
                return;
            }
            */
    	}
    	
    	if (isDataExist) return jResponse;
    	return null;
    };
    
    // update 된 row 조회
    this.getUpdateRows = function () {
    	rows = dataProvider.getStateRows("updated");

    	var gridObj = this;
        var jRowsData = [];
		if (rows.length > 0) {
			var i = 0;
			rows.forEach(function (r){
				var jData = dataProvider.getOutputRow({datetimeFormat: "yyyyMMdd"}, r);
				jData.rowId = r;
				jData.itemIndex = gridObj.getItemIndex(r);
    			jRowsData.push(jData);
    			i++;
			});
    	} 
    	
		return jRowsData;

    };
    
    // delete 된 row 조회
    this.getDeleteRows = function () {
    	var rows = dataProvider.getStateRows("deleted");

    	var gridObj = this;
        var jRowsData = [];
		if (rows.length > 0) {
			var i = 0;
			rows.forEach(function (r){
				var jData = dataProvider.getOutputRow({datetimeFormat: "yyyyMMdd"}, r);
				jData.rowId = r;
				jData.itemIndex = gridObj.getItemIndex(r);
    			jRowsData.push(jData);
    			i++;
			});
    	} 
    	
		return jRowsData;
    };
    
    // 여러 라인 삭제
    // rowId 배열
    this.deleteRows = function (rowIds) {
    	if (rowIds.length > 1) {
    		/*var _rows = [];
    		$.each(rows, function(r) {
    			_rows.push(this.getValues(r).__rowId);
    		});*/
    		dataProvider.removeRows(rowIds, true);
    	} else {
    		dataProvider.removeRow(rowIds);
    	}
    };
    
    
    // 한라인 삭제
    this.deleteRow = function (itemIndex) {
   		dataProvider.removeRow(this.getDataRow(itemIndex));
    };
    
    
    this.deleteSelectedRows = function() {
    	var _rows = this.getCheckedRows();
    	dataProvider.removeRows(_rows, true);
    };
    
    //현재 포커싱된 row 삭제
    this.deleteCurrentRow = function() {
    	var param = [];
    	param.push(this.getCurrent().dataRow);
    	dataProvider.removeRows(param, true);    	
    };
      
    this.exportToExcel = function(excelOptions) {
    
    	this.exportGrid({
    		 type 				: "excel"
    		,target				: "local"
    		,fileName			: excelOptions.fileName
    		,lookupDisplay      : excelOptions.lookupDisplay != null?excelOptions.lookupDisplay:false
    		,showProgress		: true
    		,progressMessage	: "Excel 생성중입니다."
    		,applyDynamicStyles	: true
    		,indicator			: "hidden"
	        ,header				: "default"
	        ,footer				: "default"
	        ,compatibility		: true //true:2007, false:2010
	        ,done				: excelOptions.doneCallBack!=null?excelOptions.doneCallBack:function() { alert("엑셀 다운이 완료되었습니다."); }
	        
    	});
    	/*
        this.exportGrid({
			 type				: "excel"
			,target				: "remote"
			,url				: getContextPath()+"/ExcelXBin.do"
			,fileName			: excelOptions.fileName
			,showProgress		: true
			,applyDynamicStyles	: true
			,progressMessage	: "엑셀 Export중입니다."
			,indicator			: true
			,header				: true
			,footer				: true
			,compatibility		: true //true:2007, false:2010
			,done				: excelOptions.doneCallBack!=null?excelOptions.doneCallBack:function() { alert("엑셀 다운이 완료되었습니다."); }
        });
    	*/
    };
    
    this.clearRows = function() {
    	var params = {};
    	params.page = 1;
    	params.records = 0;
    	params.pageSize = _pageSize;
    	this.setPages(params);
    	dataProvider.clearRows();    	
    };

    
    this.setColumnFix = function (fixCount, rightFixCount) {
		var options = new RealGridJS.FixedOptions();
		options.colCount = fixCount;
		options.rightColCount = rightFixCount;
		this.setFixedOptions(options);
    };
    
    this.setRowFix = function (fixRow) {
		this.setOptions({ fixed: { rowCount: fixRow }});
    };
    
    this.addRow = function (row) {
    	var _row = {};
    	if(typeof row == 'string'){
			_row[row] = "";
		}else if(typeof row == 'object'){
			_row = row;
		}
    	return dataProvider.addRow(_row);
    };
    
    this.addRows = function (rows, records) {
    	dataProvider.addRows(rows, 0, -1);
    	
    	if(options.viewCount != undefined && options.viewCount == true && records != undefined && records > 0){
    		var oGrid = $("#"+options.gridId);
   	        var oParentGrid = oGrid.closest(".realgrid-area");
   	        var oCountDiv = $(oParentGrid).find(".view-count");
   	        if(oCountDiv.length == 1){
   	            oCountDiv.html('<p class="count-desc"><span class="count" id="rowCount">'+dataProvider.getRowCount()+' / ' + records +'</span> 건이 조회 되었습니다.</p>');
   	        }else{
   	        	oParentGrid.append('<div class="view-count"></div>')
   	            var oCountDiv = $(oParentGrid).find(".view-count");
   	            oCountDiv.html('<p class="count-desc"><span class="count" id="rowCount">'+dataProvider.getRowCount()+' / ' + records +'</span> 건이 조회 되었습니다.</p>');
   	        }
   		}
    };
    
    this.insertRow = function(row, values, itemIndex) {
    	dataProvider.insertRow(row, values, itemIndex);
    };
    
    
    /*
    this.onContextMenuPopup = function (grid, x, y, elementName) {
        return elementName != "HeaderCell";
    };
    this.onContextMenuItemClicked = function (grid, label, index) {
        //alert("Context menu가 클릭됐습니다: " + label.label + "\n" + JSON.stringify(index));
    	if (label.tag == "searchVal") {
    	    this.setColumnFix(index.fieldIndex);
        }else if (label.tag == "columnFix") {
    	    this.setColumnFix(index.fieldIndex);
        } else if (label.tag == "rowFix") {
        	this.setRowFix(index.itemIndex);
        } else if (label.tag == "cancelFix") {
        	this.setColumnFix(0);
        	this.setRowFix(0);
        } else {
        	
        }
    };
 */
    
    this.getHeaderHeight = function () {
    	return options.headerHeight==undefined?_defaultHeaderHeight:options.headerHeight;
    };
    
    this.getRowHeight = function () {
    	return options.rowHeight== undefined?_defaultRowHeight:options.rowHeight;
    };
    
    this.getTotalColumnWidth = function () {
    	var _displayColumns = this.getColumnNames();
    	var _totalColumnWidth = 0;
    	for (var _dc in _displayColumns) {
    		_totalColumnWidth += this.getColumnProperty(_displayColumns[_dc],"width");
    	}
    	
    	if (this.getCheckBar().visible) _totalColumnWidth+=this.getCheckBar().width;
    	if (this.getIndicator().visible) _totalColumnWidth+=this.getIndicator().width;
    	if (this.getStateBar().visible) _totalColumnWidth+=this.getStateBar().width;
    		
    	return _totalColumnWidth;
    };
    
    this.getGridId = function() {
    	return options.gridId;
    };
    
    //{key:value,key:value,...} 형식의 Row data 를 받아서 현재 Grid 에 중복된 데이터가 있는지 체크후 
    //해당 Row 값 반환 중복된 데이터가 없을때 -1 반환
    this.existCheck = function(data){
    	var rows = [];
    	var arrFields = [];
    	var arrValues = [];
    	//중복체크 하기 위한 형식으로 변환
    	//var options = { fields:['field1', 'field2'], values:['value1', 'value2'] }
    	for(key in data){
    		arrFields.push(key);
    		arrValues.push(data[key]);
    	}
    	var options = {fields:arrFields, values:arrValues};
    	return this.searchItem(options);
    };
    
    /*
     * 선택된 행의 특정 컬럼의 값을 검사해서 지정한 컬럼 값을 반환함.
     * col : 값 비교할 컬럼
     * val : 비교 값
     * rtnCol : 리턴 컬럼
     */
    this.selectedRowsCheckColumnValue = function(col, val, rtnCol){
    	var selectedList = this.getSelectedRows();
    	var dectedRow = [];
    	
    	if(selectedList != null && selectedList.length > 0 ){
    		for(var i =0 ; i < selectedList.length ; i++){
    			
    			var data  = selectedList[i];
    			
    			for(key in data){
    				if(typeof val == 'string'){
    					if(key == col && data[key] == val){
    						
    						if(rtnCol == null || rtnCol == undefined){
    							dectedRow.push(selectedList[i]);
    						}else{
    							if(data[rtnCol] != undefined){
        							dectedRow.push(data[rtnCol]);
    							}
    						}	
        				}
    				}else if(typeof val == 'object'){    				
    					if(key == col && val == null && data[key] == null ){
    						if(rtnCol == null || rtnCol == undefined){
    							dectedRow.push(selectedList[i]);
    						}else{
    							dectedRow.push(data[rtnCol]);
    						}
    					}else{
	    					if(key == col && val.indexOf(data[key]) > -1){
	    						if(rtnCol == null || rtnCol == undefined){
	    							dectedRow.push(selectedList[i]);
	    						}else{
	    							dectedRow.push(data[rtnCol]);
	    						}
	    					}
    					}
    				}
//    				if(typeof val == 'string'){
//    					if(key == col && data[key] == val){
//    						
//    						if(rtnCol == null || rtnCol == undefined){
//    							dectedRow.push(selectedList[i]);
//    						}else{
//    							if(data[rtnCol] != undefined){
//        							dectedRow.push(data[rtnCol]);
//    							}
//    						}	
//        				}
//    				}else if(typeof val == 'object'){
//    					if(val.indexOf(data[key]) > -1){
//    						if(rtnCol == null || rtnCol == undefined){
//    							dectedRow.push(selectedList[i]);
//    						}else{
//    							dectedRow.push(data[rtnCol]);
//    						}
//    					}	
//    				}
	        	}	
    		}
    	}
    	return dectedRow;
    };
    
    this.getRowValue = function( rowId, field) {
    	return dataProvider.getValue(rowId, field);
    };
    
    this.setRowValue = function( rowId, field, value) {
    	dataProvider.setValue(rowId, field, value);
    };
    
    
    //setValue와 setValues 를 합쳐놓음.
    this.setSelectedRowValues = function(col, val, strict){
    	if(typeof strict == undefined){
    		//변경되는 값이 undefined 일때 기존값 유지 여부
    		//true : 기존값유지 , false: 변경
    		strict = true;
    	}
    	var itemIndex = this.getCurrent().itemIndex;
    	if(col.constructor === String && val.constructor === String){
    		this.setValue(itemIndex, col, val);
    	}else if(col.constructor === Array && val.constructor === Array){
    		var values={};
    		if(col.length == val.length){
    			for(key in col){
    				values[col[key]] = val[key];
    			}
    			this.setValues(itemIndex, values, strict);
    		}else{
    			console.log("error : 컬럼배열 길이와 값배열 길이가 다릅니다.");
    		}
    	}
    };
    
    
    /*
     * 컬럼 값이 val 인 Rows를 리턴한다.
     * col : 검색 컬럼 배열
     * val : 검색값(문자열) 배열
     */
    this.findRows = function(col, val){
    	var selectedList = this.getAllJsonRowsExcludeDeleteRow();
    	var retRows = [];
    	
    	if(selectedList != null && selectedList.length > 0 ){

    		for(var i =0, nSize = selectedList.length; i < nSize ; i++){
    			var isFlag = false;
    			var data  = selectedList[i];
    			
    			for( j = 0; j < col.length; j++ ) {
    				var colVal = "" + data[col[j]];
    				if( colVal == val[j]) {
    					isFlag = true;
    				} else {
    					isFlag = false;
    				
    					break;
    				}
    			}
    			/*
    			var colVal = "" + data[col];

    			if( colVal == val) {
    				retRows.push( data);
    			}
    			*/
    			if( isFlag == true ) {
    				retRows.push(data);
    			}
    		}
    	}
    	return retRows;
    };
    
    /*
     * 컬럼 값이 val 인 Rows의 itemIndex 리턴한다.
     * col : 검색 컬럼 배열
     * val : 검색값(문자열) 배열
     */
    this.findRowsIndex = function(col, val){
    	var selectedList = this.getAllJsonRowsExcludeDeleteRow();
    	var retRows = [];
    	
    	if(selectedList != null && selectedList.length > 0 ){
    		for(var i =0, nSize = selectedList.length; i < nSize ; i++){
    			var isFlag = false;
    			var data  = selectedList[i];
    			for( j = 0; j < col.length; j++ ) {
    				var colVal = "" + data[col[j]];
    				if( colVal == val[j]) {
    					isFlag = true;
    				} else {
    					isFlag = false;
    				
    					break;
    				}
    			}
    			/*
    			var colVal = "" + data[col];

    			if( colVal == val) {
    				retRows.push(data.rowId);
    			}*/
    			if( isFlag == true ) {
    				retRows.push(data.rowId);
    			}
    		}
    	}
    	return retRows;
    };
    
    /*
     * 컬럼 값이 val 인 Rows를 리턴한다.
     * col : 검색 컬럼
     * val : 검색값(문자열)
     */
    this.findItems = function(col, val){
    	var selectedList = this.getAllJsonItemData();
    	var retRows = [];
    	
    	if(selectedList != null && selectedList.length > 0 ){
    		for(var i =0, nSize = selectedList.length; i < nSize ; i++){
    			
    			var data  = selectedList[i];
    			var colVal = "" + data[col];

    			if( colVal == val) {
    				retRows.push( data);
    			}
    		}
    	}
    	return retRows;
    };
    
    /*
     * 컬럼 값이 val 인 Rows의 itemIndex 리턴한다.
     * col : 검색 컬럼
     * val : 검색값(문자열)
     */
    this.findItemsIndex = function(col, val){
    	var selectedList = this.getAllJsonItemData();
    	var retRows = [];
    	
    	if(selectedList != null && selectedList.length > 0 ){
    		for(var i =0, nSize = selectedList.length; i < nSize ; i++){
    			
    			var data  = selectedList[i];
    			var colVal = "" + data[col];

    			if( colVal == val) {
    				retRows.push(data.itemIndex);
    			}
    		}
    	}
    	return retRows;
    };
    
    this.searchDataRow = function( options) {
    	return dataProvider.searchDataRow(options);
    };
    
    this.addCellStyles([{
	    id: "editTrueStyle",
	    editable: true
	},{
	    id: "editFalseStyle",
	    editable: false
	}]);
    
    this.setColumnEditStatus = function (columns, editFlag){
    	var editStyle="";
    	if(editFlag == true){
    		editStyle = "editTrueStyle";
    	}else if(editFlag == false){
    		editStyle = "editFalseStyle";
    	}
    	
    	var current = this.getCurrent();
    	
		this.setCellStyles([current.itemIndex],columns,editStyle);
    };
    
    
    // 특정 row수에 맞게 높이 조정 ( default 전표 row수 )
    this.fitGridHeightByRow = function(rowCnt) {
    	var rowHeight  = this.getRowHeight();
    	
    	var headerHeight =  this.getHeaderHeight();
    	var panelheight = 0;
    	var footerHeight = 0;
    	
    	/*
    	var scrollbarHeight = 0;
    	if( this.getTotalColunWidth() > $("#" + this.getGridId()).width() ) {
    		scrollbarHeight = 25;
    	}
    	*/
    	var scrollbarHeight = 0;
    	
    	//console.log( "rowHeight = " + rowHeight + ", headerHeight = " + headerHeight);
    	
    	var maxRowCnt = this.getItemDataCount();
    	if( isNotEmpty( rowCnt) ) {
    		maxRowCnt = rowCnt
    	}
    	
    	if( maxRowCnt == 0 ) {
    		maxRowCnt = 1;
    	}
    	
    	//console.log( "maxRowCnt = " + maxRowCnt );
    	
    	var maxHeight = headerHeight + ( rowHeight * maxRowCnt) + panelheight + footerHeight + scrollbarHeight +2;
    	
    	//console.log( "maxHeight = " + maxHeight );
    	
    	//$("#" + divId ).css( "height", maxHeight + "px");
    	$("#" + this.getGridId() ).css( "height", maxHeight + "px");
    	this.resetSize();
    }
    
    
    //화면에 있는 그리드 목록 추가
    //달력으로 값입력시 변경값 반영안되는 부분 처리 위함
    //화면에서 클릭 이벤트 발생시 대상이 그리드가 아닌경우에는 그리드 데이터를 commit
    g_gridList.push(this);
	$(document).click(function(e) {
		  var isGrid = isGridAreaEvent(e, g_gridList);
	});

    
	if(options.autoHResize != undefined && options.autoHResize == true){
		var autoHResizeOpt  = 0;
		if(options.autoHResizeOpt != undefined){
			autoHResizeOpt = options.autoHResizeOpt;   
		}
		
	    //동적 높이 설정
		var height = ( window.innerHeight                                                                    //윈도우 높이
				     - 5
				     - $("#" + this.getGridId()).prop("offsetTop")                                           //그리드 위쪽에 컴포넌트 높이(조회조건등)
				     - autoHResizeOpt
				     - ($(".header").length == 1 ? $(".header").css("height").replace(/[^-\d\.]/g, '') : 50)  //헤더 영역 높이(px 제거하는 정규식) 팝업에경우는 헤더가 없을수 있음(footer size -50)
				     );
		//최초 그리드 높이 지정보다 작아 지면 조절 안함		  
        if(options.height < height){
    	    $("#" + this.getGridId()).css("height",height + "px");
    	    this.resetSize();
        }				     
		var gridId = this.getGridId();
		var optionsHeight = options.height
		var oObj = this
	    $(window).resize(function(){
			var height = ( window.innerHeight                                                                //윈도우 높이
				     - 5
				     - $("#" + gridId).prop("offsetTop")                                                     //그리드 위쪽에 컴포넌트 높이(조회조건등)
				     - autoHResizeOpt
				     - ($(".header").length == 1 ? $(".header").css("height").replace(/[^-\d\.]/g, '') : 50) //헤더 영역 높이(px 제거하는 정규식) 팝업에경우는 헤더가 없을수 있음(footer size -50)
				     );
			//최초 그리드 높이 지정보다 작아 지면 조절 안함		  
			if(optionsHeight < height){
		    	$("#" + gridId).css("height",height + "px");
		    	oObj.resetSize();
			}
	            
	   }); 
		
	}
};




var basicCheckColumn = function (options) {
	// type: "check", editable:true, startEditOnClick: true, shape: "box", trueValues:"Y", falseValues: "N"
    //var defaults = {url:getContextPath() + '/upload/file.do', CALLBACK:'fnCallBackFileUpload', DATA_FORMAT:'raw'};
    var defaults = {type:"check", editable:true, startEditOnClick:true, shape:"box", trueValues:"Y", falseValues:"N"};
    for(var prop in defaults) {
        options[prop] = typeof options[prop] !== undefined ? options[prop] : defaults[prop];
    }
    return options;
};


/**
 * grid fouce out 시 grid commit;
 */
var isGridAreaEvent = function(e, gridObjs) {
	//var eValue = e.target;
	//var eParentNodeValue = e.target.parentNode;
	var isGrid = false;

	
	
	if( e.target instanceof HTMLCanvasElement ) {
		isGrid = true;
	} else {
		var csName = e.target.className;
		if( csName != "rg-cal-days") {
			if( csName.indexOf("rg-cal") >= 0 ) {
				isGrid = true;
			} 
		}
		
		if( isGrid == false ) {
			var outerHtml = e.target.parentNode.outerHTML;
			//console.log( "outerHtml = " + outerHtml);
			if( isNotEmpty(outerHtml) ) {
				if( outerHtml.indexOf("realgrid") > 0) {
					//console.log("is Exist realgrid ");
			
					isGrid = true;
				}
			}
			
			if( isGrid == false ) {
				
				if( isNotEmpty(e.target.parentNode.previousSibling)) {
					//console.log( typeof(e.target.parentNode.previousSibling));
					//console.log( e.target.parentNode.previousSibling);
					//console.log( Object.keys(e.target.parentNode.previousSibling));
					if (e.target.parentNode.previousSibling.nodeName == "CANVAS") {
						//console.log("is parent canvas ");
						isGrid = true;
					}
					
					if( isGrid == false ) {
						if( isNotEmpty(e.target.parentNode.previousSibling.previousSibling)) {
							if (e.target.parentNode.previousSibling.previousSibling.nodeName == "CANVAS") {
								//console.log("is parent canvas ");
								isGrid = true;
							}
						}
					}
					
				}
			}
		}
	}

	if( isGrid == false) {
		
		if( isNotEmpty(gridObjs) ) {
			for( var i = 0 ; i < gridObjs.length ; i++ ) {
				var gridObj = gridObjs[i];
				
				if( isNotEmpty(gridObj)) {
					gridObj.commit();
					//console.log("*************** " + gridObj.getGridId() + " Committed ***********");
				}
			}
		}
	}
	
	return isGrid;
};



// double click 시 click 중복 발생 방지
var _grid_clickState_ = null; 

function fnGridCellClicked( procFunction )  {
	clearTimeout(_grid_clickState_);

	_grid_clickState_ = setTimeout(function() {
		//console.log( "####### fnGridCellClicked procFunction start" );
		
		procFunction();
		
		//console.log( "####### fnGridCellClicked procFunction end" );
	}, 300);
}





/*****************************************************************************
 * 그리드 내에 문자 검색 시작
 ****************************************************************************/
var grdFindTextRows = [];

function _gridFnFindText(gridView,pSearchText){

	grdFindTextRows = [];
	var selectedList = gridView.getAllJsonRowsExcludeDeleteRow();
	var col = gridView.getColumns();
	var dpCol = gridView.getDisplayColumns();
	
	var curItem = gridView.getCurrent();

	//현재 포커스 보여지는 컬럼순서
	for(var kk=0;kk <dpCol.length;kk++){
		if(dpCol[kk] == curItem.column){
			curItem.displayIndex = kk;
		}
	}	
	
	//대소문자 구분 안함
	var searchText = pSearchText.toUpperCase();
	
	if(selectedList != null && selectedList.length > 0 ){
		var nRow = selectedList.length;
		
		
		for(var ii =0; ii < nRow ; ii++){
			var isFlag = false;

			var data;   

			//화면에 보이는 순서대로에 행찾기위해(헤더로 이용 정렬한경우)
			for(var jj=0; jj < nRow ; jj++){
				var cpData  = selectedList[jj];
				if(cpData.itemIndex == ii){
					data = cpData;
					break;
				}
			}

			
			//보여지는 컬럼 단위로 루핑
			for(var kk=0;kk <dpCol.length;kk++){
				//컬럼 메타 데이터
				for(var mm=0;mm < col.length; mm++){
					if(dpCol[kk] == col[mm].name){
						var colVal = "" + eval("data."+col[mm].name);
						colVal = colVal.toUpperCase();
						//문자열이 포함된경우
						if( colVal.indexOf(searchText) > -1) {
							grdFindTextRows.push({rowid       :data.rowId
								                 ,colIdx      :col[mm].dataIndex
								                 ,itemIndex   :data.itemIndex
								                 ,displayIndex:kk
								                 });
						} 
					}
					
				}
			}
		}
	}

	var findTimes = 0;
	for(var ii=0;ii < grdFindTextRows.length;ii++){
		var oRow = grdFindTextRows[ii];
		if((oRow.itemIndex * 1000000 + oRow.displayIndex) >  (curItem.itemIndex * 1000000 + curItem.displayIndex)){
			//console.log(oRow.itemIndex + ":"+oRow.displayIndex +"    "+curItem.itemIndex + ":"+curItem.displayIndex)
			findTimes = ii + 1;
			var index = {
				    dataRow: grdFindTextRows[ii].rowid,
				    fieldIndex :grdFindTextRows[ii].colIdx
				};
			//console.log(selectedList);
			//console.log(index);
			gridView.setCurrent(index);
			break;
		}

	}
	
	if(grdFindTextRows.length==0){
		$("#btn"+gridView.getGridId()+"_findPopfindPre").attr('disabled', true);
		$("#btn"+gridView.getGridId()+"_findPopfindNext").attr('disabled', true);
	}else{
		$("#btn"+gridView.getGridId()+"_findPopfindPre").attr('disabled', false);
		$("#btn"+gridView.getGridId()+"_findPopfindNext").attr('disabled', false);
	}
	
	$("#"+gridView.getGridId()+"_findPopCntText").val(findTimes+"/"+grdFindTextRows.length);
}


function _gridFnFindNextText(gridView){
	var dpCol = gridView.getDisplayColumns();
	var curItem = gridView.getCurrent();
	//현재 포커스 보여지는 컬럼순서
	for(var kk=0;kk <dpCol.length;kk++){
		if(dpCol[kk] == curItem.column){
			curItem.displayIndex = kk;
		}
	}	
	
	var findTimes = 0;
	for(var ii=0;ii < grdFindTextRows.length;ii++){
		var oRow = grdFindTextRows[ii];
		if((oRow.itemIndex * 1000000 + oRow.displayIndex) >  (curItem.itemIndex * 1000000 + curItem.displayIndex)){
			findTimes = ii + 1;
			var index = {
				    dataRow: grdFindTextRows[ii].rowid,
				    fieldIndex :grdFindTextRows[ii].colIdx
				};
			gridView.setCurrent(index);
			break;
				
		}
		//끝까지 찾으면 순환
		if(ii==grdFindTextRows.length-1){
			findTimes = 1;
			var index = {
				    dataRow: grdFindTextRows[0].rowid,
				    fieldIndex :grdFindTextRows[0].colIdx
				};
			gridView.setCurrent(index);
		}

	}
	
	$("#"+gridView.getGridId()+"_findPopCntText").val(findTimes+"/"+grdFindTextRows.length);
}


function _gridFnFindPreText(gridView){
	var dpCol = gridView.getDisplayColumns();
	var curItem = gridView.getCurrent();
	//현재 포커스 보여지는 컬럼순서
	for(var kk=0;kk <dpCol.length;kk++){
		if(dpCol[kk] == curItem.column){
			curItem.displayIndex = kk;
		}
	}	
	
	var findTimes = 0;
	for(var ii=grdFindTextRows.length-1 ;ii >= 0 ;ii--){
		var oRow = grdFindTextRows[ii];
		if((oRow.itemIndex * 1000000 + oRow.displayIndex) <  (curItem.itemIndex * 1000000 + curItem.displayIndex)){
			findTimes = ii + 1;
			var index = {
				    dataRow: grdFindTextRows[ii].rowid,
				    fieldIndex :grdFindTextRows[ii].colIdx
				};
			gridView.setCurrent(index);
			break;
		}
		//처음까지 찾으면 순환
		if(ii==0){
			findTimes = grdFindTextRows.length;
			var index = {
				    dataRow: grdFindTextRows[grdFindTextRows.length-1].rowid,
				    fieldIndex :grdFindTextRows[grdFindTextRows.length-1].colIdx
				};
			gridView.setCurrent(index);
			
		}

	}
	$("#"+gridView.getGridId()+"_findPopCntText").val(findTimes+"/"+grdFindTextRows.length);
}

/*****************************************************************************
 * 그리드 내에 문자 검색 끝
 ****************************************************************************/
