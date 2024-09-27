mkdir -p build/bin
make clean > /dev/null
rm build/bin/sqlite3
opt="$(echo $1 | sed -e "s/-O0/$(cat /etc/gcc.opt)/g") -Wno-error -finline-limit=2"
make CFLAGS=" $opt" -j -n > log_make.txt
if ! make CFLAGS="$opt" -j; then
	cp ../sqlite3_scripts/shell.c .
	echo "Trying again with previously saved shell.c"
	if ! make CFLAGS="$opt" -j; then
		echo "error make"
		exit 1
	fi
fi
cp sqlite3 build/bin/
