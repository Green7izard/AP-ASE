;; Clojure Day 2
;; Bas van Summeren <BasvanSummeren@hotmail.com>

;;This line is added so that the UnitTest has a name space to refer to. http://nakkaya.com/2009/11/18/unit-testing-in-clojure/
(ns Day2)
(defmacro unless [test body else] (list 'if (list 'not test) body else))

(println "Unless true :incorrect :correct becomes: " (unless true :incorrect :correct))
(println "Unless false :correct :incorrect becomes: " (unless false :correct :incorrect))


(println "\n\nDice protocol: ")

(defprotocol Dice
  (roll [d])
  )

;;https://clojuredocs.org/clojure.core/rand-int
(defrecord DefaultDice [] Dice
     (roll[d](+ (rand-int 6) 1))
     (toString [this] (str "[" (this) "]" ))
     )

(println "Creating a default dice (1 to 6)")
(def aDice (DefaultDice.))
;;https://clojuredocs.org/clojure.core/dotimes
(dotimes [n 10] (println "Rolling a dice: " (roll aDice) ))

(println "\nCreating a D20 (1 to 20)")
(defrecord VariableDice [number] Dice
  (roll[d](+ (rand-int number) 1))
  )
(def d20 (VariableDice. 20))
(dotimes [n 5] (println "Rolling the D20: " (roll d20) ))
(println "Creating a D5000 (1 to 5000)")
(def d5000 (VariableDice. 5000))
(dotimes [n 5] (println "Rolling the D5000: " (roll d5000) ))
