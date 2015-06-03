jQuery(document).ready(function($){
	// make the line length dynamic, depending on the size of the window
	var editor_width = $(window).width() * .7;  // .7 because the editor is set to width: 70%;
	var line_length = editor_width / 10;
	var editor_ignore_key = false;
	var $editor_wrapper = $('#editor-wrapper');

	LaikaParams.keyCode = Number(LaikaParams.keyCode);
	console.log('code: ' + LaikaParams.keyCode);

	// this is the element to be edited
	var $content = $('#laika-editor');
	var $title = $('#laika-editor-title');

	// title field in the editor window
	var $editor_title = $('#editor-title');

	function jss_open_or_close_editor(){
		if ($editor_wrapper.is(":hidden")) { 
			$editor_wrapper.slideDown(200);
		} else if ($editor_wrapper.is(":visible") && editor_ignore_key === false) {
			$editor_wrapper.slideUp(200);
		} 
	}

	// Set title field value to the page/post title
	$editor_title.val($title.html());

	var editor = ace.edit("editor");
		ace.require("ace/ext/emmet");
        editor.setTheme("ace/theme/monokai");
        editor.session.setMode("ace/mode/html");
        editor.setValue($.trim($content.html()), -1);
        editor.getSession().setUseWrapMode(true);
        editor.session.setWrapLimitRange(null, line_length);
        editor.setHighlightActiveLine(false);
        editor.setShowPrintMargin(false);
        editor.setOption("enableEmmet", true);
        document.getElementById('editor').style.fontSize='14px';
        editor.resize();

        // Ignore the open/close key and disable dragging when the editor has focus
        editor.on("focus", function(){
        	editor_ignore_key = true;
        	$editor_wrapper.draggable({ disabled: true });
        });

        $editor_title.on("focus", function(){
        	editor_ignore_key = true;
        	$editor_wrapper.draggable({ disabled: true });
        });

        editor.on("blur", function(){
        	editor_ignore_key = false;
        	$editor_wrapper.draggable({ disabled: false });
        });

        $editor_title.on("blur", function(){
        	editor_ignore_key = false;
        	$editor_wrapper.draggable({ disabled: false });
        });

        $('#editor').keyup(function(){
          $content.html(editor.getValue());
        });

        $editor_title.keyup(function(){
          $title.html($(this).val());
        });

        $('#laika-undo').click(function(event){
          event.preventDefault();
          var check = confirm("Undo all changes?");
          if (check === true){
            $title.html(localStorage.title);
            $editor_title.val(localStorage.title);
            $content.html(localStorage.content);
            editor.setValue(localStorage.content);
          }
        }); 

	// store the orignal value, so it can be undone later
	localStorage.content = $.trim($content.html());
	localStorage.title = $.trim($title.html());

	var storeEditorDimensions = function(){
		width = $editor_wrapper.width();
		height = $editor_wrapper.height();

		localStorage.editorHeight = height;
		localStorage.editorWidth  = width;
		localStorage.editorTop    = $editor_wrapper.css('top');
		localStorage.editorLeft   = $editor_wrapper.css('left');

		return {
			"width": width,
			"height": height
		}
	}

	///////// Open/close editor on keypress /////////////
	$(document).keyup(function(event){
		if (LaikaParams.enableKeyboard == '1'){
			//console.log(event.keyCode);
			if (event.keyCode == LaikaParams.keyCode && $editor_wrapper.is(":hidden")) { 
				$editor_wrapper.slideDown(200);
			} else if (event.keyCode == LaikaParams.keyCode && $editor_wrapper.is(":visible") && editor_ignore_key === false) {
				$editor_wrapper.slideUp(200);
			}
		} 
	});

	///////// Open/close editor on admin bar link /////////////
	$('#wp-admin-bar-backtick').click(function(event){
		event.preventDefault();
		jss_open_or_close_editor();
	});

	$('.laika-trigger-button').click(function(event){
		event.preventDefault();
		jss_open_or_close_editor();
	});

	///////// Close editor via X in upper-right /////////////
	$('#laika-close').click(function(event){
		event.preventDefault();
		$editor_wrapper.slideUp(200);
	});

	// Search
	$('#laika-search-form').submit(function(event){
		event.preventDefault();
		var search_term = $('#laika-search-field').val();
		editor.find(search_term,{
		  backwards: false,
		  wrap: true,
		  caseSensitive: false,
		  wholeWord: false,
		  regExp: false
		});
		editor.findNext();
		editor.findPrevious();
	});

	
	// When the form is submitted, place the editor contents in 
	// a hidden field
	$('#laika-submit').submit(function(){
		$('#laika-submit-content').val(editor.getValue());
		$('#laika-submit-title').val($title.html());
	});

	
	// Click and hover to show the editable area
	$('#laika-show-editable').hover(function(){
		$content.css('background-color','yellow');
		$title.css('background-color','yellow');
	}, function(){
		$content.css('background-color','inherit');
		$title.css('background-color','inherit');
	});

	$('#laika-show-editable').click(function(){
		$content.toggleClass('laika-background-highlight');
		$title.toggleClass('laika-background-highlight');
		if ( $content.hasClass('laika-background-highlight') ){
			$(this).text('Remove highlight');
		} else {
			$(this).text('Highlight editable area');
		}
	});

	// jQuery UI
	$editor_wrapper.draggable({ 
		cursor: "move",
		containment: "window",
		stop: function(e, ui) {
			localStorage.editorTop = $(this).css('top');
			localStorage.editorLeft = $(this).css('left');
			$(this).css('position','fixed');
		}
	});

	$('#laika-window').click(function(event){
		event.preventDefault();
		$editor_wrapper.toggleClass('editor-mobile');
		if ( !$editor_wrapper.hasClass('editor-mobile') ){
			// store the mobile window dimensions 
			storeEditorDimensions();
			// reset back to original size & position
			$editor_wrapper
				.css('position','fixed')
				.css('left','0px')
				.css('bottom','0px')
				.css('top','')
				.width('100%')
				.height(300);
			$editor_wrapper.resizable( "option", "minHeight", 280 );
		} else {
			if (localStorage.getItem("editorWidth") === null){
				// set default values if none in localStorage
				localStorage.editorWidth = 1200;
				localStorage.editorHeight = 280;
				localStorage.editorLeft = '66px';
				localStorage.editorTop = '400px';
			}
			$editor_wrapper
				.width(localStorage.editorWidth)
				.height(localStorage.editorHeight)
				.css('left', localStorage.editorLeft)
				.css('top', localStorage.editorTop);
			$editor_wrapper.resizable( "option", "minHeight", 240 );
		}
		editor.resize();
	});

	$editor_wrapper.resizable({ 
		handles: "all",
		minHeight: 280,
		minWidth: 600,
		maxWidth: 1600,
		containment: "document",
		stop: function(e, ui){
            editor.resize();
            $(this).css('position','fixed');
        } 
	});

});