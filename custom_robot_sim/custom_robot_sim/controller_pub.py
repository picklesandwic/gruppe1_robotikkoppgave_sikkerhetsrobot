import rclpy
import math

from rclpy.node import Node
from builtin_interfaces.msg import Duration
from trajectory_msgs.msg import JointTrajectory , JointTrajectoryPoint


class TrajectoryPublisher(Node):

    def __init__(self):
        super().__init__('topic_desired_trajectory_publisher_node')
        
        timer_period = 1
        self.timer = self.create_timer(timer_period, self.timer_callback)
        self.trajectory_publisher = self.create_publisher(JointTrajectory,"/robot_manipulator_controller/joint_trajectory", 10)


    def timer_callback(self):

        # creating a point
        #goal_positions_1 = [math.pi*-0.5,math.pi*0.36,math.pi*-0.816,math.pi*0.4] #before door
        goal_positions_2 = [math.pi*-0.5,0.0,0.0,0.0] #reach the door handle
        #goal_positions_3 = [math.pi*-0.5,math.pi*0.5,math.pi*-0.36,math.pi*-0.36] #open door
        goal_positions_4 = [0.0,0.0,0.0,0.0] #default
        
        
        #point_msg_1 = JointTrajectoryPoint()
        #point_msg_1.positions = goal_positions_1
        #point_msg_1.time_from_start = Duration(sec=2)

        point_msg_2 = JointTrajectoryPoint()
        point_msg_2.positions = goal_positions_2
        point_msg_2.time_from_start = Duration(sec=4)

        #point_msg_3 = JointTrajectoryPoint()
        #point_msg_3.positions = goal_positions_3
        #point_msg_3.time_from_start = Duration(sec=2)

        point_msg_4 = JointTrajectoryPoint()
        point_msg_4.positions = goal_positions_4
        point_msg_4.time_from_start = Duration(sec=4)

        # adding newly created point into trajectory message
        joints = ['base_to_arm_joint', 'joint_1','joint_2','joint_3']

        my_trajectory_msg = JointTrajectory()
        my_trajectory_msg.joint_names = joints
        my_trajectory_msg.points.append(point_msg_2)
        my_trajectory_msg.points.append(point_msg_4)
        
        self.trajectory_publisher.publish(my_trajectory_msg)


def main(args=None):

    rclpy.init(args=args)
    joint_trajectory_object = TrajectoryPublisher()

    rclpy.spin(joint_trajectory_object)
    
    joint_trajectory_object.destroy_node()
    rclpy.shutdown()


if __name__ == '__main__':
    main()