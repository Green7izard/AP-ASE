;; Clojure Day 1
;; Bas van Summeren <BasvanSummeren@hotmail.com>

(println "Day 1 of Clojure")

(defn big [text leng] (> (count text)leng))

(def testString "Banaan")
(println testString " Bigger then 5: " (big testString 5))
(println testString " Bigger then 6: " (big testString 6))
(println testString " Bigger then 7: " (big testString 7))
(println testString " is: " (count testString) " characters long")

(def testString2 "Minimumtemperaturen")
(println testString2 " Bigger then 10: " (big testString2 10))
(println testString2 " Bigger then 10: " (big testString2 15))
(println testString2 " Bigger then 10: " (big testString2 20))
(println testString2 " is: " (count testString2) " characters long")



(println "\n\nChecking collection types: ")
;;(println (str (type (list 1 2))))
;;https://clojuredocs.org/clojure.core/vector
;;(println (str (type (vector))))
;;https://clojuredocs.org/clojure.core/map
;;(println (str (type {:1 1, :2 2})))
;;http://stackoverflow.com/questions/8352421/javas-switch-equivalent-in-clojure
(defn collection-type [col] ( case(str (class col))
                              "class clojure.lang.PersistentList" :list
                              "class clojure.lang.PersistentVector" :vector
                              "class clojure.lang.PersistentArrayMap" :map
                              "class java.lang.String" :string
                              :notACollection
                              ))

;;(println (str(class (list))))
(println "Testing list (1,2,3) > " (collection-type (list 1 2 3)))
(println "Testing vector [:a :b :c] > " (collection-type [:a :b :c]))
(println "Testing map {:1 1, :2 2} > " (collection-type {:1 1, :2 2}))
(println "Testing string " testString " > " (collection-type testString))
(println "Testing number 5 > " (collection-type 5))
