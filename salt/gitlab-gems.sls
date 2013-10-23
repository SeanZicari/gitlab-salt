include:
    - ruby
    - gitlab-source

update-gems:
    cmd.run:
        - name: gem update --system
        - require:
            - cmd.script: install_ruby

charlock-gem:
    gem.installed:
        - name: charlock_holmes
        - version: 0.6.9.4
        - require:
            - cmd.run: update-gems

gem-bundle:
    cmd.run:
        - name: bundle install --deployment --without development test mysql aws
        - user: git
        - cwd: /home/git/gitlab
        - require:
            - gem: charlock-gem

##
# WARNING! This totally resets the database!!!
##
##
# BUG: Some step prior to this creates the /home/git/repositories
#      folder as root. The step below fails due to a permission denied
#      with a command run as the 'git' user.
##
gem-database:
    cmd.run:
        # The below command requires the full "yes", not just "y"
        - name: echo yes | bundle exec rake gitlab:setup RAILS_ENV=production
        - user: git
        - cwd: /home/git/gitlab
        - onlyif: '[[ $(sudo -u git -H psql -d gitlabhq_production -c "SELECT COUNT(1) FROM users" 2>/dev/null) ]]'
        - watch:
            - git: gitlab-source
        - require:
            - cmd: gem-bundle
