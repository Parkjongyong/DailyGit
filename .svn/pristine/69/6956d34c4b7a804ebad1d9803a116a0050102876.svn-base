/*
 * rgrid.js가 선행되어 있어야 함.
RealGridJS.setTrace(false);
RealGridJS.setRootContext(getContextPath() + "/resources/lib/realgrid");
*/

RealGridJS.TreeView.prototype.rtgrid = function (options) {
	var _indicatorDp = "index";
	var _selectStyle = "singleRow";
	var _datetimeFormat = "yyyy-MM-dd";
	var _dbDateTimeFormat = "yyyyMMddhhmmss";
	var _numberFormat = '#,##0.##';
	var _integerFormat = '#,##0';
	var _defaultRowHeight = 30;
	var _defaultHeaderHeight = 30;
	var _columnNames;
	var _gridDefaultWith = "100%";
	var _defaultFitStyle = "none";
	
	// pagesize
	var _pageSize		= _G_PAGE_SIZE;
	
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
	
	var dataProvider = new RealGridJS.LocalTreeDataProvider();
	this.setDataSource(dataProvider);  

	options = options || {};
	
	//DB로 부터의 날짜 포멧옵션 기본은 "YYYYMMDDHH24MISS"
	dataProvider.setOptions({
         datetimeFormat			: options.sqlDateTimeFormat == undefined?_dbDateTimeFormat:options.sqlDateTimeFormat      
        ,commitBeforeDataEdit	: true
    });
	
	if (options.editable!==undefined && options.editable) {
		//console.log("dataprovider edit mode setting");
		dataProvider.setOptions({
		  	 softDeleting			: true
		  	,deleteCreated			: true 				
		});
	}
    
	if (options.width !== undefined) _gridDefaultWith = options.width;
	else if (options.width === undefined || options.width  === "100%") {
		//console.log(this._gv._name + "/ [%o]", this); //_gv._container._containerDiv.id
		_dynamicResizeTargetWidth.push({gridName:this._gv._container._containerDiv.id,gridDivId:options.gridId});
	}
	
	if (options.gridId !== undefined) {
		$("#"+options.gridId).css({ width: _gridDefaultWith, height: options.height });
	}
	
	if (options.columns === undefined) {
    	alert("정의된 컬럼이 없습니다.");
    	return;
    }
    
    var _fields = [];
    var _columns = [];
    	
    for (var cols=0;cols<options.columns.length;cols++) {
    	var _curColumn = options.columns[cols];
    	
    	if (_curColumn.dataType == "datetime") {
    		_fields.push({fieldName:_curColumn.fieldName, dataType:_curColumn.dataType});
    	} else if (_curColumn.dataType == "textLink" || _curColumn.dataType == "fileLink") { 
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
    		if (_curColumn.dataType == 'number') {
    			_tmpCol["styles"] = {textAlignment:_curColumn.styles.textAlignment==null?'_far':_curColumn.styles.textAlignment,numberFormat:_curColumn.styles.numberFormat==null?_numberFormat:_curColumn.styles.numberFormat};
    		} 
    		else if (_curColumn.dataType == 'integer') {
    			_tmpCol["styles"] = {textAlignment:_curColumn.styles.textAlignment==null?'_far':_curColumn.styles.textAlignment,numberFormat:_curColumn.styles.numberFormat==null?_integerFormat:_curColumn.styles.numberFormat};
    		}
    		else if (_curColumn.dataType == 'datetime') {
    			_tmpCol["styles"] = {textAlignment:'center',datetimeFormat:_curColumn.styles.datetimeFormat==null?_datetimeFormat:_curColumn.styles.datetimeFormat};
    		}
    		else if (_curColumn.dataType == 'text') {
    			_tmpCol["styles"] = _curColumn.styles;
    		}
    		else if (_curColumn.dataType == 'textLink') {
    			_tmpCol["styles"] = _curColumn.styles;
    			if (null==_curColumn.styles.fontUnderline) _tmpCol["styles"]["fontUnderline"] = true;
    			if (null==_curColumn.styles.foreground) _tmpCol["styles"]["foreground"] = "#0000ff"; 
    		}
    		else if (_curColumn.dataType == 'fileLink') {
    			_tmpCol["styles"] = _curColumn.styles;
    		}
    		else _tmpCol["styles"] = {textAlignment:'center'};
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
    		}
    		else if (_curColumn.dataType == 'fileLink') {
    			_tmpCol["styles"] = {textAlignment:"far"};
    			_tmpCol["button"] = "action"; 
    			_tmpCol["buttonVisibility"] = "always";
    			//_tmpCol["imageButtons"] = _fileDownIcon;
    			_tmpCol["editable"] = false;
    		}
    		else if (_curColumn.dataType == 'popupLink') {
    			_tmpCol["styles"] = {textAlignment:"far"};
    			_tmpCol["button"] = "image";
    			_tmpCol["buttonVisibility"] = "always";
    			_tmpCol["imageButtons"] = _detailIcon;
    			_tmpCol["editable"] = false;
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
    		    	   ,datetimeFormat: _datetimeFormat
        			}
        		}	
            } else if (_curColumn.editType === 'dropDown') {
            	if (_curColumn.editOption != null) {
        			_tmpCol["editor"] = _curColumn.editOption;
        		} else {
        			_tmpCol["editor"] = {
    					 type		: "dropDown"
    					,domainOnly	: true	 
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
    	,sorting	:{handleVisibility:"visible"	, enabled:options.sortEnabled==undefined?true:options.sortEnabled	}
    	,body		:{rowStylesFirst:options.rowStylesFirst	== undefined?false:options.rowStylesFirst		}
    });

    
    this.setDisplayOptions({
	   	 columnMovable	: options.columnMovable		== undefined?false:options.columnMovable
	   	,columnResizable: options.columnResizable	== undefined?true:options.columnResizable
	   	,rowHeight		: options.rowHeight	== undefined?_defaultRowHeight:options.rowHeight
	   	,fitStyle		: options.fitStyle			== undefined?_defaultFitStyle:options.fitStyle
    });
    this.setCheckBar({visible: options.checkBar==undefined?true:options.checkBar
    				, exclusive:options.exclusive==undefined?false:options.exclusive});
    this.setEditOptions({editable: options.editable==undefined?false:options.editable});
    this.setCopyOptions({singleMode: options.copySingle==undefined?true:options.copySingle});
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
    					//_columns.splice : splice는 IE8에서 사용불가
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
        
    
	this.resetSize();
    
	if (options.dynamicResize!==undefined && options.dynamicResize) {
		//console.log( "_gv._name = " + this._gv._name);
		//this._gv._container._containerDiv.id
		//console.log( "gridDivId = " + options.gridId);
		//console.log( JSON.stringify( _dynamicResizeTarget));
		_dynamicResizeTarget.push({gridName:this._gv._name,gridDivId:options.gridId});
		//console.log( JSON.stringify( _dynamicResizeTarget));
	}
	
	var _pageNavi = "";
    
    if (options.pager!==undefined) {
    	//gridId, page_size, current_page, total_count, search_url
    	if (options.pager.visible!==undefined && options.pager.visible) {
    		if (options.pager.pageSize!==undefined && options.pager.pageSize!='') {
    			_pageSize = options.pager.pageSize;
    		}
    		drawPageNavi(options.gridId, _pageSize, 0, 0, options.pager.searchLink);
    	}
    }
    
    this.setPageNavi = function(currentPage) {
    	//gridId, page_size, current_page, total_count, search_url
    	drawPageNavi(options.gridId, _pageSize, 0, 0, options.pager.searchLink);
    };
    
    this.setPageRows = function(data) {
    	this.setRows(data.rows);
    	this.setPages(data);
    };

    this.setTreeRows = function(rowInfo, treeField, needSorting, childrenField, iconField ) {
    	dataProvider.setRows(rowInfo, treeField, needSorting, childrenField, iconField);
    	    	
    	this.resetSize();
    	this.refresh();
    };
    
    this.setPages = function(pageInfo) {
    	if (options.pager===undefined || !options.pager) {
    		
    	} else {
    		drawPageNavi(options.gridId, _pageSize, pageInfo.page, pageInfo.records, options.pager.searchLink);
    		
        	this.setIndicator({
                indexOffset: ( pageInfo.page - 1 ) * _pageSize
            });
    	}
    };

    this.setPageSize = function(size) {
    	_pageSize = size;
    	this.setPaging(true, size);
    };
    
    this.fieldNameByColumnIndex = function(colIndex) {
    	return _columnNames[colIndex];
    };
    
    this.getDataProvider = function () {
    	return dataProvider;
    };
    
    this.addChildRow = function (rowId, values, iconIndex, hasChildren) {
    	return dataProvider.getJsonRows(rowId, values, iconIndex, hasChildren);
    }
    
    this.getAllRows = function () {
    	//dataProvider.clearRowStates(true, false);
    	return dataProvider.getRows();
    };
    
    
    // 모든 데이터 건수 ( 삭제된 것 포함)
    this.getRowCount = function() {
    	return dataProvider.getRowCount();
    };
    
    
    this.getAllJsonRows = function () {
    	//dataProvider.clearRowStates(true, false);
    	return dataProvider.getJsonRows(-1, true);

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
    	var itemCnt = this.getItemDataCount();
    	for( var i = 0; i < itemCnt; i++) {
    		rowValue = this.getValues(i);
    		
    		//console.log( "i=" + i + " values = " + JSON.stringify(rowValue));
    		rowValue.rowId = this.getValues(i).__rowId;
    		rowValue.itemIndex = i;
    		itemData.push(rowValue);
    	}
    	return itemData;
    };
    
    
    this.getRowState = function(row) {
    	return dataProvider.getRowState(this.getValues(row).__rowId);
    };
    
    this.getCurrentRow = function () {
    	if (this.getCurrent().dataRow!=-1)
    		return dataProvider.getOutputRow({datetimeFormat: "yyyyMMdd"}, this.getCurrent().dataRow);
    };
    
    this.getSelectedRows = function () {
    	var checkedRows = this.getCheckedRows();
    	var state;
        var jData;
    	var jRowsData = [];
    	
    	if (checkedRows.length > 0) {
    		checkedRows.forEach(function (row){
    			jData = dataProvider.getJsonRow(row);
    			jData.state = "selected";
                jRowsData.push(jData);
			});
    	} else {
    		return;
    	}
    	
    	return jRowsData;
    };
    
    this.getStateRows = function(state) {
    	var state;
        var jData;
        var jResponse = {};
        var isDataExist = false;
        
    	var rows;
    
    	if (state != null && state != '') {
    		if (state != "created" && state != "updated" && state != "deleted") {
    			alert("잘못된 인수입니다.\n사용 인수는 아래와 같습니다.\n\ncreated\nupdated\ndeleted");
    			return;
    		} else {
    			rows = dataProvider.getStateRows(state);
    			//console.log(  JSON.stringify(rows));
    			var jRowsData = [];
    			if (rows.length > 0) {
    				
        			rows.forEach(function (r){
        				jData = dataProvider.getJsonRow(r);
        				//console.log(JSON.stringify(jData));
    	    			jRowsData.push(jData);
    				});
        			
        			isDataExist = true;
    	    	} else {
    	    		return null;
    	    	}
    			
    			
    			jResponse[state.toUpperCase()] = jRowsData;
    			//console.log(JSON.stringify(jResponse));
    			//$.extend(jResponse, {state:jRowsData});
    		}
    	} else {
    		rows = dataProvider.getAllStateRows();
    		
    		if (rows.updated.length > 0) {
        		var jRowsData = [];
                $.each(rows.updated, function(k, v) {
                    jData = dataProvider.getJsonRow(v);
                    jData.state = "updated";
                    jRowsData.push(jData);
                });
                $.extend(jResponse, {"UPDATED":jRowsData});
                isDataExist = true;
        	}

    		if (rows.deleted.length > 0) {
            	var jRowsData = [];
                $.each(rows.deleted, function(k, v) {
                    jData = dataProvider.getJsonRow(v);
                    jData.state = "deleted";
                    jRowsData.push(jData);
                });
                $.extend(jResponse, {"DELETED":jRowsData});
                isDataExist = true;
            }

            if (rows.created.length > 0) {
            	var jRowsData = [];
                $.each(rows.created, function(k, v) {
                    jData = dataProvider.getJsonRow(v);
                    jData.state = "created";
                    jRowsData.push(jData);
                });
                $.extend(jResponse, {"CREATED":jRowsData});
                isDataExist = true;
            }

            if (jResponse.length == 0) {
                dataProvider.clearRowStates(true);
                return;
            }
    	}
    	
    	if (isDataExist) return jResponse;
    	return null;
    };
    
    this.deleteRows = function (rows) {
    	if (rows.length > 1) {
    		var _rows = [];
    		$.each(rows, function(r) {
    			_rows.push(this.getValues(r).__rowId);
    		});
    		dataProvider.removeRows(_rows, true);
    	} else {
    		dataProvider.removeRows(this.getValues(rows).__rowId, true);	
    	}
    };
    
    this.deleteSelectedRows = function() {
    	var _rows = this.getCheckedRows();
    	dataProvider.removeRows(_rows, true);
    };
      
    this.exportToExcel = function(excelOptions) {
    	
    	this.exportGrid({
    		 type 				: "excel"
    		,target				: "local"
    		,fileName			: excelOptions.fileName
    		,showProgress		: true
    		,progressMessage	: "Excel 생성중입니다."
    		,applyDynamicStyles	: true
    		,indicator			: true
	        ,header				: true
	        ,footer				: true
	        ,compatibility		: true //true:2007, false:2010
	        ,done				: excelOptions.doneCallBack!=null?excelOptions.doneCallBack:function() { alert("엑셀 다운이 완료되었습니다."); }
	        
    	});
    	
    	/*
    	 this.exportGrid({
			 type				: "excel"
			,target				: "remote"
			,url				: "/ExcelXBin.do"
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
    	dataProvider.addRow(_row);
    };
    
    this.addRows = function (rows) {
    	dataProvider.addRows(rows, 0, -1);
    };
    
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
    
    
};


function setValueForParent(grid, itemIndex, colName, colValue) {
	//console.log( "intmIndex = " + itemIndex + ", colName = " + colName+ ", colValue = " + colValue)
	//grid.setValue(grid, itemIndex, colName, colValue);
	
	if( itemIndex >=0 ) {
		var rowId = grid.getParent(itemIndex);
		
		//console.log( "getParent = " + JSON.stringify(rowId));
		if( rowId != null && rowId != '' ) {
			//console.log('parent');
			setValueForParent(grid, rowId, colName, colValue);
			grid.setValue(rowId, colName, colValue);
			//console.log('set rowid = ' + rowId);
		} else {
			//console.log('top parent');
			grid.setValue(rowId, colName, colValue);
			//console.log('set rowid = ' + rowId);
		}
	}
	
}

function setValueForChild(grid, itemIndex, colName, colValue) {
	var rowIds = grid.getChildren(itemIndex);
	//console.log( rowIds.length );
	//console.log( "getChildren = " + JSON.stringify(rowIds));
	for(var i = 0, nSize=rowIds.length; i < nSize; i++ ) {
		grid.setValue(rowIds[i], colName, colValue);
		setValueForChild(grid, rowIds[i], colName, colValue);
	}
}    



function setValueForParentClear(grid, itemIndex, colName, colValue) {
	//console.log( "setValueForParent2 intmIndex = " + itemIndex + ", colName = " + colName+ ", colValue = " + colValue);
	//grid.setValue(grid, itemIndex, colName, colValue);
	
	if( itemIndex >=0 ) {
		var rowId = grid.getParent(itemIndex);
		
		//console.log( "getParent = " + JSON.stringify(rowId));
		if( rowId != null && rowId != '' ) {
			if( existCheckedChild(grid, rowId, colName) == false ) {
				grid.setValue(rowId, colName, colValue);
			}
			//console.log('parent');
			setValueForParentClear(grid, rowId, colName, colValue);
			
			//console.log('set rowid = ' + rowId);
		} 
	}
	
}
	
function existCheckedChild(grid, itemIndex, colName) {
	//console.log( "existCheckedChild intmIndex = " + itemIndex + ", colName = " + colName);
	var isExist = false;
	var rowIds = grid.getChildren(itemIndex);
	//console.log( rowIds.length );
	//console.log( "getChildren = " + JSON.stringify(rowIds));
	for(var i = 0, nSize=rowIds.length; i < nSize; i++ ) {
		var tempVal = grid.getValue(rowIds[i], colName);
		//console.log( "i = " + rowIds[i] + ", tempVal = " + tempVal);
		if( tempVal == 'Y') {
			isExist = true;
			break;
		}
	}
	
	return isExist;
}   
