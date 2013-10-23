include:
    - gitlab-source

logrotate:
    pkg.installed

logrotate-gitlab-conf:
    file.copy:
        - name: /etc/logrotate.d/gitlab
        - source: /home/git/gitlab/lib/support/logrotate/gitlab
        - require:
            - git.latest: gitlab-source
