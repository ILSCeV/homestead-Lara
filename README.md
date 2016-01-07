# homestead-lara-vedst 

This project provides a vagrant machine for development on the [lara-vedst](https://github.com/4D44H/lara-vedst) calender and personnel scheduling tool.

## tl;dr

1. Install Git ([Windows](https://git-for-windows.github.io))
2. Install [VirtualBox 5.0](https://www.virtualbox.org/wiki/Downloads)
3. Install [Vagrant 1.8](https://www.vagrantup.com/downloads.html)
4. Open a console (Powershell, Git Bash, Terminal, ...)
 1. `git clone https://github.com/ThomDietrich/homestead-lara-vedst.git`
 2. `cd homestead-lara-vedst`
 3. `init.bat` / `init.sh`
 4. `vagrant up`
5. Your lara-vedst Source Code in folder "homestead-lara-vedst/Code"
6. Your lara-vedst Website: [http://localhost:8000](http://localhost:8000)

## The details

1. Git will be used to download this project and you will use it later to push changes.
2. VirtualBox will be used as a virtualisation driver by Vagrant. You will not interact with it directly.
3. Vagrant is a nifty tool to make creating and setting up a virtual machine a piece of cake. All you really need is one script file (`Vagrantfile`) which describes how the virtual machine should look and feel (OS, packages, mounts, network, portforwardings,...), the rest is done by Vagrant. magic.
4. Choose any console you like.
 1. This step downloads this project. It is based on [homestead](https://laravel.com/docs/master/homestead), the official Laravel Vagrant-based development environment. The only modifications are in the files `Homestead.yaml` and `after.sh`.
 2. a not so complicated step.
 3. this will create copies of `Homestead.yaml` and `after.sh` for execution in your personal user folder (a confusing step if you ask me)
 4. This will take some minutes and you will probably get some easily solvable errors. Check out other [useful commands for Vagrant](http://www.erikaheidi.com/blog/quick-user-guide-for-vagrant). That's what happens:
     - Downloads the homestead virtual box.
     - The box will be configured according to the `Homestead.yaml` in your personal folder.
     - The box will boot and at first execute a "provisioner", the script `after.sh` in your personal folder.
     - The script will download the latest lara-vest source code and will initialize the database.
     - After the execution was successful, the virtual machine is active in the background. You can connect and interact with it as with any other virtual machine, you don't have to though. 
5. Do your modifications here, the folder is autosynced with the virtual machine
6. Tadaaa

## Windows, Linux, OSX
The setup was tested under Windows 7 x64 but is supposed to be platform independant.
