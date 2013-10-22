include:
        - git

gitlab-source:
    git.latest:
        - name: https://github.com/gitlabhq/gitlabhq.git
        - target: /home/git/gitlab
        - user: git
        - rev: 6-2-stable
        - force_checkout: True
        - require:
            - pkg.installed: git

gitlab-config:
    file.managed:
        - name: /home/git/gitlab/config/gitlab.yml
        - source: salt://gitlab-source/gitlab.yml
        - require:
            - git: gitlab-source

gitlab-satellites:
    file.directory:
        - name: /home/git/gitlab-satellites
        - user: git
        - group: git
        - require:
            - file: gitlab-config

gitlab-uploads:
    file.directory:
        - name: /home/git/gitlab/public/uploads
        - user: git
        - group: git
        - mode: 1755
        - require:
            - file: gitlab-satellites

gitlab-unicorn-config:
    file.copy:
        - name: /home/git/gitlab/config/unicorn.rb
        - source: /home/git/gitlab/config/unicorn.rb.example
        - require:
            - file: gitlab-uploads

gitlab-application.rb:
    file.managed:
        - name: /home/git/gitlab/config/application.rb
        - source: salt://gitlab-source/application.rb
        - user: git
        - group: git
        - require:
            - file: gitlab-unicorn-config

gitlab-rack-attack:
    file.managed:
        - name: /home/git/gitlab/config/initializers/rack_attack.rb
        - source: salt://gitlab-source/rack_attack.rb
        - require:
            - file: gitlab-application.rb

gitlab-git-user:
    cmd.run:
        - name: git config --global user.name "GitLab"
        - unless: git config --global user.name
        - cwd: /home/git/gitlab
        - user: git
        - group: git

gitlab-git-user-email:
    cmd.run:
        - name: git config --global user.email "gitlab@localhost"
        - unless: git config --global user.email
        - cwd: /home/git/gitlab
        - user: git
        - group: git

gitlab-git-config-autocrlf:
    cmd.run:
        - name: git config --global core.autocrlf input
        - require:
            - cmd: gitlab-git-user-email
