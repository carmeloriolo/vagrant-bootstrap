# Vagrant bootstrap 🚀🚀

I personally created this setup to have a way to easily provide my Vagrant boxes without creating a new Vagrantfile each time. Now providing a new machine is just simpe as putting a *yaml* file within the *machine* directory.

```
---
configs:
  name: vboxdisplayedname
  box: ubuntu/focal64
  playbooks_prefix: './playbooks'
  scripts_prefix: './scripts'
  network: private
  private_ip_address: 192.168.56.227
  memory: 4096
  cpus: 2
  install_go: never
  install_docker: never
  install_kubeadm: never
  go_version: 1.17.9
```

## How to
Deploy all the machines:
```/bin/sh
make up
```
Destroy all the machines:
```/bin/sh
make destroy
```
Deploy target machine:
```/bin/sh
export VG_MACHINE_CONFIG_PATH=$(pwd)/machines/target.yaml; vagrant up
```
Destroy target machine:
```/bin/sh
export VG_MACHINE_CONFIG_PATH=$(pwd)/machines/target.yaml; vagrant destroy
```

## Provisioners
Provisioners can be found in *scripts* and *playbooks* directories. For each provisioner a related key can be set within the machine's yaml configuration file. So for example in the case of Docker, this can be easily installed by setting:

```
    install_docker: never
```

The only accepted values are **never, always**.

## Configuration values

|  Name               | Description                               |
|-----------------------|-------------------------------------------|
|  name                 | The name displayed in VirtualBox console |
|  box                  |  The Vagrant box |
|  cpus                 |  Number of CPU cores of the VM |
|  memory               |  RAM bytes of the VM |
| network               | Type of network. If *private* also private_ip_address MUST be set. If network != private the network will be public with NAT |
|  shared_mounts        |  List of synced folders |
| private_ip_address    | Must be specified if network is *private* |
|  playbooks_prefix     |  Provisioning Playbooks directory |
|  scripts_prefix       |  Provisioning scripts directory |
|  install_docker       |  Install Docker |
|  install_kubeadm      |  Install Kubeadm |
|  install_go           |  Install Go. If install_go is *always* then go_version MUST be set. |
|  go_version           |  Target Go Version to install. Must be specified if install_go is *always* |



