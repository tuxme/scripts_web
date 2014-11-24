#!/bin/bash
DATE=`date +%Y%m%d`
extenstion=$1
if [[ -z $extenstion ]]
	then
		echo "Vous devez indiquer une extension d'images : ex png/jpg/jpeg ..."
		exit
	else 
		if [[ "$extenstion" == "jpg" ]]
			then
				BIN=jpegoptim
				CASE=JPG
		fi
		if [[ "$extenstion" == "jpeg" ]]
			then
				BIN=jpegoptim
				CASE=JPG
		fi
		if [[ "$extenstion" == "png" ]]
			then
				BIN=pngnq
				CASE=PNG
		fi





fi
BIN_VERIF=`which $BIN`
if [[ -z $BIN_VERIF ]]
	then
		echo "Vous devez installer pngnq et jpegoptim"
		echo "debian/ubuntu : sudo apt-get install pngnq jpegoptim"
		echo "redhat/fedora : sudo yum install pngnq jpegoptim"
fi

for var in `find . | grep "\.$extenstion$"`
	do
		echo -n "Traitement de $var : "
		TEST=`file $var| grep -v image`
		if [[ -z ${TEST} ]]
			then
				if [[ "$CASE" == "PNG" ]]
					then
						DATA_ORIG=`ls -s1 $var | cut -d" " -f1`
						cp $var ${var}_orig_${DATE}
						BASE_FILE=`echo $var|sed "s#\.$extenstion\\$##g"`
						$BIN_VERIF -s 1 -e ".new${extenstion}" -f $var
						mv ${BASE_FILE}.new${extenstion} $var
						DATA_NEW=`ls -s1 $var | cut -d" " -f1`
						TOT=`echo $((DATA_ORIG - DATA_NEW))`
						echo -e "$TOT\n"
				fi
				if [[ "$CASE" == "JPG" ]]
					then	
						cp $var ${var}_orig_${DATE}
						jpegoptim $var
				fi
			else
				echo "$var is not an image"
		fi

	done 


