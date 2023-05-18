(module conjure-efroot.extract
  {autoload {a conjure.aniseed.core
             config conjure.config
             mapping conjure.mapping
             nvim conjure.aniseed.nvim
             searchpair conjure.extract.searchpair
             str conjure.aniseed.string}})

; Copied from conjure.extract.searchpair
(defn- nil-pos? [pos]
  (or (not pos)
      (= 0 (unpack pos))))

; Copied from conjure.extract.searchpair
(defn- read-range [[srow scol] [erow ecol]]
  (let [lines (nvim.buf_get_lines
                0 (- srow 1) erow false)]
    (-> lines
        (a.update
          (length lines)
          (fn [s]
            (string.sub s 0 ecol)))
        (a.update
          1
          (fn [s]
            (string.sub s scol)))
        (->> (str.join "\n")))))

; Copied from conjure.extract.searchpair
(defn skip-match? []
  (let [[row col] (nvim.win_get_cursor 0)
        stack (nvim.fn.synstack row (a.inc col))
        stack-size (length stack)]
    (if (or
          ;; Are we in a comment, string or regular expression?
          (= :number
             (type
               (and (> stack-size 0)
                    (let [name (nvim.fn.synIDattr (. stack stack-size) :name)]
                      (or (name:find "Comment$")
                          (name:find "String$")
                          (name:find "Regexp%?$"))))))

          ;; Is the character escaped?
          ;; https://github.com/Olical/conjure/issues/209
          (= "\\" (-> (nvim.buf_get_lines
                        (nvim.win_get_buf 0) (- row 1) row false)
                      (a.first)
                      (string.sub col col))))
      1
      0)))

; Copied from conjure.extract.searchpair
(defn- current-char []
  (let [[row col] (nvim.win_get_cursor 0)
        [line] (nvim.buf_get_lines 0 (- row 1) row false)
        char (+ col 1)]
    (string.sub line char char)))

; Copied from conjure.extract.searchpair
(defn- distance-gt [[al ac] [bl bc]]
  (or (> al bl)
      (and (= al bl) (> ac bc))))

; Copied from conjure.extract.searchpair
(defn- range-distance [range]
  (let [[sl sc] range.start
        [el ec] range.end]
    [(- sl el) (- sc ec)]))

(defn- comment-form? [{: content}]
  (= 1 (pick-values 1 (content:find "^%(comment[%s$]"))))

(defn- make-skip-first [n char]
  (var count n)
  (fn skip-first []
    (if (< 0 (skip-match?))
      1
      (if (and (= char (current-char)) (< 0 count)) 
        (do
          ;(print (.. "[" (vim.inspect count) "] Skipping " (current-char) " at " (vim.inspect (nvim.win_get_cursor 0))))
          (set count (a.dec count))
          1)
        0))))

; Adapted from conjure.extract.searchpair.form*
(defn- depth-form [[start-char end-char escape?] depth]
  (var depth (or depth 0))
  (let [;; 'W' don't Wrap around the end of the file
        ;; 'n' do Not move the cursor
        ;; 'z' start searching at the cursor column instead of Zero
        ;; 'b' search Backward instead of forward
        ;; 'c' accept a match at the Cursor position
        ;; 'r' repeat until no more matches found; will find the outer pair
        flags "Wnz"
        cursor-char (current-char)

        safe-start-char
        (if escape?
          (.. "\\" start-char)
          start-char)

        safe-end-char
        (if escape?
          (.. "\\" end-char)
          end-char)

        start (nvim.fn.searchpairpos
                safe-start-char "" safe-end-char
                (.. flags "b" (if (= cursor-char start-char) "c" ""))
                (make-skip-first depth safe-start-char))
        end (nvim.fn.searchpairpos
              safe-start-char "" safe-end-char
              (.. flags (if (= cursor-char end-char) "c" ""))
              (make-skip-first depth safe-end-char))]

    (when (and (not (nil-pos? start))
               (not (nil-pos? end)))
      ; (print (.. "(depth-form)> Got " start-char end-char " form at depth " (tostring depth) ": " (read-range start end)))
      {:range {:start [(a.first start) (a.dec (a.second start))]
               :end [(a.first end) (a.dec (a.second end))]}
       :content (read-range start end)})))

(defn- sort-forms
  [forms]
  (table.sort
    forms
    #(distance-gt
       (range-distance $1.range)
       (range-distance $2.range)))
  forms)

(defn depth-forms [depth]
  (->> (config.get-in [:extract :form_pairs])
       (a.map #(depth-form $1 depth))
       (a.filter a.table?)
       (sort-forms)))

(defn- lc= [x y]
  (and (= (a.first x)  (a.first y))
       (= (a.second x) (a.second y))))

(defn- forms= [x y]
  (and x y
       (= (a.get x :content) (a.get y :content))
       (lc= (a.get-in x [:range :start]) (a.get-in y [:range :start]))
       (lc= (a.get-in x [:range :end]) (a.get-in y [:range :end]))))

(defn- has-form? [forms form]
  (var found? false)
  (var i 1)
  (while (and (not found?) (<= i (length forms)))
    (set found? (forms= form (a.get forms i)))
    (set i (a.inc i)))
  found?)

(defn- form-tree []
  (var root (searchpair.form {:root? true}))
  (var forms [root])
  (var depth -1)

  (var found-root? false)
  (var inserted? true)
  (while inserted?
    (set depth (a.inc depth))
    (set inserted? false)
    (each [_ dform (ipairs (depth-forms depth))]
      ; (print (.. "(form-tree) form at depth " (tostring depth) ": " (a.get dform :content)))
      (if
        (forms= root dform)
        (do
          ; (print "(form-tree) Found root!")
          (set found-root? true))

        (not (has-form? forms dform))
        (do
          ; (print (.. "(form-tree) New form: " (a.get dform :content)))
          (table.insert forms dform)
          (set inserted? true)))))
  (sort-forms forms))

(comment
  (form-tree)
  {:a (form-tree)}
  {:thekey (do [(do (form-tree))])}
  (do
    (tostring "OK")
    (form-tree))
  )

(defn effective-root-form []
  (var tree (form-tree))
  ; (print (.. "Form tree:\n" (vim.inspect tree)))
  (var f (a.last tree))
  (while (and f (comment-form? f))
    (set tree (a.butlast tree))
    (set f (a.last tree)))
  f)

;; Test
; (effective-root-form)
; {:a (effective-root-form)}
; {:thekey (do [(do (effective-root-form))])}
; (do (comment [{:foo (do [(do (effective-root-form))])}]))

(comment
  (effective-root-form)
  {:a (effective-root-form)}
  {:thekey (do [(do (effective-root-form))])}
  (do (comment [{:foo (do [(do (effective-root-form))])}]))
  (do
    (tostring "OK")
    (effective-root-form))
  )
