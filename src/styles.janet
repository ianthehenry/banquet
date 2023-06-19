(use judge)
(import ./util)

(def- style-indices
  {:top-left 0
   :horizontal 1
   :top-sep 2
   :top-right 4
   :vertical 5
   :left-sep 10
   :cross 12
   :right-sep 14
   :bottom-left 20
   :bottom-sep 22
   :bottom-right 24})

(defn- extract-style [style]
  (def chars (filter |(case $ " " false "\n" false true) (util/chars style)))
  (tabseq [[name index] :pairs style-indices]
    name (in chars index)))

(def round (extract-style
  `╭─┬─╮
   │x│x│
   ├─┼─┤
   │x│x│
   ╰─┴─╯`))

(def square (extract-style
  `┌─┬─┐
   │x│x│
   ├─┼─┤
   │x│x│
   └─┴─┘`))

(def ascii (extract-style
  `.---.
   |x|x|
   |-+-|
   |x|x|
   '---'`))

(test-stdout (eachp [key char] round (printf "%q %s" key char)) `
  :top-right ╮
  :left-sep ├
  :bottom-right ╯
  :top-sep ┬
  :bottom-sep ┴
  :cross ┼
  :top-left ╭
  :horizontal ─
  :bottom-left ╰
  :right-sep ┤
  :vertical │
`)
