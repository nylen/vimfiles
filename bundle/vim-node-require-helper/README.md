Node.vim require() helper
=========================

A plugin for [Node.vim](https://github.com/moll/vim-node) that manages your
`require()` statements for you.

The plugin defines the commands `:Require` and `:Unrequire`, and aliases them
to `:R` and `:UR` if those command names are available.  These commands will
manage the `require()` statements in a Node.js module for you, keeping the
statements sorted and aligned.

These commands assume that all `require()` statements appear in a single block
near the top of the file with no blank lines in between statements.  They can
be used as follows:

    # Add: async = require('async')
    :Require async

    # Add: somelib = require('./lib/somelib')
    :Require ./lib/somelib

    # Add: _ = require('lodash')
    :Require _=lodash

    # Add: MongoClient = require('mongodb').MongoClient
    :Require MongoClient=mongodb.MongoClient
    # or:
    :Require mongodb.MongoClient

Those parameters will all work with the corresponding `:Unrequire` command, but
there, all you really need to specify is the module name (the part inside the
`require('...')` quotes).

Installation
------------

First, install Node.vim:

```
git clone https://github.com/moll/vim-node.git ~/.vim/bundle/vim-node
```

Then, install this plugin:

```
git clone https://github.com/nylen/vim-node-require-helper.git ~/.vim/bundle/vim-node-require-helper
```

If you're using [Pathogen](https://github.com/tpope/vim-pathogen) or similar
(which you should), that's all you have to do.  Otherwise you'll have to add
the directories to your `runtimepath` yourself.

License
-------
The Node.vim require() helper is released under a *Lesser GNU Affero General
Public License*, which in summary means:

- You **can** use this program for **no cost**.
- You **can** use this program for **both personal and commercial reasons**.
- You **do not have to share your own program's code** which uses this program.
- You **have to share modifications** (e.g bug-fixes) you've made to this program.

For more convoluted language, see the `LICENSE` file.


About
-----
If you find that this plugin needs improving or you've got a question, please
don't hesitate to
[create an issue online](https://github.com/nylen/vim-node-require-helper/issues).
