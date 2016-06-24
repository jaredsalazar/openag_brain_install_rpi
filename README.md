openag\_brain\_install\_rpi
---------------------------

This repository for installing the openag\_brain project on a Raspberry Pi.
Unless you are going to be modifying the
[openag\_brain](https://github.com/OpenAgInitiative/openag_brain) code, you
probably want to use the [Docker
setup](https://github.com/OpenAgInitiative/openag_brain_docker_rpi) instead of
this script.

To set up the project, simply clone the repository and run the `install.sh`
file.

    git clone https://github.com/OpenAgInitiative/openag_brain_install_rpi.git
    cd openag_brain_install_rpi
    ./install.sh
    
Run the project
----------------

After installing completely, we need to put this two commands every start of the project

    source ~/opt/ros/indigo/setup.bash
    source ~/catkin_ws/devel/setup.bash
    
then, put this command to run the project.

    rosrun openag_brain main

