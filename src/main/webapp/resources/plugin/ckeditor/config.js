/**
 * @license Copyright (c) 2003-2019, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */

CKEDITOR.editorConfig = function( config ) {
	config.toolbarGroups = [
		{ name: 'styles', groups: [ 'styles' ] },
		{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
		{ name: 'colors', groups: [ 'colors' ] },
		{ name: 'paragraph', groups: [ 'list', 'align', 'indent', 'blocks', 'bidi', 'paragraph' ] }
	];
	
	config.height = '300px';
	
	config.format_tags = 'p;h1;h2;h3;h4;h5';

	config.removeButtons = 'Source,Save,Templates,Cut,Undo,Find,NewPage,Preview,Print,About,Maximize,Image,Flash,Table,HorizontalRule,Smiley,SpecialChar,PageBreak,Iframe,Link,CopyFormatting,RemoveFormat,Blockquote,CreateDiv,Unlink,Anchor,Form,Checkbox,Radio,TextField,Textarea,Select,Button,Scayt,SelectAll,Replace,Redo,Copy,Paste,PasteText,PasteFromWord,ImageButton,HiddenField,Language,BidiLtr,BidiRtl,ShowBlocks,Styles';
};