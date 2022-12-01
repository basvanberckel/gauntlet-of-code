(defn solve [lines]
    (loop [[prev & r] (seq lines) result 0]
        (if r
            (recur 
                r 
                (if (< prev (first r))
                    (+ result 1)
                    result
                )
            )
        result)
    )
)
(with-open [rdr (clojure.java.io/reader "cases/input/1")]
    (println (solve (map #(Integer/parseInt %) (line-seq rdr)))))