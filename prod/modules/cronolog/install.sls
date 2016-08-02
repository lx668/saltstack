{% set cronolog_tar = 'cronolog-1.6.2.tar.gz' %}
cronolog-file:
  file.managed:
    - name: /usr/local/src/{{ cronolog_tar }}
    - source: salt://modules/cronolog/files/{{ cronolog_tar }}
    - user: root
    - group: root
    - mode: 755
cronolog-install:
  cmd.run:
    - name: cd /usr/local/src && tar xf {{ cronolog_tar }} && cd cronolog-1.6.2/ && ./configure --prefix=/usr/local/cronolog/ && make && make install && ln -s /usr/local/cronolog/sbin/* /usr/bin/
    - unless: test -L /usr/bin/cronolog
    - require:
      - file: cronolog-file 
