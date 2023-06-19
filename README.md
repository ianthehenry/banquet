# banquet

Fancy tables.

```janet
(def books
  [{:name "The Fellowship of the Ring" :word-count 187790}
   {:name "The Two Towers" :word-count 156198}
   {:name "The Return of the King" :word-count 137115}])

(banquet/print books)

# ╭──────────────────────────┬───────────╮
# │:name                     │:word-count│
# ├──────────────────────────┼───────────┤
# │The Fellowship of the Ring│187790     │
# │The Two Towers            │156198     │
# │The Return of the King    │137115     │
# ╰──────────────────────────┴───────────╯
```

Banquet is a library for laying out text-based tables that reperesent lists of Janet structs or tables. It's very useful in conjunction with [Judge](https://github.com/ianthehenry/judge), as you can use it in conjunction with `test-stdout` to write some very readable tests.

# Usage

There are a few options to control the output:

```janet
(banquet/print books :padding 1)

# ╭────────────────────────────┬─────────────╮
# │ :name                      │ :word-count │
# ├────────────────────────────┼─────────────┤
# │ The Fellowship of the Ring │ 187790      │
# │ The Two Towers             │ 156198      │
# │ The Return of the King     │ 137115      │
# ╰────────────────────────────┴─────────────╯
```

```janet
(banquet/print books :separate-rows true)

# ╭──────────────────────────┬───────────╮
# │:name                     │:word-count│
# ├──────────────────────────┼───────────┤
# │The Fellowship of the Ring│187790     │
# ├──────────────────────────┼───────────┤
# │The Two Towers            │156198     │
# ├──────────────────────────┼───────────┤
# │The Return of the King    │137115     │
# ╰──────────────────────────┴───────────╯
```

```janet
(banquet/print books :style banquet/styles/square)

# .--------------------------------------.
# |:name                     |:word-count|
# |--------------------------+-----------|
# |The Fellowship of the Ring|187790     |
# |The Two Towers            |156198     |
# |The Return of the King    |137115     |
# '--------------------------------------'


(banquet/print books :style banquet/styles/ascii)

# .--------------------------------------.
# |:name                     |:word-count|
# |--------------------------+-----------|
# |The Fellowship of the Ring|187790     |
# |The Two Towers            |156198     |
# |The Return of the King    |137115     |
# '--------------------------------------'
```

The default style is `banquet/styles/round`. Currently the only styles are:

- `banquet/styles/square`
- `banquet/styles/round`
- `banquet/styles/ascii`

But it's easy to add more.
