from setuptools import setup
import os
from glob import glob

package_name = 'custom_robot_sim'

setup(
    name=package_name,
    version='0.0.0',
    packages=[package_name],
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
            (os.path.join('share', package_name, 'launch'), glob(os.path.join('launch', '*.launch.py'))),
            (os.path.join('share', package_name, 'urdf'), glob(os.path.join('urdf', '*.xacro'))),
            (os.path.join('share', package_name, 'meshes'), glob(os.path.join('meshes', '*.stl'))),
            (os.path.join('share', package_name, 'config'), glob(os.path.join('config', '*.yaml'))),

        ('share/' + package_name, ['package.xml']),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='rocotics',
    maintainer_email='rocotics@todo.todo',
    description='TODO: Package description',
    license='TODO: License declaration',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            'reload_robot_model = custom_robot_sim.reload_robot_model:main',
            'controller_pub = custom_robot_sim.controller_pub:main',
            'gripper_pub = custom_robot_sim.gripper_pub:main',
            'controller_action = custom_robot_sim.controller_action:main'
        ],
    },
)
