# CloudLab_Setup

## Initiate Head Node

```
./Utils.sh <# of nodes> HOSTS
```

## Mutural Access is essential

```
bash /proj/cloudincr-PG0/setup/CloudLab_Setup/mutual_access/mutual_access.sh
./Utils.sh <# of nodes> PUT ~/.ssh/id_*sa ~/.ssh/
```

## Install basic software

```
./Utils.sh <# of nodes> TTY "bash /proj/cloudincr-PG0/setup/CloudLab_Setup/installation/install.sh"
```

## Create More Valid Partition

1. For `m400` Machines:
```
./Utils.sh <# of nodes> TTY "bash /proj/cloudincr-PG0/setup/CloudLab_Setup/fdisk/m400.sh sda"
```
  * Note: The m400 machine will reboot after new partition is created. You should login the head machine after it is rebooted and do the following :
```
./Utils.sh <# of nodes> TTY "bash /proj/cloudincr-PG0/setup/CloudLab_Setup/fdisk/formatNmount.sh sda2"
```
2. For `r320` Machine:
```
./Utils.sh <# of nodes> TTY "bash /proj/cloudincr-PG0/setup/CloudLab_Setup/fdisk/r320.sh sdb"
./Utils.sh <# of nodes> TTY "bash /proj/cloudincr-PG0/setup/CloudLab_Setup/fdisk/formatNmount.sh sdb1"
```

