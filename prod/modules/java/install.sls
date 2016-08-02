{% set jdk_tar = 'jdk-7u65-linux-x64.tar.gz' %}
{% set jdk_source = 'salt://modules/java/files/jdk-7u65-linux-x64.tar.gz' %}
include:
  - modules.pkg.make
  - modules.user.www
jdk-file:
  file.managed:
    - name : /usr/local/src/{{ jdk_tar }}
    - source: {{ jdk_source }}
    - mode: 755
    - user: root
    - group: root
  cmd.run:
    - name: cd /usr/local/src && /bin/tar -xf {{ jdk_tar }} -C /usr/local && /bin/ln -s /usr/local/jdk1.7.0_65 /usr/local/jdk
    - unless: test -L /usr/local/jdk
    - require: 
      - file: jdk-file

/etc/profile:
  file.append:
    - text:
      - export JAVA_HOME=/usr/local/jdk
      - export JRE_HONE=$JAVA_HONE/jre
      - export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
      - export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH
jdk-run:
  cmd.run:
    - name: source /etc/profile
    - require:
      - file: /etc/profile
