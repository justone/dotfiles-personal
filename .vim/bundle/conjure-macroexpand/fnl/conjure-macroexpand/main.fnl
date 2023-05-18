(module conjure-macroexpand.main
  {require {a aniseed.core
            nvim aniseed.nvim
            str aniseed.string
            bridge conjure.bridge
            client conjure.client
            eval conjure.eval
            extract conjure.extract
            log conjure.log
            mapping conjure.mapping}})

;; Adapted from conjure.eval/current-form
(defn- current-form []
  (let [form (extract.form {})]
    (when form
      (let [{: content} form]
        content))))

(defn- clj-client [f args]
  (client.with-filetype "clojure" f args))

(defn- output-expanded [orig]
  (fn [r]
    (log.append (a.concat [(.. "; " orig)] (str.split r "\n")) {:break? true})))

(defn clj-macroexpand [expand-cmd]
  (let [form (current-form)
        me-form (.. "(" (or expand-cmd "clojure.walk/macroexpand-all") " '" form ")")]
    (clj-client eval.eval-str
                {:origin :conjure-macroexpand
                 :code me-form
                 :passive? true
                 :on-result (output-expanded me-form)})))

(defn add-buf-mappings []
  (mapping.buf :CljMacroexpand "cm" #(clj-macroexpand)
               {:desc "Call macroexpand-all on the symbol under the cursor"})
  (mapping.buf :CljMacroexpand0 "c0" #(clj-macroexpand "clojure.core/macroexpand")
               {:desc "Call macroexpand on the symbol under the cursor"})
  (mapping.buf :CljMacroexpand1 "c1" #(clj-macroexpand "clojure.core/macroexpand-1")
               {:desc "Call macroexpand-1 on the symbol under the cursor"}))

(defn init []
  (when (or (not nvim.g.conjure_macroexpand_disable_mappings)
            (= 0 nvim.g.conjure_macroexpand_disable_mappings))
    (nvim.ex.autocmd
      :FileType "clojure"
      (bridge.viml->lua :conjure-macroexpand.main :add-buf-mappings))))
