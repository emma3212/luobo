<?php
class LaikaOptionsPage
{
    /**
     * Holds the values to be used in the fields callbacks
     */
    private $options;

    /**
     * Start up
     */
    public function __construct()
    {
        add_action( 'admin_menu', array( $this, 'add_plugin_page' ) );
        add_action( 'admin_init', array( $this, 'page_init' ) );
    }

    /**
     * Add options page
     */
    public function add_plugin_page()
    {
        // This page will be under "Settings"
        add_options_page(
            'Settings Admin', 
            'Redaktor HTML Editor', 
            'manage_options', 
            'redaktor-settings', 
            array( $this, 'laika_create_admin_page' )
        );
    }

    /**
     * Options page callback
     */
    public function laika_create_admin_page()
    {
        // Set class property
        $this->options = get_option( 'laika_option_name' );
        ?>
        <div class="wrap">
            <?php screen_icon(); ?>
            <h2>Front-end Editor Settings</h2>           
            <form method="post" action="options.php">
            <?php
                // This prints out all hidden setting fields
                settings_fields( 'laika_option_group' );   
                do_settings_sections( 'laika-setting-admin' );
                submit_button(); 
            ?>
            </form>
        </div>
        <?php
    }

    /**
     * Register and add settings
     */
    public function page_init()
    {        
        register_setting(
            'laika_option_group', // Option group
            'laika_show_button' // Option name
        );

        register_setting(
            'laika_option_group', // Option group
            'laika_disable_wpautop' // Option name
        );

        register_setting(
            'laika_option_group', // Option group
            'laika_show_toolbar_link' // Option name
        );

        register_setting(
            'laika_option_group', // Option group
            'laika_allow_keyboard_shortcut' // Option name
        );

        register_setting(
            'laika_option_group', // Option group
            'laika_keyboard_shortcut_code' // Option name
        );

        add_settings_section(
            'laika_settings_section', // ID
            'Enable ways to open/close the editor window', // Title
            array( $this, 'jss_print_section_info' ), // Callback
            'laika-setting-admin' // Page
        ); 

        add_settings_section(
            'laika_keyboard_section', // ID
            'Keyboard', // Title
            array( $this, 'jss_print_section_info' ), // Callback
            'laika-setting-admin' // Page
        ); 

        add_settings_section(
            'laika_code_processing_section', // ID
            'Code processing', // Title
            array( $this, 'jss_print_section_info' ), // Callback
            'laika-setting-admin' // Page
        ); 

        add_settings_field(
            'show_button', // ID
            'Show red button', // Title 
            array( $this, 'jss_show_button_callback' ), // Callback
            'laika-setting-admin', // Page
            'laika_settings_section' // Section           
        );      

        add_settings_field(
            'show_toolbar_link', 
            'Show "Edit HTML" link in admin toolbar', 
            array( $this, 'jss_show_toolbar_link_callback' ), 
            'laika-setting-admin', 
            'laika_settings_section'
        );

        add_settings_field(
            'allow_keyboard_shortcut', 
            'Enable keyboard shortcut', 
            array( $this, 'jss_allow_keyboard_shortcut_callback' ), 
            'laika-setting-admin', 
            'laika_keyboard_section'
        );

        add_settings_field(
            'keyboard_shortcut_code', 
            'Use this key to open/close the editor', 
            array( $this, 'jss_keyboard_code_callback' ), 
            'laika-setting-admin', 
            'laika_keyboard_section'
        ); 

        add_settings_field(
            'disable_autop', 
            'Disable automatic &lt;p> tags (<a href="http://codex.wordpress.org/Function_Reference/wpautop" target="_blank">WPAutoP</a>)', 
            array( $this, 'jss_disable_wpautop_callback' ), 
            'laika-setting-admin', 
            'laika_code_processing_section'
        );      
    }

    /**
     * Sanitize each setting field as needed
     *
     * @param array $input Contains all settings fields as array keys
     */
    public function sanitize( $input )
    {
        $new_input = array();
        if( isset( $input['laika_show_button'] ) )
            $new_input['laika_show_button'] = ( $input['laika_show_button'] );

        if( isset( $input['laika_show_toolbar_link'] ) )
            $new_input['laika_show_toolbar_link'] = ( $input['laika_show_toolbar_link'] );

        return $new_input;
    }

    /** 
     * Print the Section text
     */
    public function jss_print_section_info()
    {
        // print 'Enable/disable ways to trigger the editor window:';
    }

    /** 
     * Get the settings option array and print one of its values
     */
    public function jss_show_button_callback()
    {
        echo '<input name="laika_show_button" id="laika_show_button" type="checkbox" value="1" class="code" ' . checked( 1, get_option( 'laika_show_button', 1 ), false ) . ' />';
    }

    public function jss_show_toolbar_link_callback()
    {
        echo '<input name="laika_show_toolbar_link" id="laika_show_toolbar_link" type="checkbox" value="1" class="code" ' . checked( 1, get_option( 'laika_show_toolbar_link', 1 ), false ) . ' />';
    }

    public function jss_allow_keyboard_shortcut_callback()
    {
        echo '<input name="laika_allow_keyboard_shortcut" id="laika_allow_keyboard_shortcut" type="checkbox" value="1" class="code" ' . checked( 1, get_option( 'laika_allow_keyboard_shortcut', 1 ), false ) . ' />';
    }

    public function jss_keyboard_code_callback()
    {?>
        <select name="laika_keyboard_shortcut_code">
            <option value="192" <?php selected( get_option('laika_keyboard_shortcut_code'), 192 ); ?>>` (backtick)</option>
            <option value="27"  <?php selected( get_option('laika_keyboard_shortcut_code'), 27  ); ?>>Esc</option>
            <option value="113" <?php selected( get_option('laika_keyboard_shortcut_code'), 113 ); ?>>F2</option>
            <option value="114" <?php selected( get_option('laika_keyboard_shortcut_code'), 114 ); ?>>F3</option>
            <option value="121" <?php selected( get_option('laika_keyboard_shortcut_code'), 121 ); ?>>F10</option>
        </select>
    <?php } 

    public function jss_disable_wpautop_callback()
    {
        echo '<input name="laika_disable_wpautop" id="laika_disable_wpautop" type="checkbox" value="1" class="code" ' . checked( 1, get_option( 'laika_disable_wpautop', '' ), false ) . ' />';
        echo '<strong style="margin-left:10px">Caution: May affect the display of existing posts and pages.</strong>';
    }
}

if( is_admin() )
    $my_settings_page = new LaikaOptionsPage();