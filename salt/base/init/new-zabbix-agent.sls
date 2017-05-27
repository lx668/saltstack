{% set monitor = 'userparameter.conf' %}
zabbix-agent:
  pkg.installed:
    - name: zabbix-agent
  file.managed:
    - name: /etc/zabbix/zabbix_agentd.conf
    - source: salt://init/files/zabbix_agentd.conf
    - template: jinja
    - backup: minion
    - defaults:
      Zabbix_Server: {{ pillar['Zabbix_Server'] }}
      Hostname: {{ grains['fqdn'] }}
    - require:
      - pkg: zabbix-agent
  service.running:
    - enable: True
    - watch:
      - pkg: zabbix-agent
      - file: zabbix-agent

zabbix-monitor:
  file.managed:
    - name: /etc/zabbix/zabbix_agentd.d/{{ monitor }}
    - source: salt://init/files/zabbix_agentd.d/{{ monitor }}
    - user: root
    - group: root
    - mode: 644
  service.running:
    - name: zabbix-agent
    - enable: True
    - watch:
      - file: zabbix-monitor
    - require_in:
      - file: zabbix_agentd.conf.d

zabbix_agentd.conf.d:
  file.directory:
    - name: /etc/zabbix/zabbix_agentd.d
    - watch_in:
      - service: zabbix-agent
    - require:
      - pkg: zabbix-agent
      - file: zabbix-agent

zabbix-script:
  file.recurse:
    - name: /tmp/script
    - source: salt://init/files/script
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 755
    - include_empty: True
