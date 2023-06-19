(use judge)
(import ./util)
(import ./styles :export true)

(defn render-cell [value]
  (case (type value)
    :string value
    :nil ""
    (string/format "%q" value)))

(defn render-header-cell [value]
  (case (type value)
    :keyword (string value)
    :symbol (string/format "'%s" value)
    (string/format "%q" value)))

(defn render-header [header] (map render-header-cell header))
(defn render-row [row] (map render-cell row))
(defn render-rows [rows] (map render-row rows))

(test (render-header [1 "two" :three nil 5]) @["1" "\"two\"" "three" "nil" "5"])
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

  (def init (array/new-filled (length (first rows)) 0))
  (def column-widths (reduce |(map max $0 (map length $1)) init rows))

  (print-separator column-widths padding [(style :top-left) (style :horizontal) (style :top-sep) (style :top-right)])
  (eachp [i row] rows
    (when (and (not= i 0) (or (= i 1) separate-rows))
      (print-separator column-widths padding [(style :left-sep) (style :horizontal) (style :cross) (style :right-sep)]))

    (eachp [i col] row
      (prin (style :vertical))
      (prin (string/repeat " " padding))
      (def column-width (in column-widths i))
      (prin (util/right-pad col column-width))
      (prin (string/repeat " " padding)))
    (print (style :vertical)))
  (print-separator column-widths padding [(style :bottom-left) (style :horizontal) (style :bottom-sep) (style :bottom-right)]))

(defn of-dicts [dicts]
  (def headers @[])
  (def header-set @{})
  (loop [dict :in dicts
         header :keys dict
         :when (not (in header-set header))]
    (put header-set header true)
    (array/push headers header))

  (def rows @[])

  (each dict dicts
    (array/push rows (seq [header :in headers]
      (in dict header))))
  [headers rows])

(defn print [dicts & opts]
  (def [header rows] (of-dicts dicts))
  (print-table [(render-header header) ;(render-rows rows)] ;opts))
