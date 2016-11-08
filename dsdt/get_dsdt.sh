get_dsdt(){
	_acpi_tables=/sys/firmware/acpi/tables
	mkdir orig decompiled
	
	echo "dsdt.dat"
	sudo cat $_acpi_tables/DSDT > orig/dsdt.dat
	
	for ssdt in $_acpi_tables{,/dynamic}/SSDT*; do
		file_ssdt=$(basename $ssdt:l).dat
		echo "$file_ssdt"
		sudo cat $ssdt > orig/$file_ssdt
	done
	
	echo -e "\nDecompiling DSDT"
	iasl -e orig/ssdt*.dat -d orig/dsdt.dat
	mv orig/*.dsl decompiled/
}
