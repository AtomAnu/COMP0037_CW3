; Auto-generated. Do not edit!


(cl:in-package comp0037_the_boss-msg)


;//! \htmlinclude NewGoalSent.msg.html

(cl:defclass <NewGoalSent> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header)))
)

(cl:defclass NewGoalSent (<NewGoalSent>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <NewGoalSent>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'NewGoalSent)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name comp0037_the_boss-msg:<NewGoalSent> is deprecated: use comp0037_the_boss-msg:NewGoalSent instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <NewGoalSent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader comp0037_the_boss-msg:header-val is deprecated.  Use comp0037_the_boss-msg:header instead.")
  (header m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <NewGoalSent>) ostream)
  "Serializes a message object of type '<NewGoalSent>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <NewGoalSent>) istream)
  "Deserializes a message object of type '<NewGoalSent>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<NewGoalSent>)))
  "Returns string type for a message object of type '<NewGoalSent>"
  "comp0037_the_boss/NewGoalSent")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'NewGoalSent)))
  "Returns string type for a message object of type 'NewGoalSent"
  "comp0037_the_boss/NewGoalSent")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<NewGoalSent>)))
  "Returns md5sum for a message object of type '<NewGoalSent>"
  "d7be0bb39af8fb9129d5a76e6b63a290")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'NewGoalSent)))
  "Returns md5sum for a message object of type 'NewGoalSent"
  "d7be0bb39af8fb9129d5a76e6b63a290")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<NewGoalSent>)))
  "Returns full string definition for message of type '<NewGoalSent>"
  (cl:format cl:nil "Header header~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'NewGoalSent)))
  "Returns full string definition for message of type 'NewGoalSent"
  (cl:format cl:nil "Header header~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <NewGoalSent>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <NewGoalSent>))
  "Converts a ROS message object to a list"
  (cl:list 'NewGoalSent
    (cl:cons ':header (header msg))
))
