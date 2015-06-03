<?php
/*
	Plugin Name: Redaktor
	Plugin URI: http://editor.viewsauce.org
	Description: Front-end HTML editing
	Author: Jon Schwab
	Version: 0.9.9
	Author URI: http://www.ancillaryfactory.com

 */

include "laika-options.php";

function jss_editor_scripts(){
	if ( is_singular() && current_user_can('publish_posts')){
		wp_enqueue_style( 'laika-css', plugins_url( 'css/laika.css' , __FILE__ ) );
		wp_enqueue_script( 'emmet', plugins_url( 'js/emmet.js' , __FILE__ ), null, null, true );
		wp_enqueue_script( 'laika', plugins_url( 'js/laika.min.js' , __FILE__ ), 
			array('jquery','jquery-ui-draggable','jquery-ui-resizable'), null, true );
		
		// Pass values to JavaScript
		// http://ottopress.com/2010/passing-parameters-from-php-to-javascripts-in-plugins/
		$laika_settings = array(
			'keyCode'        => get_option('laika_keyboard_shortcut_code', 192),
			'enableKeyboard' => get_option('laika_allow_keyboard_shortcut', 1)
		);

		wp_localize_script( 'laika', 'LaikaParams', $laika_settings );
	}
}

function jss_render_editor(){
	/**
	 * If the current page is a post, page or otherwise singular, and 
	 * the current user has permission to publish posts, insert the HTML 
	 * for the editor.
	 *
	 * Also, if the option is enabled, the red "r" button is placed on the
	 * side of the screen.
	 */

	if ( is_singular() && current_user_can('publish_posts')){ ?>
		<?php if (get_option('laika_show_button', '1') == "1"){?>
			<a class="laika-trigger-button">&nbsp;</a>
		<?php } ?>
		<div id="editor-wrapper">
		    <label id="label-title">Title:</label> <input type="text" id="editor-title" />
		    <div id="editor"></div>
		    <div id="editor-buttons">
		      <form id="laika-search-form">
		        <input type="text" id="laika-search-field" />
		        <input type="submit" id="laika-search-button" value="Search" class="btn btn-info btn-sm">
		      </form>
		      <form id="laika-submit" method="post" action="">
		      	<?php wp_nonce_field( 'editor', 'content-submit' ); ?>
		      	<input type="hidden" name="id" value="<?php the_ID(); ?>"/>
		      	<input type="hidden" name="content" id="laika-submit-content" value=""/>
		      	<input type="hidden" name="title" id="laika-submit-title" value=""/>
		      	<input type="submit" name="laika-submit" id="laika-save" class="btn btn-default" value="Save" />
		      	<a href="#" id="laika-undo" class="btn btn-danger">Undo all</a>
		      	<a id="laika-show-editable" class="btn btn-link btn-xs">Highlight editable area</a>
		      </form>
		      <ul id="laika-window-controls">
		      	<li><a href="#" id="laika-window" class="btn btn-link">&Pi;</a></li>
		      	<li><a href="#" id="laika-close" class="btn btn-link">X</a></li>
		      </ul>
		    </div>
	    </div><!-- /editor-wrapper -->
	<?php }
}

/**
 * These two functions wrap invisible <div>s around the title and content areas,
 * which are used by laika.js to read and update content from the editor.
 */

function jss_wrap_content($content){
	if ( is_singular() && current_user_can('publish_posts')){
		$content = '<div id="laika-editor">' . $content . '</div>';
	}
	return $content;
}

function jss_wrap_title($title){
	if ( in_the_loop() && is_singular() && current_user_can('publish_posts')){
		$title = '<div id="laika-editor-title">' . $title . '</div>';
	}
	return $title;
}


// Add Toolbar Menus
function jss_custom_toolbar() {
	global $wp_admin_bar;

	$args = array(
		'id'     => 'backtick',
		'title'  => __( 'Edit HTML', 'text_domain' ),
		'href'   => '#',
	);
	
	if (is_singular() && current_user_can('publish_posts') && (get_option('laika_show_toolbar_link', '1') == "1")) {
		$wp_admin_bar->add_menu( $args );
	}
}

// Add settings link on plugin page
function laika_settings_link($links) { 
  $settings_link = '<a href="options-general.php?page=redaktor-settings">Settings</a>'; 
  array_unshift($links, $settings_link); 
  return $links; 
}
 
$plugin = plugin_basename(__FILE__); 
add_filter("plugin_action_links_$plugin", 'laika_settings_link' );

add_action('wp_before_admin_bar_render', 'jss_custom_toolbar', 999);
add_action('wp_enqueue_scripts','jss_editor_scripts');
add_action('wp_footer','jss_render_editor');
add_filter('the_content', 'jss_wrap_content');
add_filter('the_title', 'jss_wrap_title');

// Remove filtering
if (get_option('laika_disable_wpautop') == '1'){
	remove_filter('the_content', 'wpautop');
}

/**
 * Updates the current post with the title/body from the editor.
 * Uses wp_update_post(), so all post-update hooks are activated.
 */
function jss_update_from_editor(){
	if (wp_verify_nonce($_POST['content-submit'], 'editor') && current_user_can('publish_posts') ){
		global $wpdb;
		kses_remove_filters();
		$content = stripcslashes($_POST['content']);
		$title   = stripcslashes($_POST['title']);
		$update_id = intval($_POST['id']);

		$data = array(
			'post_content' => $content, 
			'post_title' => $title, 
			'ID' => $update_id 
		);
		wp_update_post( $data );
	 }
}

if ( isset($_POST['content']) || isset($_POST['title']) ){
	add_action( 'init', 'jss_update_from_editor' );
}