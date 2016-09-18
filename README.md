# CorpWeb Deployment

## Clone the repo

You'll obviously need to clone this repo in order to use it.
```bash
git clone https://github.com/SnipersCode/CorpWebAnsible
```

## Setup Ansible

You can either read through the directions [at the ansible docs](http://docs.ansible.com/ansible/intro_installation.html) or complete the following.
This repo is a simple Ansible playbook, so if you already have an Ansible setup, you can simply adapt this playbook into your flow or installation.

### Requirements
* "Control machine" (the machine that will be setting up the vm/cloud) must be done on a unix/linux machine.
* "Managed nodes" (the target vm/cloud) must be able to be connected through ssh, though if you are using a cloud provider, the machine should already have an ssh server installed.
* Target **must** be an Ubuntu distribution. This is because the docker install automation follows official docker install for ubuntu.


### Use the install script
1. Move your private ssh key to ~/.ssh/ and name it id_rsa if you are deploying remotely.
2. Run the script 

```bash
sudo ./install.sh
```

### Passwordless Sudo

If you are not using root as the installation user over ssh, you will need to set up passwordless sudo

Because Ansible requires passwordless sudo, you'll need to run the [following commands](http://stackoverflow.com/questions/21870083/specify-sudo-password-for-ansible) on the target machine (through ssh or directly)
```
sudo visudo
```
Then at the very end of the file, add this
```
sshUserName ALL=(ALL) NOPASSWD:ALL
```

## Configure your setup

This basically comes down to editing the config.yml file. Below are the descriptions of each setting.

**Note:** If you are installing remotely, replace the entire
```yml
localhost ansible_connection=local
```
line in hosts.yml to the ip or hostname of the remote target. Example:
```yml
# hosts
[CorpWeb]
alpha.tritaniumindustries.com
```

### config.yml
| Key | Description |
| --- | --- |
| option | this is a very long description |


## Run Ansible

If you are connecting as someone other than root
```
ansible-playbook -i hosts -u YourUserName install.yml -s -K
(put admin password when asked)
```
Otherwise
```
ansible-playbook -i hosts -u root install.yml
```


## Known Bugs
[Docker-py version is checked incorrectly](https://github.com/ansible/ansible/issues/17495)
* Prevents ansible from running successfully
* Docker-py >= 10.0 has issue.
* Fallback to v1.9 until resolved.
[PBKDF2 Out Of Memory](https://github.com/nodejs/node/issues/8571)
* Prevents CorpWeb-API from starting
* Node >= 6.6 has issue.
* Fallback to v6.5 until resolved.
