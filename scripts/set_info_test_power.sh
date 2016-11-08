#! /bin/sh

i2c_bus=6
i2c_addr=0x34


get_battery_percentage(){
	hex_value=$(get_register_data 0xb9)
	dec_value=$(( $(printf "%d" $hex_value) - 128 ))
	echo -n $dec_value
}

get_battery_status(){
	hex_value=$(get_register_data 0x01)
	dec_value=$(printf "%d" $hex_value)
	
	if [[ $dec_value -ge 64 ]]; then
		echo -n "charging"
	else
		echo -n "discharging"
	fi
}

get_register_data(){
	reg_data=$(i2cget -f -y $i2c_bus $i2c_addr $1)
	echo -n $reg_data
}


modprobe test_power
modprobe i2c_dev

battery_capacity=$(get_battery_percentage)
echo "Battery capacity: $battery_capacity"
echo -n $battery_capacity > /sys/module/test_power/parameters/battery_capacity

battery_status=$(get_battery_status)
echo "Battery status: $battery_status"
echo -n $battery_status > /sys/module/test_power/parameters/battery_status
