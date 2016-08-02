include:
  - modules.php.install
  - modules.php.php-memcache
  - modules.php.php-redis
  - modules.nginx.service

web-bbs:
  file.managed:
    - name: /usr/local/nginx/conf/vhost_online/bbs.conf
    - source: salt://bbs/files/nginx-bbs.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - service: php-fastcgi-service
    - watch_in:
      - service: nginx-service
