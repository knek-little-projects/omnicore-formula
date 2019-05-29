include:
  - .install
  - .service

/etc/omnicore/omnicore.conf:
  file.managed:
    - source: salt://omnicored/templates/omnicore_conf.jinja
    - user: omnicore
    - group: omnicore
    - mode: 710
    - makedirs: True
    - template: jinja
    - require:
      - user: omnicored_user
      - group: omnicored_group
    - watch_in:
      - service: omnicored_service_running
    - require_in:
      - service: omnicored_service_running
