#!/bin/bash
##########################################
#     systemInfo.sh                      #
# ------------------------------------   #
# Author: rockexe0000                    #
# Date: 2022.01.25                       #
# Version: v1.00                         #
# Description: Show system informations  #
# Last modified on 2022.02.07            #
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
    echo " Purpose: Show system informations"
    echo " Usage: bash `basename $0` [查詢項目]"
    echo "  exp1: bash `basename $0` all (列出所有資訊)"
    echo "  exp2: bash `basename $0` time (列出時間)"
    echo "  exp3: bash `basename $0` hostname (列出主機名稱)"
    echo "  exp4: bash `basename $0` kernel (列出OS核心)"
    echo "  exp5: bash `basename $0` ip (列出IP)"
    echo "  exp6: bash `basename $0` cpu (列出CPU)"
    echo "  exp7: bash `basename $0` memory (列出記憶體)"
    echo "  exp8: bash `basename $0` storage (列出儲存空間)"
	
    endExit $1;
  }
	
  P1=$(echo $1 | tr A-Z a-z);
#  P2=$2;
#  P3=$3;
#  P4=$(echo $4 | tr A-Z a-z);
#  P5=$5;

  ## 檢查參數數量 ##
  if [ $ParameterNums -ne 1 ]; then
  	echo "ParameterNums=[$ParameterNums] 參數數量錯誤" | tee -a ${LOGFILE};
  	printUsage 1101;
  fi
  
  ###檢查[處理動作]參數是否錯誤 ##
  if [[ $P1 != "all" ]] && [[ $P1 != "time" ]] && [[ $P1 != "hostname" ]] && [[ $P1 != "kernel" ]] && [[ $P1 != "ip" ]] && [[ $P1 != "cpu" ]] && [[ $P1 != "memory" ]] && [[ $P1 != "storage" ]]; then ##檢查數值合理性
     echo "查詢項目=[$P1] 請輸入正確的查詢項目" | tee -a ${LOGFILE};
     printUsage 1102;
  fi
	
}




showTime(){
  echo "[Time]"
  echo "`date`"
}
showHostname(){
  echo "[Hostname]"
  echo $HOSTNAME
}
showKernel(){
  echo "[Kernel]"
  echo "`uname -a`"
}
showIP(){
  echo "[IP]"
  echo "`ifconfig | grep 'inet ' | cut -f 1`"
}
showCPU(){
  echo "[CPU]"
  echo "`cat /proc/cpuinfo | grep "model name" | tr -s " " | cut -d ":" -f 2`"
}
showMemory(){
  echo "[Memory]"
  echo "`free -h`"
}
showStorage(){
  echo "[Storage]"
  echo "`df -h`"
}



##處理systemInfo
systemInfoProcess(){

  echo "##########################################################################################################################################" >> ${LOGFILE} 2>&1
  echo "===============================================================================================" >> ${LOGFILE} 2>&1
  processStartTime "${OPCODE}" "${LOGFILE}";
  
  
  ####################################
  
  
  
  P1=$(echo $1 | tr A-Z a-z);
  
  if [ $P1 == "all" ]; then
    showTime;
	showHostname;
	showKernel;
	showIP;
	showCPU;
	showMemory;
	showStorage;
  elif [ $P1 == "time" ]; then
  	showTime;
  elif [ $P1 == "hostname" ]; then
    showHostname;
  elif [ $P1 == "kernel" ]; then
    showKernel;
  elif [ $P1 == "ip" ]; then
    showIP;
  elif [ $P1 == "cpu" ]; then
    showCPU;
  elif [ $P1 == "memory" ]; then
    showMemory;
  elif [ $P1 == "storage" ]; then
    showStorage;
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



OPCODE="TO1001";



#設定檔路徑


APP_HOME="${HOME}/app";
LOG_HOME="${APP_HOME}/log";
ETC_HOME="${APP_HOME}/etc/TO";
FILE_OUT_HOME="${APP_HOME}/file/out";



mkdir -p $APP_HOME;
mkdir -p $LOG_HOME;
mkdir -p $ETC_HOME;
mkdir -p $FILE_OUT_HOME;



LOGFILE="${LOG_HOME}/${OPCODE}_${YYYMMDD}.log";
LOGFILE_TMP="${LOG_HOME}/${OPCODE}_TMP_${YYYMMDD}.log";
EMAIL='/sendmail2.sh';
MailWord="";
outputFile="${FILE_OUT_HOME}/blmdata/file/out/TO/${OPCODE}.csv";

#================================================================
setlock;
CheckShellParameter $AllParameterNums;

systemInfoProcess $AllParameterNums;




endExit 0;
