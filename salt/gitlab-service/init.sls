gitlab-service:
    file.managed:
        - name: /etc/init.d/gitlab
        - source: salt://gitlab-service/gitlab
        - mode: 775

gitlab-autostart:
    cmd.run:
        - name: update-rc.d gitlab defaults 21
        - require:
            - file: gitlab-service
