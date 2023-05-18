# ConjureMacroexpand

Adds commands `ConjureMacroexpand`, `ConjureMacroexpand0` and
`ConjureMacroexpand1` that will macro-expand the form under the cursor, using
[Conjure](https://github.com/Olical/conjure)'s REPL connection.

This is the one bit of functionality missing from Conjure that kept
[vim-fireplace](https://github.com/tpope/vim-fireplace/) in my Neovim config.

## Installation

Using [vim-plug](https://github.com/junegunn/vim-plug):

```viml
Plug 'walterl/conjure-macroexpand'
```

## Mappings

* `<LocalLeader>cm` - Calls `clojure.walk/macroexpand-all` on the form under the cursor.
* `<LocalLeader>c0` - Calls `clojure.core/macroexpand` on the form under the cursor.
* `<LocalLeader>c1` - Calls `clojure.core/macroexpand-1` on the form under the cursor.

## Configuration

Disable mappings:

```viml
set g:conjure_macroexpand_disable_mappings = 1
```

## License

[MIT](./LICENSE.md)
