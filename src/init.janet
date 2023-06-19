(use judge)
(import ./util)
(import ./styles :export true)

(defn- render-cell [value]
  (case (type value)
    :string value
    :nil ""
    (string/format "%q" value)))

(defn- render-row [row] (map render-cell row))

(test (render-row [1 "two" :three nil 5]) @["1" "two" ":three" "" "5"])

(defn- print-separator [column-widths padding [left horizontal sep right]]
  (prin left)
  (eachp [i width] column-widths
    (when (not= i 0)
      (prin sep))
    (prin (string/repeat horizontal (+ width (* padding 2)))))
  (print right))

(defn print-table [rows &named style padding separate-rows]
  (default style styles/round)
  (default padding 1)
  (default separate-rows false)

  (def rendered-rows (map render-row rows))
  (def init (array/new-filled (length (first rows)) 0))
  (def column-widths (reduce |(map max $0 (map length $1)) init rendered-rows))

  (print-separator column-widths padding [(style :top-left) (style :horizontal) (style :top-sep) (style :top-right)])
  (eachp [i row] rendered-rows
    (when (and (not= i 0) (or (= i 1) separate-rows))
      (print-separator column-widths padding [(style :left-sep) (style :horizontal) (style :cross) (style :right-sep)]))

    (eachp [i col] row
      (prin (style :vertical))
      (prin (string/repeat " " padding))
      (def column-width (in column-widths i))
      (prin (util/right-pad col column-width))
      (prin (string/repeat " " padding)))
    (print (style :vertical))
    )
  (print-separator column-widths padding [(style :bottom-left) (style :horizontal) (style :bottom-sep) (style :bottom-right)]))

(defn rows-of-tables [tables]
  (def headers @[])
  (def header-set @{})
  (loop [table :in tables
         header :keys table
         :when (not (in header-set header))]
    (put header-set header true)
    (array/push headers header))

  (def rows @[headers])

  (each table tables
    (array/push rows (seq [header :in headers]
      (in table header))))
  rows)

(defn print [tables & opts]
  (print-table (rows-of-tables tables) ;opts))
