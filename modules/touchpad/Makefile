obj-m += hid-multitouch.o

all: x86

arm:
	make ARCH=arm CROSS_COMPILE=$(TOOLCHAIN) -C $(KERNEL) M=$(PWD) modules

x86:
	make -C /usr/lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	rm -f *.o *.mod.c *.order *.symvers .test* .*.cmd
	rm -rf .tmp_versions

superclean: clean
	rm -f hid-multitouch.ko
