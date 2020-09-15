<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
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
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'nsimon' );

/** MySQL database password */
define( 'DB_PASSWORD', 'nsimon' );

/** MySQL hostname */
define( 'DB_HOST', 'mysql-svc' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'iuKY)j[>#I-&9s=m2wsxuw52xn+T;`dJg|Y^bnmqNPT$wV$v{XTW+Fk.itb>rM1J' );
define( 'SECURE_AUTH_KEY',  '7LuXk;.<~,kk8jM@%chZ-Oy<`T28;PPTqn(QGT62~5/PSA5%hm$Z6-h@k1-_dIQ+' );
define( 'LOGGED_IN_KEY',    '?=Z]I.oT.65!IPoc!c#`9m[1HcFB-]gRa+ -LnuAHMWinWc N/e ut:7xr(tzcol' );
define( 'NONCE_KEY',        '2`@O)]mT2U4DA_t>a2a2+iIw>&siaS|F^={;hg.:nj ;&Npd yFf;YY[%B54`QQs' );
define( 'AUTH_SALT',        't#NUY~S,9f-xR$i{!Avs!O{)a_ZD``~d$lDWJvs3i1#LFJC!`^4=(%mwL{S.9NS-' );
define( 'SECURE_AUTH_SALT', '6?<0Y|}fBOu8p]1VG -djyg?GM9Q&&99&P1ia6xY(Zy__Ylk!3=c.!lSnx/WNeiT' );
define( 'LOGGED_IN_SALT',   '^xXGjSFl]`83q HYH{8< }<-6U8bQ]`Azr#qXCE=^.6UT|iNahJPlc~upTOizG[;' );
define( 'NONCE_SALT',       '-CJ1E|{L>/TCnx9L$WY<a=[8}4zIWC<+[fE8u[4f$sI>KPZg8m(s0$~I8@B}@m9C' );

/**#@-*/

/**
 * WordPress Database Table prefix.
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

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
