{:user  {:plugins [; [refactor-nrepl "2.3.1"]
                   [cider/cider-nrepl "0.19.0"]
                   [lein-oneoff  "0.3.1"]
                   [lein-pprint  "1.1.1"]]
         ; :dependencies [[vvvvalvalval/scope-capture "0.1.4"]]
         ; :injections [(require 'sc.api)]
         :repl-options {:timeout 120000}
         }

 ;; kaocha test runner
 :kaocha {:aliases
          {"kaocha" ["run" "-m" "kaocha.runner"]}
          :dependencies
          [[lambdaisland/kaocha  "0.0-409"]]}

 ;; allow specifying resources without leaving them modified
 :dev-resources {:resource-paths ["scratch/dev-resources"]}

 ;; allow specifying a bigger JVM
 :hefty {:jvm-opts ^:replace ["-server" "-XX:MaxMetaspaceSize=1024m" "-Xmx3072m" "-XX:+UseG1GC"]}}
