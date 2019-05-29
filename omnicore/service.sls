omnicored_service_running:
  service.running:
    - name: omnicored
    - enable: True
    - require:
      - file: /lib/systemd/system/omnicored.service
