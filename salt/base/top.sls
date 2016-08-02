base:
  '*':
    - init.init
prod:
  'linux-node*':
    - cluster.haproxy-outside
    - cluster.haproxy-outside-keepalived
    - bbs.web

  'linux-node2*':
    - bbs.memcached
