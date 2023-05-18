# Conjure Ef[fective]root

[Conjure][cnjr] extension that allows evaluating top-level forms, _ignoring
`comment` forms_. That is, evaluating the _effective_ root form: the top-most form
under the cursor that is _not_ a `comment`-form.

During REPL driven development we often evaluate forms in so called
[_Rich comment blocks_][rc]: forms enclosed in a `comment`-form, which
are ignored by the Clojure compiler, but very useful for development with a
REPL.

Conjure supports [evaluating the root form][cer] under the cursor, but when
that root form is a `comment`-form, it dutifully does nothing. This is
technically correct behavior, but it would be more convenient if we could
easily evaluate the _effective_ root form in Rich comments.

Efroot enables that behavior by adding the commands
`ConjureEvalEffectiveRootForm` and `ConjureEvalCommentEffectiveRootForm`, which
does the same as `ConjureEvalRootForm` and `ConjureEvalCommentRootForm`
respectively, but ignores top-level `comment`-forms. These new commands reuse
the original [mappings](#mappings).

Requires [Conjure][cnjr].

[cnjr]: https://github.com/Olical/conjure
[cer]: https://github.com/Olical/conjure/blob/572c971/doc/conjure.txt#L127
[rc]: https://practical.li/clojure/repl-driven-development.html#rich-comment-blocks---living-documentation

## Installation
Using [vim-plug](https://github.com/junegunn/vim-plug):

```viml
Plug 'walterl/conjure-efroot'
```

## Usage
Suppose you are testing generation of a configuration file in your REPL, in a
Rich comment like in this example:

```clojure
(comment
  (do
    (spit "config.edn" (pr-str (generate-config)))
    (let [config (edn/read-string (slurp "config.edn"))]
      (get-in config [:server :port])))
  )
```

When making changes inside the `let`-form's body, you want to re-evaluate the
entire `do`-form, but moving the cursor back and forth between the editing
position and the `do`-form (so you can call [`ConjureEvalCurrentForm`][cee]) is
cumbersome.

Calling `:ConjureEvalEffectiveRootForm` from the `let`-form's body will
evaluate the `do`-form.

[cee]: https://github.com/Olical/conjure/blob/572c971/doc/conjure.txt#L118

## Mappings

* `<LocalLeader>er` - Evaluates the effective root form under the cursor.
* `<LocalLeader>ecr` - Evaluates the effective root form under the cursor and
  adds the result as a comment after the form.

The original `ConjureEvalRootForm` and `ConjureEvalCommentRootForm` commands
are remapped to `<LocalLeader>eR` and `<LocalLeader>ecR`, respectively.

## Caveats
Efroot does not use tree-sitter functionality. It also does more work
than `ConjureEvalRootForm`, increasing with each form nesting level.
Performance _could_ therefore become an issue when evaluating deeply nested
forms, but that has not been observed yet.

This is because Efroot first collects _all_ forms along the form tree,
"between" the current (inner-most) form and the root form, inclusive.

## License
[MIT](./LICENSE.md)
