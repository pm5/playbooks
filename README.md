
Ansible playbooks for my computers
==================================

Usage
-----

        # install dotfiles first
        $ git clone https://github.com/pm5/ansible-playbooks ~/src/ansible-playbooks
        $ cd ~/src/ansible-playbooks
        $ ./macbook <hostname>

Roles
-----

* `macbook`: for MacBooks.
* `nodejs`: install `nvm`, Node.js/Io.js, and
  - jade
  - stylus
  - livescript
  - babel
* `ruby`: install `rvm`, Ruby, and
  - compass
  - moretext
* `python`: install `pyenv`, and Python 2 (already installed for Ansible)
* `erlang`: install Erlang.

License
-------

[MIT License](http://pm5.mit-license.org)
