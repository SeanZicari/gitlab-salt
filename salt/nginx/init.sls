nginx:
    pkg.installed

nginx-site:
    file.managed:
        - name: /etc/nginx/sites-available/gitlab
        - source: salt://nginx/gitlab
        - require:
            - pkg: nginx

nginx-enable-site:
    file.symlink:
        - name: /etc/nginx/sites-enabled/gitlab
        - target: /etc/nginx/sites-available/gitlab
        - require:
            - file: nginx-site

nginx-service:
    service.running:
        - name: nginx
        - enable: true
        - require:
            - file: nginx-enable-site
