
(cl:in-package :asdf)

(defsystem "comp0037_the_boss-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "NewGoalSent" :depends-on ("_package_NewGoalSent"))
    (:file "_package_NewGoalSent" :depends-on ("_package"))
  ))