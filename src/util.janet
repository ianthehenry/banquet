(use judge)

(defn right-pad [str len]
  (string str (string/repeat " " (max 0 (- len (length str))))))

(test (right-pad "abc" 10) "abc       ")

(defn sep-when [list f]
  (var current-chunk nil)
  (def chunks @[])
  (eachp [i el] list
    (when (or (= i 0) (f el))
      (set current-chunk @[])
      (array/push chunks current-chunk))
    (array/push current-chunk el))
  chunks)

(test (sep-when [1 2 3 5 3 6 7 8 10] even?) @[@[1] @[2 3 5 3] @[6 7] @[8] @[10]])

(defn start-of-utf8-sequence? [byte]
  (or (= (band byte 0x80) 0x00)
      (= (band byte 0xc0) 0xc0)))


(test (start-of-utf8-sequence? (in (string/bytes "a") 0)) true)
(test (start-of-utf8-sequence? (in (string/bytes "☃") 0)) true)
(test (start-of-utf8-sequence? (in (string/bytes "☃") 1)) false)

(defn from-byte-array [bytes]
  (string/from-bytes ;bytes))

(defn chars [str]
  (map from-byte-array (sep-when (string/bytes str) start-of-utf8-sequence?)))

(test (chars "abc") @["a" "b" "c"])
(test (chars "☃☃") @["\xE2\x98\x83" "\xE2\x98\x83"])

(defn mapped-table [f & key-values]
  (tabseq [[k v] :in (partition 2 key-values)]
    k (f v)))
