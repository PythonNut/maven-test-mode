;;; Code:
(require 'maven-test-mode-test-fixture)

;;; Basic stuff
;;
(ert-deftest test-task-concatenates-options ()
  (let ((maven-test-test-task-options "-Dtest=my-test and more stuff"))
    (should (equal
	     (maven-test--test-task)
	     "test -Dtest=my-test and more stuff"))))

(ert-deftest test-task-concatenates-options-has-no-sideffects ()
  (should (equal
	   maven-test-test-task-options
	   "-q")))

(ert-deftest test-maven-root-dir ()
  (with-temp-buffer
    (find-file app-file)
    (should (equal
	     (maven-test-root-dir)
	     pom-dir))))

(ert-deftest test-first-match ()
  (with-temp-buffer
    (let ((regexes '("\\(foo.*r\\)\s"
		     "\\(foobar a b.*z\\)\s")))
      (insert "a foo a bar a foobar a baz")
      (goto-char (point-max))
      (should (equal
	       "foobar"
	       (maven-test--get-first-match regexes))))))

(ert-deftest test-toggle-from-nil ()
  (setq maven-test-filter-test-result-summary-only nil)

  (maven-test-toggle-summary-only-filter)
  (should (equal
	   t
	   maven-test-filter-test-result-summary-only)))

(ert-deftest test-toggle-from-t ()
  (setq maven-test-filter-test-result-summary-only t)

  (maven-test-toggle-summary-only-filter)
  (should (equal
  	   nil
  	   maven-test-filter-test-result-summary-only)))
