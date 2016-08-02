{% set tomcat_tar = 'apache-tomcat-7.0.70.tar.gz' %}
{% set tomcat_source = 'salt://modules/tomcat/files/apache-tomcat-7.0.70.tar.gz' %}
include:
  - modules.java.install
  - modules.cronolog.install

tomcat-directory:
  file.directory:
    - name: /data/services

tomcat-file:
  file.managed:
    - name: /usr/local/src/{{ tomcat_tar }}
    - source: {{ tomcat_source }}
    - mode: 755
    - user: root
    - group: root
  cmd.run:
    - name: cd /usr/local/src && tar -zxf {{ tomcat_tar }} -C /data/services
    - require:
      - file: tomcat-file
      - file: tomcat-directory
    - unless: test -d /data/services/apache-tomcat-7.0.70

tomcat-service:
  cmd.run:
    - name: source /etc/profile && /data/services/apache-tomcat-7.0.70/bin/catalina.sh start
    - file: tomcat-file
    - require:
      - cmd: jdk-run
