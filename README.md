# CloudLab_Setup

## Generate SSH key pair on your computer, with name as id_rsa

Please refer to https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/

## Add public key id_rsa.pub to your cloudlab account

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

## Initiate Head Node

```
./Utils.sh <# of nodes> HOSTS
```

## Mutural Access is essential(Deprecated)

```
bash /proj/cloudincr-PG0/setup/CloudLab_Setup/mutual_access/mutual_access.sh
./Utils.sh <# of nodes> PUT ~/.ssh/id_*sa ~/.ssh/
```
## Increase the file limit

```
./Utils.sh <# of nodes> LIMIT
```

## Install basic software

```
./Utils.sh <# of nodes> TTY "bash /proj/cloudincr-PG0/setup/CloudLab_Setup/installation/install.sh"
```

## Create More Valid Partitions

* For `m400` Machines:
```
./Utils.sh <# of nodes> TTY "sudo bash /proj/cloudincr-PG0/setup/CloudLab_Setup/fdisk/m400.sh sda"
```

   * Note: The m400 machine will reboot after new partition is created. You should login the head machine after it is rebooted and do the following :
```
./Utils.sh <# of nodes> TTY "sudo bash /proj/cloudincr-PG0/setup/CloudLab_Setup/fdisk/formatNmount.sh sda2"
```

* For `r320` Machine:
```
./Utils.sh <# of nodes> TTY "sudo bash /proj/cloudincr-PG0/setup/CloudLab_Setup/fdisk/r320.sh sdb"
./Utils.sh <# of nodes> TTY "sudo bash /proj/cloudincr-PG0/setup/CloudLab_Setup/fdisk/formatNmount.sh sdb1"
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
./Utils.sh <# of nodes> TTY "bash /proj/cloudincr-PG0/setup/CloudLab_Setup/installation/java.sh"
```

## Installing NodeJS
```
./Utils.sh <# of nodes> TTY "bash /proj/cloudincr-PG0/setup/CloudLab_Setup/installation/node.sh <armv6l|armv7l|arm64|x86|x64>"
```

## Installing Redis
```
./Utils.sh <# of nodes> TTY "bash /proj/cloudincr-PG0/setup/CloudLab_Setup/installation/redis.sh"
```

## Installing MySQL
```
./Utils.sh <# of nodes> TTY "bash /proj/cloudincr-PG0/setup/CloudLab_Setup/installation/mysql.sh"
```

## Installing METIS
```
./Utils.sh <# of nodes> TTY "bash /proj/cloudincr-PG0/setup/CloudLab_Setup/installation/metis.sh"
```
