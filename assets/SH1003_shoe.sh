#!/bin/bash



# è¨ç®BMI
function shoe
{
  
  P1=$(echo $1 | tr A-Z a-z);
  P2=$(echo $2 | tr A-Z a-z);
  P3=$(echo $3 | tr A-Z a-z);
  
  
  INPUT="SH1003_shoe_M.data"
  if [[ $P1 -ne "m" ]]; then
    INPUT="SH1003_shoe_F.data"
  fi
  
  
  OLDIFS=$IFS
  IFS=$'\t'
  [ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
  while read f1 f2 f3 f4 f5
  do
  	#echo "ðºð¸ç¾å : $f1"
  	#echo "ð¬ð§è±å : $f2"
  	#echo "ðªðºæ­æ´² : $f3"
  	#echo "ð¯ðµæ¥æ¬ : $f4"
  	#echo "ð¹ð¼å°ç£ : $f5"
	#
	#echo "ðºð¸ç¾å,ð¬ð§è±å,ðªðºæ­æ´²,ð¯ðµæ¥æ¬,ð¹ð¼å°ç£"
	#echo "$f1,$f2,$f3,$f4,$f5"
	
	
	
	#echo "P2=[$P2]"
	#echo "[$f1]"
	
	#[ `echo "$P3 = $f1" | bc` -eq 1 ]
	
	# https://gadget.chienwen.net/x/table/shoes
	
	#echo "`echo "$P3 == $f1" | bc`"
  	
    # if [[ $P2 -eq "us" ]] && [[ `echo "$P3 == $f1" | bc` -eq "1" ]]; then
	
	if [[ $P2 == "us" ]] && [[ `echo "$P3 == $f1" | bc` -eq 1 ]]; then
  	  #echo "f1=[$f1],P3=[$P3]"
	  
	  echo "ðºð¸ç¾å : $f1"
  	  echo "ð¬ð§è±å : $f2"
  	  echo "ðªðºæ­æ´² : $f3"
  	  echo "ð¯ðµæ¥æ¬ : $f4"
  	  echo "ð¹ð¼å°ç£ : $f5"
    elif [[ $P2 == "gb" ]] && [[ `echo "$P3 == $f2" | bc` -eq 1 ]]; then
	  #echo "f2=[$f2],P3=[$P3]"
	
  	  echo "ðºð¸ç¾å : $f1"
  	  echo "ð¬ð§è±å : $f2"
  	  echo "ðªðºæ­æ´² : $f3"
  	  echo "ð¯ðµæ¥æ¬ : $f4"
  	  echo "ð¹ð¼å°ç£ : $f5"
    elif [[ $P2 == "eu" ]] && [[ `echo "$P3 == $f3" | bc` -eq 1 ]]; then
	  #echo "f3=[$f3],P3=[$P3]"
	  
  	  echo "ðºð¸ç¾å : $f1"
  	  echo "ð¬ð§è±å : $f2"
  	  echo "ðªðºæ­æ´² : $f3"
  	  echo "ð¯ðµæ¥æ¬ : $f4"
  	  echo "ð¹ð¼å°ç£ : $f5"
    elif [[ $P2 == "jp" ]] && [[ `echo "$P3 == $f4" | bc` -eq 1 ]]; then
  	  #echo "f4=[$f4],P3=[$P3]"
	  
	  echo "ðºð¸ç¾å : $f1"
  	  echo "ð¬ð§è±å : $f2"
  	  echo "ðªðºæ­æ´² : $f3"
  	  echo "ð¯ðµæ¥æ¬ : $f4"
  	  echo "ð¹ð¼å°ç£ : $f5"
    elif [[ $P2 == "tw" ]] && [[ `echo "$P3 == $f5" | bc` -eq 1 ]]; then
  	  #echo "f5=[$f5],P3=[$P3]"
	  
	  echo "ðºð¸ç¾å : $f1"
  	  echo "ð¬ð§è±å : $f2"
  	  echo "ðªðºæ­æ´² : $f3"
  	  echo "ð¯ðµæ¥æ¬ : $f4"
  	  echo "ð¹ð¼å°ç£ : $f5"
    fi

  	
  done < $INPUT
  IFS=$OLDIFS
  
  
}




shoe $1 $2 $3




exit  0






