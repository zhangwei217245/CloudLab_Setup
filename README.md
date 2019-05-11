# CloudLab_Setup

## Creating CloudLab profile with this repo:

For first time user, create your profile using this github repo:

1. Login to your cloudlab account
2. Visit this webpage: https://www.cloudlab.us/manage_profile.php
3. Click on the button "GitRepo"
4. Copy and paste the http form of the repository link and confirm. And then create the profile. 
5. Create an experiment using the profile you just created. 
6. Any problem with the use of this project, please shoot your email at x-spirit.zhang@ttu.edu

## Generating SSH keys.

For first time user, Generate two SSH key pairs on your own computer, with name as 'id_rsa' and 'cloud_rsa' respectively, under '~/.ssh/' directory.

Please refer to https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/

Afterwards, add public key 'id_rsa.pub'  and 'cloudlab.pub' to your cloudlab account, also you can register 'cloudlab.pub' in your github account.

## Instantiate multiple machines on CloudLab based on the profile you just created.
 
  1. Goto `/local/repository` directory to see all the scripts needed in this tutorial. 
  2. Note that all of these scripts are targeting CloudLab bare metal machine installing Ubuntu 18.04 operating system. 
  3. All of these scripts suppose that the machines in your cluster are connected by a central hub by which these machines are mutually connected to each other. 

## Initiate Head Node

```
./Utils.sh <# of nodes> HOSTS
```

## Mutural Access

### On your local machine

 1. Encrypt the key again with your password.
  
    ```
    tar cvzf - cloud_rsa | gpg -o accesskeys.tgz.gpg --symmetric
    ```
  2. Copy the file accesskeys.tgz.gpg to your head node.
    
    ```
    scp accesskeys.tgz.gpg username@hostname:~/.ssh/
    ```
    
### Go to your head node:

  1. Login to the head node, decrypt the key and copy it to the node
    
    ```
    gpg -d $SCRIPTPATH/accesskeys.tgz.gpg | tar xzvf -
    mv cloud_rsa ~/.ssh/id_rsa
    ```

```
./Utils.sh <# of nodes> PUT ~/.ssh/id_rsa ~/.ssh/
./Utils.sh <# of nodes> TTY 'cd /local/repository; ./Utils.sh <# of nodes> HOSTS'
```

## If you need to clone your project from any code repository, do the following:
  
  1. For github.com ``` ./Utils.sh <# of nodes> TTY "ssh-keyscan github.com >> ~/.ssh/known_hosts" ```
  2. For gitlab.com ``` ./Utils.sh <# of nodes> TTY "ssh-keyscan gitlab.com >> ~/.ssh/known_hosts" ```
  3. For bitbucket.com ``` ./Utils.sh <# of nodes> TTY "ssh-keyscan bitbucket.com >> ~/.ssh/known_hosts" ```
  4. For gitlab in DISCL: ``` ./Utils.sh <# of nodes> TTY "ssh-keyscan discl.cs.ttu.edu >> ~/.ssh/known_hosts" ```
  

## Make the cluster exclusively used by you:

```
./Utils.sh <# of nodes> TTY "bash /local/repository/secure/secure.sh"
```

## Increase the file limit

```
./Utils.sh <# of nodes> LIMIT
```

## Create More Valid Partitions

* For `c220g2` Machines:

```
./Utils.sh <# of nodes> TTY "cd /local/repository/fdisk/; sudo bash ./c220g2.sh"
```

* For `m510` Machines:

```
./Utils.sh <# of nodes> TTY "cd /local/repository/fdisk/; sudo bash ./m510.sh"
```
And you will be all set!

* For `m400` Machines:
```
./Utils.sh <# of nodes> TTY "cd /local/repository/fdisk/; sudo bash ./m400.sh sda"
```

   * Note: The m400 machine will reboot after new partition is created. You should login the head machine after it is rebooted and do the following :
```
./Utils.sh <# of nodes> TTY "cd /local/repository/fdisk/; sudo bash ./formatNmount.sh sda2"
```

* For `r320` Machine:
```
./Utils.sh <# of nodes> TTY "cd /local/repository/fdisk/; sudo bash ./r320.sh sdb"
./Utils.sh <# of nodes> TTY "cd /local/repository/fdisk/; sudo bash ./formatNmount.sh sdb1"
```

## Reboot the nodes:
```
./Utils.sh <# of nodes> TTY "sudo shutdown -r now"
```

## Checking the ulimit:
```
./Utils.sh <# of nodes> TTY "ulimit -a"
```

## Checking Disk Partitioning Result:
```
./Utils.sh <# of nodes> TTY "df -h | grep /data ; ls -l /data | grep 'software'"
```


## Install basic software

```
./Utils.sh <# of nodes> CMD "nohup bash /local/repository/installation/install.sh > ~/nohup.out &"
```
Then you run the following command again and again until you see "Installation successful!"

```
./Utils.sh <# of nodes> TTY "tail -100 ~/nohup.out | grep 'Installation successful'"
```

## Install Docker Environment

```
./Utils.sh <# of nodes> CMD "nohup bash /local/repository/installation/docker.sh > ~/nohup.out &"
```


Then you run the following command again and again until you see "Installation successful!"

```
./Utils.sh <# of nodes> TTY "tail -100 ~/nohup.out | grep 'Installation successful!' "
```

## Install the shell enhancement you like

```
./Utils.sh <# of nodes> TTY "cd /local/repository/installation; bash ./shell_enhance.sh (fish/bash/zsh/bashit)"
```

## Installing Java
```
./Utils.sh <# of nodes> TTY "bash /local/repository/installation/java.sh"
```

## Installing NodeJS
```
./Utils.sh <# of nodes> TTY "bash /local/repository/installation/node.sh <armv6l|armv7l|arm64|x86|x64>"
```

## Installing Redis
```
./Utils.sh <# of nodes> TTY "bash /local/repository/installation/redis.sh"
```

## Installing MySQL
```
./Utils.sh <# of nodes> TTY "bash /local/repository/installation/mysql.sh"
```

## Installing METIS
```
./Utils.sh <# of nodes> TTY "bash /local/repository/installation/metis.sh"
```
