(module conjure-efroot.eval
  {autoload {buffer conjure.buffer
             client conjure.client
             config conjure.config
             eval conjure.eval
             extract conjure-efroot.extract
             nvim conjure.aniseed.nvim}})

(defn effective-root-form []
  (let [form (extract.effective-root-form)]
    (when form
      (let [{: content : range} form]
        (eval.eval-str
          {:code content
           :range range
           :origin :effective-root-form})))))

; Copied from conjure.eval
(defn- insert-result-comment [tag input]
  (let [buf (nvim.win_get_buf 0)
        comment-prefix (or
                         (config.get-in [:eval :comment_prefix])
                         (client.get :comment-prefix))]
    (when input
      (let [{: content : range} input]
        (eval.eval-str
          {:code content
           :range range
           :origin (.. :comment- tag)
           :suppress-hud? true
           :on-result
           (fn [result]
             (buffer.append-prefixed-line
               buf
               (. range :end)
               comment-prefix
               result))})
        input))))

(defn comment-effective-root-form []
  (insert-result-comment :effective-root-form (extract.effective-root-form)))
