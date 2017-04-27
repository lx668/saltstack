mkdirs:
  cmd.run:
    - name: "mkdir -p /data/{services,src,scripts,logs}&& touch /data/logs/mkdirs.lock"
    - unless: test -e /data/logs/mkdirs.lock
    - shell: /bin/bash
