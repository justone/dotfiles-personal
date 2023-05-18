(module conjure-efroot.main
  {autoload {a conjure.aniseed.core
             bridge conjure.bridge
             config conjure.config
             mapping conjure.mapping
             nvim conjure.aniseed.nvim
             str conjure.aniseed.string
             eval conjure-efroot.eval}})

(defn on-filetype []
  (mapping.buf :EvalEffectiveRootForm "er" #(eval.effective-root-form)
               {:desc "Evaluate the effective root form"})
  (mapping.buf :EvalCommentEffectiveRootForm "ecr" #(eval.comment-effective-root-form)
               {:desc "Evaluate the effective root form into a comment"}))

(defn init []
  ;; Remap original "eval root" commands
  (config.assoc-in [:mapping :eval_root_form] "eR")
  (config.assoc-in [:mapping :eval_comment_root_form] "ecR")

  (nvim.ex.autocmd
    :FileType (str.join "," (config.filetypes))
    (bridge.viml->lua :conjure-efroot.main :on-filetype {})))
