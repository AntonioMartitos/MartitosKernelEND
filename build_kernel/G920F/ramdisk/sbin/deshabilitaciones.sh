#!/system/bin/sh
#

# Deepsleep fix
su -c 'echo "temporary none" >> /sys/class/scsi_disk/0:0:0:0/cache_type'
su -c 'echo "temporary none" >> /sys/class/scsi_disk/0:0:0:1/cache_type'
su -c 'echo "temporary none" >> /sys/class/scsi_disk/0:0:0:2/cache_type'
su -c 'echo "temporary none" >> /sys/class/scsi_disk/0:0:0:3/cache_type'

# Knox set to 0 on running system
/sbin/resetprop -n ro.boot.warranty_bit "0"
/sbin/resetprop -n ro.warranty_bit "0"

# Samsung related flags
/sbin/resetprop -n ro.fmp_config "1"
/sbin/resetprop -n ro.boot.fmp_config "1"
/sbin/resetprop -n sys.oem_unlock_allowed "0"

# Deepsleep fix
for i in `ls /sys/class/scsi_disk/`; do
	cat /sys/class/scsi_disk/$i/write_protect 2>/dev/null | grep 1 >/dev/null
	if [ $? -eq 0 ]; then
		echo 'temporary none' > /sys/class/scsi_disk/$i/cache_type
	fi
done

