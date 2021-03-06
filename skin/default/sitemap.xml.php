<?php
use ctubio\HKPProxy\Keyserver;

echo '<', '?'; ?>xml version="1.0" encoding="UTF-8"<?php echo '?','>'; ?>

<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>http<?php if($SERVER_PORT_443=(isset($_SERVER['SERVER_PORT']) && $_SERVER['SERVER_PORT'] === '443')): ?>s<?php endif; ?>://<?php echo Keyserver::getConfig()->hostname; ?><?php if($SERVER_PORT_HKP=(isset($_SERVER['SERVER_PORT']) && $_SERVER['SERVER_PORT'] === Keyserver::getConfig()->hkp_public_port)): ?>:<?php echo Keyserver::getConfig()->hkp_public_port; ?><?php endif; ?>/</loc>
    <lastmod><?php echo date('Y-m-d'); ?></lastmod>
    <changefreq>monthly</changefreq>
    <priority>1.0</priority>
  </url>
  <url>
    <loc>http<?php if ($SERVER_PORT_443):?>s<?php endif; ?>://<?php echo Keyserver::getConfig()->hostname; ?><?php if($SERVER_PORT_HKP): ?>:<?php echo Keyserver::getConfig()->hkp_public_port; ?><?php endif; ?>/peers</loc>
    <lastmod><?php echo date('Y-m-d'); ?></lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.5</priority>
  </url>
  <url>
    <loc>http<?php if ($SERVER_PORT_443):?>s<?php endif; ?>://<?php echo Keyserver::getConfig()->hostname; ?><?php if($SERVER_PORT_HKP): ?>:<?php echo Keyserver::getConfig()->hkp_public_port; ?><?php endif; ?>/sks-dump</loc>
    <lastmod><?php echo date('Y-m-d'); ?></lastmod>
    <changefreq>daily</changefreq>
    <priority>0.7</priority>
  </url>
  <url>
    <loc>http<?php if ($SERVER_PORT_443):?>s<?php endif; ?>://<?php echo Keyserver::getConfig()->hostname; ?><?php if($SERVER_PORT_HKP): ?>:<?php echo Keyserver::getConfig()->hkp_public_port; ?><?php endif; ?>/load</loc>
    <lastmod><?php echo date('Y-m-d'); ?></lastmod>
    <changefreq>daily</changefreq>
    <priority>0.5</priority>
  </url>
  <url>
    <loc>http<?php if ($SERVER_PORT_443):?>s<?php endif; ?>://<?php echo Keyserver::getConfig()->hostname; ?><?php if($SERVER_PORT_HKP): ?>:<?php echo Keyserver::getConfig()->hkp_public_port; ?><?php endif; ?>/faq</loc>
    <lastmod><?php echo date('Y-m-d'); ?></lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.5</priority>
  </url>
</urlset>
