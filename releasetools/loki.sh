#!/sbin/sh
#
# This leverages the loki_patch utility created by djrbliss
# See here for more information on loki: https://github.com/djrbliss/loki
#

export C=/tmp/loki_tmpdir
OVERLAP_STRING="addresses overlap"

mkdir -p $C
dd if=/dev/block/platform/msm_sdcc.1/by-name/aboot of=$C/aboot.img
if grep -q "$OVERLAP_STRING" $C/aboot.img ; then
    echo "KitKat aboot detected, bypassing Loki."
    exit 0
fi
/system/bin/loki_tool patch boot $C/aboot.img /tmp/boot.img $C/boot.lok || exit 1
/system/bin/loki_tool flash boot $C/boot.lok || exit 1
rm -rf $C
exit 0
