#!/bin/sh

luhn_checksum() {
        sequence="$1"
        sequence="${sequence//[^0-9]}"
        checksum=0
        table=(0 2 4 6 8 1 3 5 7 90)

        i=${#sequence}
        if [ $(($i % 2)) -ne 0 ]; then
                sequence="0$sequence"
                ((++i))
        fi

        while [ $i -ne 0 ];
        do
                checksum="$(($checksum + ${sequence:$((i - 1)):1}))"

                checksum="$(($checksum + ${table[${sequence:$((i - 2)):1}]}))"
                i=$((i - 2))
        done
        checksum="$(($checksum % 10))"
        echo "$checksum"
}

luhn_checkdigit() {
        check_digit=$(luhn_checksum "${1}0")
        if [ $check_digit -ne 0 ]; then
                check_digit=$((10 - $check_digit))
        fi
        echo "$check_digit"
}

luhn_test() {
        if [ "$(luhn_checksum $1)" == "0" ]; then
                return 0
        else
                return 1
        fi
}

### samsung galaxy s7 edge imei prefix
#imeiprefix="35377308"
### apple iphone 14 pro imei prefix
#imeiprefix="35637858"
### apple iphone 14 pro max imei prefix
imeiprefix="35868632"


### REQUIRE OPKG 'grep' package to be installed

randimei=$(printf "%s" $(head -1 /dev/urandom | hexdump -e '1/1 "%02x""\n"' | grep -m 3 -o -E "^[0-9]{2}"))

sample_imei="$imeiprefix$randimei"

################ TEST #############
#sample_imei="353773086534448"

#if luhn_test "$sample_imei"; then
#       echo "$sample_imei might be a valid IMEI"
#else
#       echo "$sample_imei is an invalid IMEI"
#fi

#echo "$sample_imei would be a valid looking IMEI if you added a $(luhn_checkdigit $sample_imei) to the end"

imei="$sample_imei$(luhn_checkdigit $sample_imei)"
echo -e "AT+EGMR=1,7,\"$imei\"\r" >/dev/ttyUSB2

#cat /dev/ttyUSB2
