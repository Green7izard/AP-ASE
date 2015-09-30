;; Clojure Unit Test
;; Bas van Summeren <BasvanSummeren@hotmail.com>
;;https://clojure.github.io/clojure/clojure.test-api.html
;;http://stackoverflow.com/questions/1167601/how-do-i-require-and-provide-clojure-files
;;http://nakkaya.com/2009/11/18/unit-testing-in-clojure/
(load "Day2")
(ns Day2Test
  (:use clojure.test Day2))

(deftest unlessTrue
  (is (= :correct (macroexpand (unless true :incorrect :correct))))
  (is (= :correct (macroexpand (unless (= 1 1) :incorrect :correct)))))

(deftest unlessFalse
  (is (= :correct (macroexpand (unless false :correct :incorrect))))
  (is (= :correct (macroexpand (unless (= 1 "one") :correct :incorrect)))))

(println "\n\n\n\n\n\n\n\n\n\n\n" "Starting Unittests for Day 2 :")
(run-tests)
