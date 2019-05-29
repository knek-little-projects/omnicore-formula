omnicored_group:
  group.present:
    - name: omnicore
    - gid: 1031

omnicored_user:
  user.present:
    - name: omnicore
    - uid: 1031
    - gid: 1031
    - shell: /usr/sbin/nologin
    - createhome: False
    - groups:
      - omnicore
  
/var/lib/omnicored:
  file.directory:
    - user: omnicore
    - group: omnicore
    - dir_mode: 710
    - file_mode: 600
    - recurse:
      - user
      - group
      - mode
      - ignore_dirs

omnicore_download:
  archive.extracted:
    - name: /root/omnicore
    - source: https://bintray.com/artifact/download/omni/OmniBinaries/omnicore-0.4.0-x86_64-linux-gnu.tar.gz
    - source_hash: 03f0da007c70d68fee28641c1ea56566f5d7debbc2858d99977bda409643959a
    - require_in:
      - omnicore_install

omnicore_install:
  cmd.run:
    - name: install -m 0755 -o root -g root -t /usr/bin /root/omnicore/omnicore-0.4.0/bin/*
    - unless: test -f /usr/bin/omnicored
    - require:
      - omnicore_download

omnicored_systemd_config:
  file.managed:
    - name: /lib/systemd/system/omnicored.service
    - source: salt://omnicored/files/omnicored.service
    - require:
      - user: omnicored_user
      - omnicore_install
