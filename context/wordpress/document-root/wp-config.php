<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */
// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', $_ENV["WORDPRESS_DB_NAME"] );

/** MySQL database username */
define( 'DB_USER', $_ENV["WORDPRESS_DB_USER"] );

/** MySQL database password */
define( 'DB_PASSWORD', $_ENV["WORDPRESS_DB_PASSWORD"] );

/** MySQL hostname */
define( 'DB_HOST', $_ENV["WORDPRESS_DB_HOST"] );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */

define('AUTH_KEY',         'sBtp?|4/EUS}V|em[ex|:[P{$72i-L]@_0w@)MY2*CEB(f0lur9^cQNc3-Ov>?l3');
define('SECURE_AUTH_KEY',  '(VH%-$s[?FqirP}xwI_{]l:z?Eu/:soy>R7e-%MP!#VF6.@@_:pJb;I~`.0|S*l%');
define('LOGGED_IN_KEY',    'tzIU2;Nc;%r.(lRY&l5s$;:bEfUn-)abdzHKVzWj3Fy+s4fr2POpWwU8Uhzv;_v>');
define('NONCE_KEY',        '[IU,GooRZf|8z{Nn/Vjw#SO:CGrK.L6Os2)>q6{/sOPUs-/9RR.ckL65SS#KO%ru');
define('AUTH_SALT',        'q7C}=A<I}`8.c7jc-Zh(vap^SS+O1i;Os2=UQ(},ry Y@@k3x{SksyFZohzTEZy)');
define('SECURE_AUTH_SALT', '_P;9JmBM<`A(Hw.;bFn+D!.n12OWl-_&o:f8,8;HT&5(U70J-L-w=w|V38%aE<|d');
define('LOGGED_IN_SALT',   'rI9tmMtJiAjNVY*ep=oaMziY[QqjF/2 O!J_1zGU+[?+GYr^ge!H,qxcS#~=U/PJ');
define('NONCE_SALT',       ')XE|YKIUd?/}(%!cE$S9({mU~[-aDIWuwMkZ8p]dZIL2~*gwoIPpi+}5:8Q[?@bP');

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */

define('WP_SITEURL', 'https://patryk.staz.inpl.work');
define('WP_HOME', 'https://patryk.staz.inpl.work');

define('FORCE_SSL_ADMIN', true);
$_SERVER['HTTPS']='on';

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
