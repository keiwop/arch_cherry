#! /bin/sh

mkdir -p compiled
cd compiled

#Great, it compile it using the path where you've decompiled it...
cp ../work/dsdt.dsl .
iasl -tc dsdt.dsl

#mv dsdt.* compiled/

#cd compiled
mkdir -p kernel/firmware/acpi
cp orig/dsdt.aml kernel/firmware/acpi/
rm -rf orig dsdt.asm dsdt.hex dsdt.dsl

find kernel | cpio -H newc --create > custom_dsdt

sudo cp -v custom_dsdt /boot/
