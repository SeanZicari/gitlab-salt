include:
    - gitlab-source

nginx:
    pkg.installed

nginx-site:
    file.copy:
        - name: /etc/nginx/sites-available/gitlab
        - source: /home/git/gitlab/lib/support/nginx/gitlab
        - watch:
            - git.latest: gitlab-source
        - require:
            - pkg: nginx

nginx-local-site:
    file.sed:
        - name: /etc/nginx/sites-available/gitlab
        - before: YOUR_SERVER_FQDN
        - after: localhost
        - watch:
            - git.latest: gitlab-source
        - require:
            - file.copy: nginx-site

nginx-enable-site:
    file.symlink:
        - name: /etc/nginx/sites-enabled/gitlab
        - target: /etc/nginx/sites-available/gitlab
        - require:
            - file.sed: nginx-local-site

nginx-service:
    service.running:
        - name: nginx
        - enable: true
        - require:
            - file: nginx-enable-site
        - watch:
            - file.symlink: nginx-enable-site
