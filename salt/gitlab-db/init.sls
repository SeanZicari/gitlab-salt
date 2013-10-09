gitlab-db:
    file.managed:
        - name: /home/git/gitlab/config/database.yml
        - source: salt://gitlab-db/database.yml
        - user: git
        - mode: 600
