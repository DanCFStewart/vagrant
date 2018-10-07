#A vagrant setup for centos7 with php7.2, apache 2.4 and mysql configured with 3 virtual hosts

Note: This setup uses ip 192.168.42.42  
If this is already in use on your LAN, you will need to edit line 25 in Vagrantfile.  
This uses the libvirt provider by default.  
The vagrant version in the mint repos is fairly old. It's probably a good idea to get the latest .deb from [https://www.vagrantup.com/downloads.html](https://www.vagrantup.com/downloads.html) rather than using apt-get.

Usage:  
  
##Fedora (RHEL) tested on Workstation 28:
This uses the libvirt provider by default.  
Fedora has firewall-cmd to control Linux's iptables, enabled by default. You will need to allow some services for the NFS file sharing between the host and the VM.

`$ firewall-cmd --list-all`  
If you dont see nfs, rpc-bind, and mountd in the line 'services:' add them as follows:  
`$ sudo firewall-cmd --permanent --add-service=nfs`  
`$ sudo firewall-cmd --permanent --add-service=mountd`  
`$ sudo firewall-cmd --permanent --add-service=rpc-bind`  
`$ sudo firewall-cmd --reload`  

If you dont already have vagrant:  
`$ sudo dnf install vagrant`  
You also need the hostmanager plugin:  
`$ vagrant plugin install vagrant-hostmanager`  
If you havent already done so, clone the setup files:  
`$ mkdir vagrant` (or whatever)  
`$ cd vagrant`  
`$ git clone https://github.com/DanCFStewart/vagrant.git`  
`$ cd vagrant/vc7/`  
And then:  
`$ vagrant up`  
You will be prompted for your system password, and then once the image has downloaded and spins up, again in the terminal to allow the nfs exports.  
Point your browser to [http://web1.vc7.test/](http://web1.vc7.test)  
you can ssh into a passwordless sudo acoutnt with:  
`$ vagrant ssh`  
To shut down:  
`$ vagrant halt` (from the host)  
To destroy:  
`$ vagrant destroy`  

##Mint (debian, ubuntu) Tested on Mint 18.3 Sylvia
Mint doesn't come with libvirt by default, on my system this installed on virtualbox.  
`$ sudo apt-get install nfs-common nfs-kernel-server`  
`$ sudo ufw status`  
Mint uses ufw to control iptables, but is not enabled by default. If the command above does not return inactive, you may need to allow the nfs services.  
Install vagrant (see note above. the mint repo has v1.8.0 which did not work well on my system)  
You will need the hostmanager plugin:  
`$ vagrant plugin install vagrant-hostmanager`  
If you havent already done so, clone the setup files:  
`$ mkdir vagrant` (or whatever)  
`$ cd vagrant`  
`$ git clone https://github.com/DanCFStewart/vagrant.git`  
`$ cd vagrant/vc7/`  
And then:  
`$ vagrant up`  

Point your browser to [http://web1.vc7.test/](http://web1.vc7.test)  
you can ssh into a passwordless sudo acoutnt with:  
`$ vagrant ssh`  
To shut down:  
`$ vagrant halt` (from the host)  
To destroy:  
`$ vagrant destroy`  

##Mac OSX Tested on 10.12 Sierra
Mac os uses an older version of nfs than Linux.  
Edit line 61 of Vagrantfile so that it reads:  
`nfs_version: 3,`  
You will probably have some of this stuff already.  
Install Homebrew:  
`$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`  
enable nfs:  
`$ sudo nfsd enable`  
Git:  
`$ brew install git`  
and then:  
`$ brew cask install vagrant`  
`$ brew cask install virtualbox`  
`$ vagrant plugin install vagrant-hostmanager`  
`$ mkdir vagrant` (or whatever)  
`$ cd vagrant`  
`$ git clone https://github.com/DanCFStewart/vagrant.git`  
`$ cd vagrant/vc7/`  
And then:  
`$ vagrant up`  

Point your browser to [http://web1.vc7.test/](http://web1.vc7.test)  
you can ssh into a passwordless sudo acoutnt with:  
`$ vagrant ssh`  
To shut down:  
`$ vagrant halt` (from the host)  
To destroy:  
`$ vagrant destroy`  

