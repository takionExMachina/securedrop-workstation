# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

##
# sd-export-files
# ========
#
# Moves files into place on sd-export
#
##
include:
  - fpf-apt-test-repo

sd-export-template-install-cryptsetup:
  pkg.installed:
    - pkgs:
      - cryptsetup

sd-export-send-to-usb-script:
  file.managed:
    - name: /usr/bin/send-to-usb
    - source: salt://sd/sd-export/send-to-usb
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

sd-export-desktop-file:
  file.managed:
    - name: /usr/share/applications/send-to-usb.desktop
    - source: salt://sd/sd-export/send-to-usb.desktop
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
  cmd.run:
    - name: sudo update-desktop-database /usr/share/applications
    - require:
      - file: sd-export-desktop-file

sd-export-file-format:
  file.managed:
    - name: /usr/share/mime/packages/application-x-sd-export.xml
    - source: salt://sd/sd-export/application-x-sd-export.xml
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
  cmd.run:
    - name: sudo update-mime-database /usr/share/mime
    - require:
      - file: sd-export-file-format
      - file: sd-export-desktop-file
