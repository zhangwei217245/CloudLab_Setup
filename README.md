# CloudLab_Setup

**Before beginning, we assume PROJNAME="cloudincr-PG0"**
On the head node, it's better to do the following:
```
PROJNAME=`groups | awk '{print $1}'`
```

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
  4. Create directories under `/proj/${PROJNAME}/`
    
    ```
    mkdir -p /proj/${PROJNAME}/setup
    ```
  5. Clone this repo onto into your `setup` folder:
    
    ```
    cd /proj/${PROJNAME}/setup
    git clone "git@github.com:zhangwei217245/CloudLab_Setup.git" 
    ```
    Or if you already cloned this repo into your setup folder, make sure you will pull the latest version from the repo.
    ```
    cd /proj/${PROJNAME}/setup/CloudLab_Setup
    git pull
    ```

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
bash /proj/${PROJNAME}/setup/CloudLab_Setup/mutual_access/mutual_access.sh
./Utils.sh <# of nodes> PUT ~/.ssh/id_rsa ~/.ssh/
```
## Increase the file limit

```
./Utils.sh <# of nodes> LIMIT
```

## Install basic software

```
./Utils.sh <# of nodes> CMD "nohup bash /proj/${PROJNAME}/setup/CloudLab_Setup/installation/install.sh > ~/nohup.out &"
```
Then you run the following until you see "Installation successful!"

```
./Utils.sh <# of nodes> TTY "tail -1 ~/nohup.out"
```

## Create More Valid Partitions

* For `m510` Machines:

```
./Utils.sh <# of nodes> TTY "sudo bash /proj/${PROJNAME}/setup/CloudLab_Setup/fdisk/m510.sh"
```
And you will be all set!

* For `m400` Machines:
```
./Utils.sh <# of nodes> TTY "sudo bash /proj/${PROJNAME}/setup/CloudLab_Setup/fdisk/m400.sh sda"
```

   * Note: The m400 machine will reboot after new partition is created. You should login the head machine after it is rebooted and do the following :
```
./Utils.sh <# of nodes> TTY "bash /proj/${PROJNAME}/setup/CloudLab_Setup/fdisk/formatNmount.sh sda2"
```

* For `r320` Machine:
```
./Utils.sh <# of nodes> TTY "sudo bash /proj/${PROJNAME}/setup/CloudLab_Setup/fdisk/r320.sh sdb"
./Utils.sh <# of nodes> TTY "bash /proj/${PROJNAME}/setup/CloudLab_Setup/fdisk/formatNmount.sh sdb1"
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
./Utils.sh <# of nodes> TTY "bash /proj/${PROJNAME}/setup/CloudLab_Setup/installation/java.sh"
```

## Installing NodeJS
```
./Utils.sh <# of nodes> TTY "bash /proj/${PROJNAME}/setup/CloudLab_Setup/installation/node.sh <armv6l|armv7l|arm64|x86|x64>"
```

## Installing Redis
```
./Utils.sh <# of nodes> TTY "bash /proj/${PROJNAME}/setup/CloudLab_Setup/installation/redis.sh"
```

## Installing MySQL
```
./Utils.sh <# of nodes> TTY "bash /proj/${PROJNAME}/setup/CloudLab_Setup/installation/mysql.sh"
```

## Installing METIS
```
./Utils.sh <# of nodes> TTY "bash /proj/${PROJNAME}/setup/CloudLab_Setup/installation/metis.sh"
```
