postgresql-9.1:
    pkg.installed

libpq-dev:
    pkg.installed:
        - require:
            - pkg: postgresql-9.1

pg-user:
    postgres_user.present:
        - name: git
        - require:
            - user.present: gitlab-user

pg-db:
    postgres_database.present:
        - name: gitlabhq_production
        - owner: git
        - require:
            - pkg.installed: postgresql-9.1
