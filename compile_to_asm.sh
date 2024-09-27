# $1: name of the c file to compile to assembly
# $2 output path
opt="$(echo $3 | sed -e "s/-O0/$(cat /etc/gcc.opt)/g") -Wno-error -finline-limit=2"
if ! ./libtool --mode=compile --tag=CC gcc  -masm=intel -DSQLITE_OS_UNIX=1 "$1" -I. -I/home/gabriel/sqlite3/src -I/home/gabriel/sqlite3/ext/rtree -I/home/gabriel/sqlite3/ext/icu -I/home/gabriel/sqlite3/ext/fts3 -I/home/gabriel/sqlite3/ext/async -I/home/gabriel/sqlite3/ext/session -I/home/gabriel/sqlite3/ext/userauth -D_HAVE_SQLITE_CONFIG_H -DBUILD_sqlite -DNDEBUG -I/usr/include/tcl8.6 -DSQLITE_THREADSAFE=1 -DSQLITE_ENABLE_MATH_FUNCTIONS  -DSQLITE_HAVE_ZLIB=1  -DSQLITE_TEMP_STORE=1 -o "$2" -S $opt > /dev/null; then
	echo "error"
	exit 1
fi
# copy the output to asm
true_name=$(dirname "$2")/$(basename "$2" .s)
mv $true_name.o $true_name.s
