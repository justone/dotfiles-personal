{:user  {:plugins [[cider/cider-nrepl "0.28.6"]
                   [lein-oneoff  "0.3.2"]
                   [lein-pprint  "1.3.2"]]
         :dependencies [[vvvvalvalval/scope-capture "0.3.2"]
                        [djblue/portal "0.34.2"]
                        ; [hashp "0.2.1"]
                        [pjstadig/humane-test-output "0.11.0"]]
         ; :injections [(require 'sc.api)]
         :injections [(require 'pjstadig.humane-test-output)
                      (pjstadig.humane-test-output/activate!)

                      ; (require 'hashp.core)

                      (binding [*out* *err*] (println " - add-tap pprint to *err*"))
                      (require 'clojure.pprint)
                      ; Create named tap function, so we can remove if desired
                      (defn pprint-tap "Tap that pretty prints"
                         [x]
                         (binding [*out* *err*]
                           (clojure.pprint/pprint x)))
                      (add-tap #'pprint-tap)
                      ]
         :repl-options {:timeout 120000}}

 ;; kaocha test runner
 :kaocha {:aliases
          {"kaocha" ["run" "-m" "kaocha.runner"]}
          :dependencies
          [[lambdaisland/kaocha  "0.0-409"]]}

 ;; allow specifying resources without leaving them modified
 :dev-resources {:resource-paths ["nate-scratch/dev-resources"]}

 :dev-resources-test {:test-paths ["nate-scratch/dev-resources" "test"]}

 ;; add in REBL
 :rebl {:resource-paths ["/home/nate/REBL-0.9.168/REBL-0.9.168.jar"]}

 ;; add in Punk
 :punk {:dependencies
        [[lilactown/punk-adapter-jvm "0.0.8"]]}

 ;; allow specifying a bigger JVM
 :hefty {:jvm-opts ^:replace ["-server" "-XX:MaxMetaspaceSize=1024m" "-Xmx3072m" "-XX:+UseG1GC"]}

 ;; pretty printing exceptions
 :pretty {:plugins [[io.aviso/pretty "0.1.37"]]
          :dependencies [[io.aviso/pretty "0.1.37"]]
          :middleware [io.aviso.lein-pretty/inject]}

 }
