yum_repo_release:
  pkg.installed:
    - sources:
      - epel-release: http://mirrors.aliyun.com/epel/epel-release-latest-7.noarch.rpm
      - epel-zabbix: http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm
    - unless: rpm -qa | grep epel-release-latest-7
    - unless: rpm -qa | grep zabbix-release-3.2