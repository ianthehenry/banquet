(declare-project
  :name "banquet"
  :description "fancy tables"
  :version "1.0.0"
  :dependencies
    ["https://github.com/ianthehenry/judge.git"])

(declare-source
  :prefix "banquet"
  :source ["src/init.janet"
           "src/styles.janet"
           "src/util.janet"])
