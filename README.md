# banquet

Fancy tables.

```janet
(def books
  [{:name "The Fellowship of the Ring" :word-count 187790}
   {:name "The Two Towers" :word-count 156198}
   {:name "The Return of the King" :word-count 137115}])

(banquet/print books)

# ╭────────────────────────────┬────────────╮
# │ name                       │ word-count │
# ├────────────────────────────┼────────────┤
# │ The Fellowship of the Ring │ 187790     │
# │ The Two Towers             │ 156198     │
# │ The Return of the King     │ 137115     │
# ╰────────────────────────────┴────────────╯
```

Banquet is a library for laying out text-based tables that represent lists of Janet structs or tables. It pairs well with [Judge](https://github.com/ianthehenry/judge), as you can use Banquet in conjunction with `test-stdout` to write some very readable tests.

# Usage

There are a few options to control the output:

```janet
(banquet/print books :padding 0)

# ╭──────────────────────────┬──────────╮
# │name                      │word-count│
# ├──────────────────────────┼──────────┤
# │The Fellowship of the Ring│187790    │
# │The Two Towers            │156198    │
# │The Return of the King    │137115    │
# ╰──────────────────────────┴──────────╯
```

```janet
(banquet/print books :separate-rows true)

# ╭────────────────────────────┬────────────╮
# │ name                       │ word-count │
# ├────────────────────────────┼────────────┤
# │ The Fellowship of the Ring │ 187790     │
# ├────────────────────────────┼────────────┤
# │ The Two Towers             │ 156198     │
# ├────────────────────────────┼────────────┤
# │ The Return of the King     │ 137115     │
# ╰────────────────────────────┴────────────╯
```

```janet
(banquet/print books :style banquet/styles/square)

# ┌────────────────────────────┬────────────┐
# │ name                       │ word-count │
# ├────────────────────────────┼────────────┤
# │ The Fellowship of the Ring │ 187790     │
# │ The Two Towers             │ 156198     │
# │ The Return of the King     │ 137115     │
# └────────────────────────────┴────────────┘
```

```janet
(banquet/print books :style banquet/styles/ascii)

# .-----------------------------------------.
# | name                       | word-count |
# |----------------------------+------------|
# | The Fellowship of the Ring | 187790     |
# | The Two Towers             | 156198     |
# | The Return of the King     | 137115     |
# '-----------------------------------------'
```

The default style is `banquet/styles/round`. Currently the only styles are:

- `banquet/styles/square`
- `banquet/styles/round`
- `banquet/styles/ascii`

But it's easy to add more.

# API

`banquet/print-rows` takes an iterable of iterables of strings.

    (banquet/print-rows [["x" "x²"] ["1" "2"] ["2" "4"]])

`banquet/print` takes an iterable of dicts, and infers the headers from them.

    (banquet/print [{:x 1 :y 2} {:x 2 :y 4}])

Both can take the optional named arguments `:padding`, `:separate-rows`, and `:style`.

There are lower-level helpers for formatting values and inferring headers from dicts. It's probably easiest to just read the source for those.

# Changelog

# v1.0.0 2023-06-19

Initial release.
