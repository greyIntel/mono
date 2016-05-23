#!/bin/sh

DIR=$1; shift
FILELIST=$1; shift
LOFILELIST=$1 ; shift
TARGET=$1; shift
STATIC=$1; shift

HEADER="# Generated by Martin's tool $0, not libtool"

test -f $TARGET && exit 0

rm -f $FILELIST
rm -f $LOFILELIST

while [ "$1" != "--" ]; do
	file=$1; shift
	filename=`basename $file`
	LOFILE=$file.lo
	if [ "$STATIC" = "static" ]; then
		echo "$HEADER\nnon_pic_object='$filename'" > $LOFILE
	else
		echo "$HEADER\npic_object='$filename'" > $LOFILE
	fi
	echo "$DIR/$file " >> $FILELIST
	echo "$DIR/$LOFILE " >> $LOFILELIST
done

(cd $DIR && ar cr $TARGET `cat $FILELIST`)

