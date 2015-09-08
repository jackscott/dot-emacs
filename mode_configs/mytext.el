(eval-when-compile (require 'cl))
(require 'namespaces)

(namespace text
  :use [cl]
  :import []
  :packages [flyspell
             langtool])


(setq langtool-language-tool-jar
      "/usr/local/Cellar/languagetool/2.8/libexec/languagetool-commandline.jar"
      
      langtool-mother-tongue "en"
      langtool-disabled-rules '("WHITESPACE_RULE"
                                "EN_UNPAIRED_BRACKETS"
                                "COMMA_PARENTHESIS_WHITESPACE"
                                "EN_QUOTES"
                                "ENGLISH_WORD_REPEAT_RULE"
                                ))

;; (ispell-dictionary "en_US")
;; (ispell-local-dictionary-alist '("en_US"
;;                                  "[[:alpha:]]"))

