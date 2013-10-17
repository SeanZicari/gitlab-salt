ruby:
    pkg.removed

install_ruby:
    cmd.script:
        - source: salt://ruby/install_ruby
        - unless: [[ 'ruby 2.0.0p247 (2013-06-27 revision 41674) [i686-linux]' == "$(ruby --version)" ]]