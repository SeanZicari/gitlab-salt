ruby:
    pkg.removed

install_ruby:
    cmd.script:
        - source: salt://ruby/install_ruby
        - unless: ruby --version
