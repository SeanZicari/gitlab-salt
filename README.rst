gitlab-local
############

This is an attempt at a complete vagrant install from scratch, which should
work on any server salt can provision.

Getting Started
===============

#. Install `Vagrant <http://www.vagrantup.com/>`_

#. Install salty-vagrant

    ::

        vagrant plugin install vagrant-salt

#. Add the Ubuntu 12.04 base box

    ::

        vagrant box add precise64 http://files.vagrantup.com/precise64.box

#. Fire it up!

    .. code-block:: console

        vagrant up