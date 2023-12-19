(use judge)
(import ../src/init :as banquet)

(deftest "padding"
  (test-stdout
    (banquet/print-rows [["a" "b"] ["1" "2"]]) `
    ╭───┬───╮
    │ a │ b │
    ├───┼───┤
    │ 1 │ 2 │
    ╰───┴───╯
  `)

  (test-stdout
    (banquet/print-rows [["a" "b"] ["1" "2"]] :padding 1) `
    ╭───┬───╮
    │ a │ b │
    ├───┼───┤
    │ 1 │ 2 │
    ╰───┴───╯
  `))

(deftest "separate-rows"
  (test-stdout
    (banquet/print-rows [["a" "b"] ["1" "2"] ["2" "3"]] :separate-rows false) `
    ╭───┬───╮
    │ a │ b │
    ├───┼───┤
    │ 1 │ 2 │
    │ 2 │ 3 │
    ╰───┴───╯
  `)

  (test-stdout
    (banquet/print-rows [["a" "b"] ["1" "2"] ["2" "3"]] :separate-rows true) `
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
    (banquet/print-rows [(banquet/render-header header) ;(banquet/render-rows rows)])) `
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

(def columns-test
  [{1 :a 2 :b 3 :c 4 :d 5 :e}
   {3 :h 2 :g 4 :i 5 :j 1 :f}])

(test-stdout (banquet/print columns-test :column-order [1 2 3 4 5]) `
  ╭────┬────┬────┬────┬────╮
  │ 1  │ 2  │ 3  │ 4  │ 5  │
  ├────┼────┼────┼────┼────┤
  │ :a │ :b │ :c │ :d │ :e │
  │ :f │ :g │ :h │ :i │ :j │
  ╰────┴────┴────┴────┴────╯
`)

(test-stdout (banquet/print columns-test :column-order [5 4 3 2 1]) `
  ╭────┬────┬────┬────┬────╮
  │ 5  │ 4  │ 3  │ 2  │ 1  │
  ├────┼────┼────┼────┼────┤
  │ :e │ :d │ :c │ :b │ :a │
  │ :j │ :i │ :h │ :g │ :f │
  ╰────┴────┴────┴────┴────╯
`)

(test-stdout (banquet/print columns-test :column-order (-> columns-test first keys sort)) `
  ╭────┬────┬────┬────┬────╮
  │ 1  │ 2  │ 3  │ 4  │ 5  │
  ├────┼────┼────┼────┼────┤
  │ :a │ :b │ :c │ :d │ :e │
  │ :f │ :g │ :h │ :i │ :j │
  ╰────┴────┴────┴────┴────╯
`)

(test-stdout (banquet/print columns-test :column-order (-> columns-test first keys sort reverse)) `
  ╭────┬────┬────┬────┬────╮
  │ 5  │ 4  │ 3  │ 2  │ 1  │
  ├────┼────┼────┼────┼────┤
  │ :e │ :d │ :c │ :b │ :a │
  │ :j │ :i │ :h │ :g │ :f │
  ╰────┴────┴────┴────┴────╯
`)

(test-error (banquet/print columns-test :column-order [5 4 3 2 :a])
  "every value in first row must appear in `:column-order`")

(test-error (banquet/print columns-test :column-order [5 4 3 2])
  "`:column-order` must have the same length as table header")

(test-error (banquet/print columns-test :column-order [5 4 3 2 1 1])
  "`:column-order` must have the same length as table header")
