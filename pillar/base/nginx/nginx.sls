{% if grains['osfinger'] == 'CentOS Linux-7' %}
version: 7
codename: trusty
{% elif grains['osfinger'] == 'CentOS-6' %}
version: 6
{% endif %}

{% if grains['oscodename'] == 'precise' %}
codename: precise
{% elif grains['oscodename'] == 'trusty' %}
codename: trusty
{% elif grains['oscodename'] == 'xenial' %}
codename: xenial
{% endif %}
