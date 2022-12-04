(require '[clojure.string :as str])

(defn parsepair [pair]
    (map read-string (str/split pair #"-"))
)

(defn overlaps [[firststart firstend] [secondstart secondend]]
    (or
        (or (and (<= firststart secondstart) (>= firstend secondend))
            (and (<= secondstart firststart) (>= secondend firstend)))
        (or (and (>= secondstart firststart) (<= secondstart firstend))
            (and (>= secondend firststart) (<= secondend firstend)))
    )
)

(defn solveline [line]
    (println line (#(overlaps (parsepair (first %)) (parsepair (second %))) (str/split line #",")))
    (#(overlaps (parsepair (first %)) (parsepair (second %))) (str/split line #","))
)

(defn solve [lines]
    (reduce + (map #(get {false 0 true 1} (solveline %)) lines))
)

(with-open [rdr (clojure.java.io/reader "cases/input/2")]
    ;; (println (get {false 0 true 1} (solveline "1-2,1-3"))))
    (println (solve (line-seq rdr))))