# CloudLab_Setup

**Before beginning, create your profile using this github repo:

1. Login to your cloudlab account
2. Visit this webpage: https://www.cloudlab.us/manage_profile.php
3. Click on the button "GitRepo"
4. Copy and paste the http form of the repository link and confirm. 
5. Create an experiment using the profile you just created. 

## Generate SSH key pair on your own computer, with name as id_rsa

Please refer to https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/

## Add public key id_rsa.pub to your cloudlab account, also you can register your public key in your github account.

## Instantiate multiple machines on CloudLab, and do the following:

## With you private key, do the following:
  1. Encrypt the key again with your password.
    
    ```
    tar cvzf - id_rsa | gpg -o accesskeys.tgz.gpg --symmetric
    ```
  2. Copy the file accesskeys.tgz.gpg to your head node.
    
    ```
    scp accesskeys.tgz.gpg username@hostname:~/.ssh/
    ```
  3. Login to the head node, decrypt the key and copy it to the node
    
    ```
    gpg -d $SCRIPTPATH/accesskeys.tgz.gpg | tar xzvf -
    mv id_rsa ~/.ssh/
    ```
  4. Goto `/local/repository` directory to see all the scripts needed in this tutorial. 

## Initiate Head Node

```
./Utils.sh <# of nodes> HOSTS
```
## If you need to clone your project from any code repository, do the following:
  
  1. For github.com ``` ./Utils.sh <# of nodes> TTY "ssh-keyscan github.com >> ~/.ssh/known_hosts" ```
  2. For gitlab.com ``` ./Utils.sh <# of nodes> TTY "ssh-keyscan gitlab.com >> ~/.ssh/known_hosts" ```
  3. For bitbucket.com ``` ./Utils.sh <# of nodes> TTY "ssh-keyscan bitbucket.com >> ~/.ssh/known_hosts" ```
  4. For gitlab in DISCL: ``` ./Utils.sh <# of nodes> TTY "ssh-keyscan discl.cs.ttu.edu >> ~/.ssh/known_hosts" ```

## Mutural Access is optional(Deprecated)

```
bash /local/repository/mutual_access/mutual_access.sh
./Utils.sh <# of nodes> PUT ~/.ssh/id_rsa ~/.ssh/
```
## Increase the file limit

```
./Utils.sh <# of nodes> LIMIT
```

## Install basic software

```
./Utils.sh <# of nodes> CMD "nohup bash /local/repository/installation/install.sh > ~/nohup.out &"
```
Then you run the following until you see "Installation successful!"

```
./Utils.sh <# of nodes> TTY "tail -1 ~/nohup.out"
```

## Create More Valid Partitions

* For `c220g2` Machines:

```
./Utils.sh <# of nodes> TTY "sudo bash /local/repository/fdisk/c220g2.sh"
```

* For `m510` Machines:

```
./Utils.sh <# of nodes> TTY "sudo bash /local/repository/fdisk/m510.sh"
```
And you will be all set!

* For `m400` Machines:
```
./Utils.sh <# of nodes> TTY "sudo bash /local/repository/fdisk/m400.sh sda"
```

   * Note: The m400 machine will reboot after new partition is created. You should login the head machine after it is rebooted and do the following :
```
./Utils.sh <# of nodes> TTY "bash /local/repository/fdisk/formatNmount.sh sda2"
```

* For `r320` Machine:
```
./Utils.sh <# of nodes> TTY "sudo bash /local/repository/fdisk/r320.sh sdb"
./Utils.sh <# of nodes> TTY "bash /local/repository/fdisk/formatNmount.sh sdb1"
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
