gitlab-shell:
    git.latest:
        - name: https://github.com/gitlabhq/gitlab-shell.git
        - target: /home/git/gitlab-shell
        - user: git
        - rev: v1.7.1

gitlab-shell-config:
    file.managed:
        - name: /home/git/gitlab-shell/config.yml
        - source: salt://gitlab-shell/config.yml
        - source_hash: sha256=fd04d25cea33f9b324b38b65f17c87d322c8015082e85dd91eac8d509bf2de17
        - user: git
        - group: git
        - require:
            - git: gitlab-shell

gitlab-install-script:
    cmd.run:
        - name: /home/git/gitlab-shell/bin/install
        - user: git
        - group: git
        - require:
            - git: gitlab-shell
            - file: gitlab-shell-config
