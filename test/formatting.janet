(use judge)
(import ../src/init :as banquet)

(deftest "padding"
  (test-stdout
    (banquet/print-table [["a" "b"] ["1" "2"]]) `
    ╭───┬───╮
    │ a │ b │
    ├───┼───┤
    │ 1 │ 2 │
    ╰───┴───╯
  `)

  (test-stdout
    (banquet/print-table [["a" "b"] ["1" "2"]] :padding 1) `
    ╭───┬───╮
    │ a │ b │
    ├───┼───┤
    │ 1 │ 2 │
    ╰───┴───╯
  `))

(deftest "separate-rows"
  (test-stdout
    (banquet/print-table [["a" "b"] ["1" "2"] ["2" "3"]] :separate-rows false) `
    ╭───┬───╮
    │ a │ b │
    ├───┼───┤
    │ 1 │ 2 │
    │ 2 │ 3 │
    ╰───┴───╯
  `)

  (test-stdout
    (banquet/print-table [["a" "b"] ["1" "2"] ["2" "3"]] :separate-rows true) `
    ╭───┬───╮
    │ a │ b │
    ├───┼───┤
    │ 1 │ 2 │
    ├───┼───┤
    │ 2 │ 3 │
    ╰───┴───╯
  `))

(def data
  [{:a 1 :b 2}
   {:a 3 :b 4}
   {:a 5}
   {:b 6}])

(test (banquet/of-dicts data)
  [@[:a :b]
   @[@[1 2] @[3 4] @[5 nil] @[nil 6]]])

(test-stdout
  (let [[header rows] (banquet/of-dicts data)]
    (banquet/print-table [(banquet/render-header header) ;(banquet/render-rows rows)])) `
  ╭───┬───╮
  │ a │ b │
  ├───┼───┤
  │ 1 │ 2 │
  │ 3 │ 4 │
  │ 5 │   │
  │   │ 6 │
  ╰───┴───╯
`)

(test-stdout (banquet/print data :face banquet/styles/ascii) `
  ╭───┬───╮
  │ a │ b │
  ├───┼───┤
  │ 1 │ 2 │
  │ 3 │ 4 │
  │ 5 │   │
  │   │ 6 │
  ╰───┴───╯
`)
