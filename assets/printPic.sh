#!/bin/bash
##########################################
#     printPic.sh                      #
# ------------------------------------   #
# Author: rockexe0000                    #
# Date: 2022.02.10                       #
# Version: v1.00                         #
# Description: Print picture             #
# Last modified on 2022.02.10            #
##########################################



## 設置重覆執行鎖 ##
setlock(){

  FUNC_MODE=$1
  
  FUNC_LCFILE="${LOGFILE}.lc"
  
  case ${FUNC_MODE} in
    "UNLOCK"|"CLEAR")	
      rm ${FUNC_LCFILE}
      ;;
    *)
      if [[ -f ${FUNC_LCFILE} ]]
      then
      	echo 'Error : 本程序已在執行中或不正常原因中斷！' | tee -a ${LOGFILE}
      	echo "        確定要重新執行，請先清除防重覆執行鎖：${FUNC_LCFILE}"
      	exit 1
      fi
      echo "$( date '+%Y-%m-%d %H:%M:%S' )" > ${FUNC_LCFILE}
    ;;
  esac
}


## 紀錄開始時間 輸出到檔案 ##
processStartTime(){
  processStartTime_time=$1;
  processStartTime_LOGFILE=$2;
  echo "	${processStartTime_time}_start $( date '+%Y-%m-%d %H:%M:%S' )" | tee -a ${processStartTime_LOGFILE};
  eval ${processStartTime_time}_start_time=$(date +%s);
  #echo $(eval echo "\$${processStartTime_time}_start_time") | tee -a ${processStartTime_LOGFILE};
}

## 紀錄結束時間 順便計算出花費的時間 輸出到檔案 ##
processEndTime(){
  processEndTime_time=$1;
  processEndTime_LOGFILE=$2;
  echo "	${processEndTime_time}_end $( date '+%Y-%m-%d %H:%M:%S' )" | tee -a ${processEndTime_LOGFILE};
  eval ${processEndTime_time}_end_time=$(date +%s);
  #echo $(eval echo "\$${processEndTime_time}_end_time") | tee -a ${processEndTime_LOGFILE};
  eval ${processEndTime_time}_diff_time=$(expr $(eval echo "\$${processEndTime_time}_end_time") - $(eval echo "\$${processEndTime_time}_start_time"));
  #expr $(eval echo "\$${processEndTime_time}_end_time") - $(eval echo "\$${processEndTime_time}_start_time");
  #echo $(eval echo "\$${processEndTime_time}_diff_time") | tee -a ${processEndTime_LOGFILE};
  eval ${processEndTime_time}_timeM=$(expr $(eval echo "\$${processEndTime_time}_diff_time") / 60);
  eval ${processEndTime_time}_timeS=$(expr $(eval echo "\$${processEndTime_time}_diff_time") % 60);
  echo "	${processEndTime_time}_執行時間:$(eval echo "\$${processEndTime_time}_timeM")分$(eval echo "\$${processEndTime_time}_timeS")秒" | tee -a ${processEndTime_LOGFILE};
  
  unset $(eval echo "${processEndTime_time}_start_time");
  unset $(eval echo "${processEndTime_time}_end_time");
  unset $(eval echo "${processEndTime_time}_diff_time");
  unset $(eval echo "${processEndTime_time}_timeM");
  unset $(eval echo "${processEndTime_time}_timeS");
}


## 離開前 寫入retcode 到 LOGFILE 寄出EMail 然後 setlock UNLOCK ##
endExit(){
  ## 寄EMail
#  sendMail(){
#    sendMail_retcode=$1;
#    
#    if [ $send_email == "Y" ];then
#    	
#    	if [ $sendMail_retcode == 0 ];then
#    		MailText="(通過)";
#    		MailWord=$(echo "${MailWord}\n輸入參數=[${AllParameterNums}],\n[retcode=$retcode]\n\n$(cat ${outputFile})\n\n$(cat ${LOGFILE_TMP})\n");
#    		
#    	else
#    		MailText="(有疑慮)";
#    		MailWord=$(echo "${MailWord}\n輸入參數=[${AllParameterNums}],\n[retcode=$retcode]\n\n$(cat ${outputFile})\n\n$(cat ${LOGFILE_TMP})\n");
#    	fi
#    	
#    	tar -cvpf ${LOGFILE}.tar ${LOGFILE};
#    	gzip -9 ${LOGFILE}.tar;
#    	MailLog="${LOGFILE}.tar.gz";
#    	
#    	tar -cvpf ${JAVALOGFILE}.tar ${JAVALOGFILE};
#    	gzip -9 ${JAVALOGFILE}.tar;
#    	MailJavaLog="${JAVALOGFILE}.tar.gz";
#    	
#    	
#    	$EMAIL "$Developer_MAILLIST" "" "${MailText}${OPCODE}_${YYYMMDD}_$(whoami): logfile" " " "$MailLog" "$MailJavaLog">> ${LOGFILE} 2>&1;
#    	$EMAIL "$Operator_MAILLIST" "" "${MailText}${OPCODE}_${YYYMMDD}_$(whoami):檢核結果" "${MailWord}" >> ${LOGFILE} 2>&1;
#    	rm -f ${MailLog};
#    	rm -f ${MailJavaLog};
#    	
#    fi
#  }

  retcode=$1;

  #echo "使用者輸入參數為: $AllParameterNums" | tee -a ${LOGFILE};
  #sendMail $retcode;
  rm -f ${LOGFILE_TMP};
  echo "[retcode=$retcode]" | tee -a ${LOGFILE};  ## 需紀錄 retcode for FMPS
  setlock UNLOCK;
  exit 0;
}




## 檢查 shell 執行參數, 根據參數決定檔案路徑及位置 ##
CheckShellParameter(){
	
  ## 使用者說明
  printUsage(){
    echo " Purpose: Print picture"
    echo " Usage: bash `basename $0` [印出項目] [寬度<1~20>]"
    echo "  exp1: bash `basename $0` 2-1-12 5"
    echo "  exp2: bash `basename $0` 2-1-13 6"
    echo "  exp3: bash `basename $0` 2-1-14 7"
    echo "  exp4: bash `basename $0` 2-1-15 8"
    echo "  exp5: bash `basename $0` 2-1-16 9"
#    echo "  exp6: bash `basename $0` cpu (列出CPU)"
#    echo "  exp7: bash `basename $0` memory (列出記憶體)"
#    echo "  exp8: bash `basename $0` storage (列出儲存空間)"
	
    endExit $1;
  }
	
  P1=$(echo $1 | tr A-Z a-z);
  P2=$2;
#  P3=$3;
#  P4=$(echo $4 | tr A-Z a-z);
#  P5=$5;

  ## 檢查參數數量 ##
  if [ $ParameterNums -ne 2 ]; then
  	echo "ParameterNums=[$ParameterNums] 參數數量錯誤" | tee -a ${LOGFILE};
  	printUsage 1101;
  fi
  
  ###檢查[印出項目]參數是否錯誤 ##
  if [[ $P1 != "2-1-12" ]] && [[ $P1 != "2-1-13" ]] && [[ $P1 != "2-1-14" ]] && [[ $P1 != "2-1-15" ]] && [[ $P1 != "2-1-16" ]]; then ##檢查數值合理性
    echo "印出項目=[$P1] 請輸入正確的印出項目" | tee -a ${LOGFILE};
    printUsage 1102;
  fi
  
  ###檢查[寬度]參數是否錯誤 ##
  if [[ ! -n $P2 ]] || [[ $P2 -ne $P2 ]] || [[ $P2 -lt 1 ]] || [[ 20 -lt $P2 ]]; then
    echo "寬度=[$P2] 請輸入正確的寬度" | tee -a ${LOGFILE};
    printUsage 1102;
  fi
	
}






##處理printPic
printPicProcess(){

  echo "##########################################################################################################################################" >> ${LOGFILE} 2>&1
  echo "===============================================================================================" >> ${LOGFILE} 2>&1
  processStartTime "${OPCODE}" "${LOGFILE}";
  
  
  ####################################
  
  
  
  P1=$(echo $1 | tr A-Z a-z);
  
  if [ $P1 == "2-1-12" ]; then
	
	for (( y=0 ; y<$P2 ; y=y+1 ))
    do
      for (( x=0 ; x<$P2 ; x=x+1 ))
      do
	    #echo "$x,$(($P2-$y))"
	    if [[ $x -lt $P2-$y ]]; then
      	  echo -n -e "* "
		else
		  echo -n -e "  "
		fi
		
      done
	  echo ""
	done
	
  elif [ $P1 == "2-1-13" ]; then
		
	for (( y=0 ; y<$P2 ; y=y+1 ))
    do
      for (( x=0 ; x<$P2 ; x=x+1 ))
      do
	    if [[ $P2-$y-2 -lt $x ]]; then
      	  echo -n -e "* "
		else
		  echo -n -e "  "
		fi
		
      done
	  echo ""
	done
	
  elif [ $P1 == "2-1-14" ]; then
		
	for (( y=0 ; y<$P2 ; y=y+1 ))
    do
      for (( x=0 ; x<$P2 ; x=x+1 ))
      do
	    if [[ $x == 0 ]] || [[ $x == $(($P2-1)) ]] || [[ $y == 0 ]] || [[ $y == $(($P2-1)) ]]; then
      	  echo -n -e "* "
		else
		  echo -n -e "  "
		fi
		
      done
	  echo ""
	done
	
  elif [ $P1 == "2-1-15" ]; then
		
	for (( y=0 ; y<$P2 ; y=y+1 ))
    do
      for (( x=0 ; x<$P2 ; x=x+1 ))
      do
	    if [[ $y -le $x ]] && [[ $x -lt $(($P2-$y)) ]]; then
      	  echo -n -e "* "
		elif [[ $P2%2 -eq 1 ]] && [[ $x -le $y ]] && [[ $P2-$y-2 -lt $x ]]; then
      	  echo -n -e "* "
		elif [[ $P2%2 -eq 0 ]] && [[ $y -ne $P2-1 ]] && [[ $x-1 -le $y ]] && [[ $P2-$y-2 -lt $x+1 ]]; then
      	  echo -n -e "* "
		else
		  echo -n -e "  "
		fi
		
      done
	  echo ""
	done
	
  elif [ $P1 == "2-1-16" ]; then
		
	for (( y=0 ; y<$P2 ; y=y+1 ))
    do
      for (( x=0 ; x<$P2 ; x=x+1 ))
      do
	    if [[ $(($P2/2-y)) -le $x ]] && [[ $x -lt $(($P2/2+y+($P2%2))) ]] && [[ $((y-$P2/2)) -le $x ]] && [[ $x -lt $(($P2+$P2/2-y)) ]]; then
      	  echo -n -e "* "
		else
		  echo -n -e "  "
		fi
		
      done
	  echo ""
	done
	
  else
	printUsage 9999;
  fi
  
  
  ####################################
  
  #checkERROR_LOGFILE_TMP=$(cat ${LOGFILE_TMP} | grep ERROR);
  
  
  echo "";
  processEndTime "${OPCODE}" "${LOGFILE}";
  echo "===============================================================================================" >> ${LOGFILE} 2>&1

} 








ParameterNums=$#;
AllParameterNums=$@;


#引入環境變數


send_email="N";

year=`date +%Y`;
yyy=`expr $year - 1911`;
mm=`date +%m`;
dd=`date +%d`;
YYYMM=$yyy$mm;
YYYMMDD=$yyy$mm$dd;



OPCODE="SH1001";
OP_CLASS="`echo "${OPCODE}" | cut -c1-2`";



#設定檔路徑


APP_HOME="${HOME}/app";
LOG_HOME="${APP_HOME}/log";
ETC_HOME="${APP_HOME}/etc/${OP_CLASS}";
FILE_OUT_HOME="${APP_HOME}/file/out/${OP_CLASS}";



mkdir -p $APP_HOME;
mkdir -p $LOG_HOME;
mkdir -p $ETC_HOME;
mkdir -p $FILE_OUT_HOME;



LOGFILE="${LOG_HOME}/${OPCODE}_${YYYMMDD}.log";
LOGFILE_TMP="${LOG_HOME}/${OPCODE}_TMP_${YYYMMDD}.log";
EMAIL='/sendmail2.sh';
MailWord="";
outputFile="${FILE_OUT_HOME}/blmdata/file/out/${OP_CLASS}/${OPCODE}.csv";

#================================================================
setlock;
CheckShellParameter $AllParameterNums;

printPicProcess $AllParameterNums;




endExit 0;
