(use judge)
(import ../src/init :as banquet)

(def books
  [{:name "The Fellowship of the Ring" :word-count 187790}
   {:name "The Two Towers" :word-count 156198}
   {:name "The Return of the King" :word-count 137115}])

(test-stdout (banquet/print books) `
  ╭────────────────────────────┬────────────╮
  │ name                       │ word-count │
  ├────────────────────────────┼────────────┤
  │ The Fellowship of the Ring │ 187790     │
  │ The Two Towers             │ 156198     │
  │ The Return of the King     │ 137115     │
  ╰────────────────────────────┴────────────╯
`)

(test-stdout (banquet/print books :padding 1) `
  ╭────────────────────────────┬────────────╮
  │ name                       │ word-count │
  ├────────────────────────────┼────────────┤
  │ The Fellowship of the Ring │ 187790     │
  │ The Two Towers             │ 156198     │
  │ The Return of the King     │ 137115     │
  ╰────────────────────────────┴────────────╯
`)

(test-stdout (banquet/print books :separate-rows true) `
  ╭────────────────────────────┬────────────╮
  │ name                       │ word-count │
  ├────────────────────────────┼────────────┤
  │ The Fellowship of the Ring │ 187790     │
  ├────────────────────────────┼────────────┤
  │ The Two Towers             │ 156198     │
  ├────────────────────────────┼────────────┤
  │ The Return of the King     │ 137115     │
  ╰────────────────────────────┴────────────╯
`)

(test-stdout (banquet/print books :style banquet/styles/square) `
  ┌────────────────────────────┬────────────┐
  │ name                       │ word-count │
  ├────────────────────────────┼────────────┤
  │ The Fellowship of the Ring │ 187790     │
  │ The Two Towers             │ 156198     │
  │ The Return of the King     │ 137115     │
  └────────────────────────────┴────────────┘
`)

(test-stdout (banquet/print books :style banquet/styles/ascii) `
  .-----------------------------------------.
  | name                       | word-count |
  |----------------------------+------------|
  | The Fellowship of the Ring | 187790     |
  | The Two Towers             | 156198     |
  | The Return of the King     | 137115     |
  '-----------------------------------------'
`)
