#! /bin/sh

gpio_path=/sys/class/gpio
ts_pin=386
ts_gpio=$gpio_path/gpio${ts_pin}

if [[ ! -d $ts_gpio ]]; then
	echo -e "Exporting touchscreen GPIO"
	echo $ts_pin > $gpio_path/export
fi

echo -e "Turning GPIO on"
echo "out" > $ts_gpio/direction
echo 1 > $ts_gpio/value


