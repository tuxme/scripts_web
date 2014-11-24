#!/bin/bash
DATE=`date +%Y%m%d`
BIN_VERIF=`which pngnq`
if [[ -z $BIN_VERIF ]]
	then
		echo "Vous devez installer pngnq"
		echo "debian/ubuntu : sudo apt-get install pngnq"
		echo "redhat/fedora : sudo yum install pngnq"
fi

for var in `find . | grep "\.png$"`
	do
		echo -n "Traitement de $var : "
		TEST=`file $var| grep -v image`
		if [[ -z ${TEST} ]]
			then
				DATA_ORIG=`ls -s1 $var | cut -d" " -f1`
				cp $var ${var}_orig_${DATE}
				BASE_FILE=`echo $var|sed "s#\.png\\$##g"`
				$BIN_VERIF -s 1 -e '.newpng' -f $var
				mv ${BASE_FILE}.newpng $var
				DATA_NEW=`ls -s1 $var | cut -d" " -f1`
				TOT=`echo $((DATA_ORIG - DATA_NEW))`
				echo -e "$TOT\n"
		fi

	done 


