#A vagrant setup for centos7 with php7.2, apache 2.4 and mysql configured with 3 virtual hosts

Note: This setup uses ip 192.168.42.42  
If this is already in use on your LAN, you will need to edit line 25 in Vagrantfile.  
This uses the libvirt provider by default.

Usage:  
  
##Fedora (RHEL) tested on Workstation 28:
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
`$ cd vc7`  
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

##Mint (debian, ubuntu)

Coming very soon!!

##Mac OSX

Tomorrow
