#!/usr/bin/env bb

(require '[clj-yaml.core :as yaml]) ; make kondo happy

(-> (first *command-line-args*)
    (slurp)
    (yaml/parse-string)
    (yaml/generate-string :dumper-options {:flow-style :block})
    (println))
