#!/usr/bin/env python
# license removed for brevity
import rospy
from tf import TransformListener
from geometry_msgs.msg import PoseStamped
import tf
  
def gather_tfs(tf_list, pose_publishers, global_frame_id, seq, delta_x, delta_y):
  t = rospy.Time.now()
  pose = PoseStamped
  
  for i in range(len(tf_list)):  
    try:
        pos, ori = tf_listener.lookupTransform(global_frame_id, tf_list[i], rospy.Time(0))
        pose.header.seq = seq
        pose.header.frame_id = global_frame_id
        pose.header.stamp = rospy.get_time()
        pose.pose.position.x = pos[0] + delta_x
        pose.pose.position.y = pos[1] + delta_y
        pose.pose.position.z = pos[2]
        pose.pose.orientation.x = ori[0]
        pose.pose.orientation.y = ori[1]
        pose.pose.orientation.z = ori[2]
        pose.pose.orientation.w = ori[3]
        pose_publishers[i].publish(pose)
    except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException):
        rospy.loginfo_once("Could not get tranform\n")

if __name__ == '__main__':
    rospy.init_node('tf_to_pose')
    tf_listener = TransformListener()

    tfs = rospy.get_param("~frames", default="base_link")
    tf_list = tfs.split(" ")
    rospy.loginfo("Frames: %s", tfs)

    pose_publishers = []
    
    for i in tf_list:
        name = 'pose_' + i
        pose_publishers.append(rospy.Publisher(name, PoseStamped, queue_size=2))

    global_frame_id = rospy.get_param('~global_frame_id', default="world")
    rospy.loginfo("Global Frame: %s", global_frame_id)

    delta_x = rospy.get_param("delta_x", default = 0.0)
    delta_y = rospy.getParam("delta_y", default = 0.0)

  
    # Create a rate
    hz = rospy.get_param("~rate", default = 10.0)
    rate = rospy.Rate(hz)
    seq = 0
    while not rospy.is_shutdown():
        gather_tfs(tf_list, pose_publishers, global_frame_id, seq, delta_x, delta_y)
        rate.sleep()
        seq += 1
