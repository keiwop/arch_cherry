#include 	"linux/i2c-dev.h"
/*#include 	<linux/i2c.h>*/
#include 	<stdlib.h>
#include 	<stdio.h>
#include 	<fcntl.h>
#include 	<unistd.h>
#include 	<sys/ioctl.h>
#include 	<errno.h>
#include 	<string.h>

int main(int argc, char **argv){
	char *i2c_dev_path = "/dev/i2c-6";
	int i2c_dev;
	int i2c_addr = 0x34;
	__u8 i2c_reg = 0x01;
	__s32 res;
	char buf[4];
	
	
	printf("Hello\n");
	
	i2c_dev = open(i2c_dev_path, O_RDWR);
	if(i2c_dev < 0){
		fprintf(stderr, "error opening file: %s (%d)\n", strerror(errno), errno);
		return 1;
	}
	
	if(ioctl(i2c_dev, I2C_SLAVE, i2c_addr) < 0){
		fprintf(stderr, "error communicating with device: %s (%d)\n", strerror(errno), errno);
		return 1;
	}
	
/*	res = i2c_smbus_read_byte_data(i2c_dev, i2c_reg);*/
	buf[0] = i2c_reg;
	if(read(i2c_dev, buf, 1) != 1){
		fprintf(stderr, "error reading from device: %s (%d)\n", strerror(errno), errno);
		return 1;
	}
	else{
		printf("Register %d: %d\n", i2c_reg, res);
	}
	
	
	close(i2c_dev);
	return 0;
}
