Stalemoves
===========

Stalemoves is a simple plugin that discourages you from spamming common movement keys.

Introduction
------------
It is common knowledge that spamming the arrow keys is bad practice in Vim. Using the hjkl keys are an improvement but repeatedly using these too can turn out to be an anti-pattern. Using numbered movement (ex. `12k`), searching (`/`, `?`), or other movements (`f`, `t`) as well as a variety of plugins (ex. https://github.com/easymotion/vim-easymotion) can be a much better alternative. The problem is that after bad habbits are ingrained they can be hard to change. The goal of this plugin is to provide slight annoyances when certain low-level movement commands are used.

Usage
-----
The plugin is automatically configured to punish the *h*, *k*, *k*, *l*, *b*, *e*, and *w* commands. After repeating the command 6 times, sleep pauses are added slowly increasing in duration. If the use of the command continues, the line is rot13'ed. Inserting, deleting, copying, or using another movement resets the staleness of the movement.

Configuration
-------------
```vim
" Set the commands that will have staleness added to them
let g:stalemoves_commands = ['h', 'j', 'k', 'l', 'b', 'e', 'w']

" Make the j and k commands run gj and gk (see :help gk). Defaults to ''
let g:stalemoves_arrow_type = "g"

" Sets how many repetitions before slowdown
let g:stalemoves_degrade_start = 6
```
