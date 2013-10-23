include:
    - gitlab-source

gitlab-service:
    file.copy:
        - name: /etc/init.d/gitlab
        - source: /home/git/gitlab/lib/support/init.d/gitlab
        - watch:
            - git.latest: gitlab-source

gitlab-autostart:
    cmd.run:
        - name: update-rc.d gitlab defaults 21
        - require:
            - file: gitlab-service
