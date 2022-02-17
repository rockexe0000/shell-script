#!/bin/bash
##########################################
#     SH1005.sh                          #
# ------------------------------------   #
# Author: rockexe0000                    #
# Date: 2022.02.17                       #
# Version: v1.00                         #
# Description: verify ID card            #
# Last modified on 2022.02.17            #
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




verify(){
  
  id=$1   # A123456789
  
  declare -A sumTable=([A]=1 [B]=0 [C]=9 [D]=8 [E]=7 [F]=6 [G]=5 [H]=4 [I]=9 [J]=3 [K]=2 [L]=2 [M]=1 [N]=0 [O]=8 [P]=9 [Q]=8 [R]=7 [S]=6 [T]=5 [U]=4 [V]=3 [W]=1 [X]=3 [Y]=2 [Z]=0)
  
  declare -A cityTable=([A]="台北市" [B]="台中市" [C]="基隆市" [D]="台南市" [E]="高雄市" [F]="台北縣" [G]="宜蘭縣" [H]="桃園縣" [I]="嘉義市" [J]="新竹縣" [K]="苗栗縣" [L]="台中縣" [M]="南投縣" [N]="彰化縣" [O]="新竹市" [P]="雲林縣" [Q]="嘉義縣" [R]="台南縣" [S]="高雄縣" [T]="屏東縣" [U]="花蓮縣" [V]="台東縣" [W]="金門縣" [X]="澎湖縣" [Y]="陽明山" [Z]="連江縣")
  
  no0="${id:0:1}"   # A
  no1="${id:1:1}"   # 1
  no2="${id:2:1}"   # 2
  no3="${id:3:1}"   # 3
  no4="${id:4:1}"   # 4
  no5="${id:5:1}"   # 5
  no6="${id:6:1}"   # 6
  no7="${id:7:1}"   # 7
  no8="${id:8:1}"   # 8
  no9="${id:9:1}"   # 9
  sum=$((${sumTable[$no0]} + $no1*8 + $no2*7 + $no3*6 + $no4*5 + $no5*4 + $no6*3 + $no7*2 + $no8 + $no9))   # Up to 342
  
  echo "$(((350 - $sum) % 10))"
  

}



## 檢查 shell 執行參數, 根據參數決定檔案路徑及位置 ##
CheckShellParameter(){
	
  ## 使用者說明
  printUsage(){
    echo " Purpose: verify ID card"
    echo " Usage: bash `basename $0` [身分證字號]"
    echo "  exp1: bash `basename $0` A123456789"
    echo "  exp2: bash `basename $0` K233265200"
#    echo "  exp3: bash `basename $0` 2-1-14 7"
#    echo "  exp4: bash `basename $0` 2-1-15 8"
#    echo "  exp5: bash `basename $0` 2-1-16 9"
#    echo "  exp6: bash `basename $0` cpu (列出CPU)"
#    echo "  exp7: bash `basename $0` memory (列出記憶體)"
#    echo "  exp8: bash `basename $0` storage (列出儲存空間)"
	
    endExit $1;
  }
	
  P1=$1;
#  P2=$(echo $2 | tr A-Z a-z);
#  P3=$3;
#  P4=$(echo $4 | tr A-Z a-z);
#  P5=$5;


  ## 數字格式 regex
  NUregex="^[0-9]+(.[0-9]{1,2})?$"
  
  ## 身分證字號 regex
  IDregex="^[A-Z]{1}[1-2]{1}[0-9]{8}$"
  

  ## 檢查參數數量 ##
  if [ $ParameterNums -ne 1 ]; then
  	echo "ParameterNums=[$ParameterNums] 參數數量錯誤" | tee -a ${LOGFILE};
  	printUsage 1101;
  fi
  
  ###檢查[身分證字號]參數是否錯誤 ##
  if [[ ! $P1 =~ $IDregex ]]; then
    echo "身分證字號=[$P1] 請輸入正確的身分證字號" | tee -a ${LOGFILE};
    printUsage 1102;
  elif [[ ! $(verify $P1) == 0 ]]; then
	echo "身分證字號=[$P1] 請輸入正確的身分證字號" | tee -a ${LOGFILE};
    printUsage 1102;
  fi
  
#  ###檢查[體重]參數是否錯誤 ##
#  if [[ ! $P2 =~ $NUregex ]]; then
#    echo "體重=[$P2] 請輸入正確的體重" | tee -a ${LOGFILE};
#    printUsage 1102;
#  elif [ `echo "$P2 < 1" | bc` -eq 1 ] || [ `echo "1000 < $P2" | bc` -eq 1 ]; then
#    echo "體重=[$P2] 請輸入正確的體重" | tee -a ${LOGFILE};
#    printUsage 1102;
#  fi
  
	
}


##處理SH1005
SH1005Process(){

  echo "##########################################################################################################################################" >> ${LOGFILE} 2>&1
  echo "===============================================================================================" >> ${LOGFILE} 2>&1
  processStartTime "${OPCODE}" "${LOGFILE}";
  
  
  ####################################
  
  P1=$1;
  
  
  
  
  declare -A cityTable=([A]="台北市" [B]="台中市" [C]="基隆市" [D]="台南市" [E]="高雄市" [F]="台北縣" [G]="宜蘭縣" [H]="桃園縣" [I]="嘉義市" [J]="新竹縣" [K]="苗栗縣" [L]="台中縣" [M]="南投縣" [N]="彰化縣" [O]="新竹市" [P]="雲林縣" [Q]="嘉義縣" [R]="台南縣" [S]="高雄縣" [T]="屏東縣" [U]="花蓮縣" [V]="台東縣" [W]="金門縣" [X]="澎湖縣" [Y]="陽明山" [Z]="連江縣")
  
  
  no0="${P1:0:1}"
  no1="${P1:1:1}"
  
  
  echo "戶籍地=[${cityTable[$no0]}]"
  
  if [[ $no1 == 1 ]]; then
	echo "性別=[男]";
  else
	echo "性別=[女]";
  fi
  
  
  
  echo "身分證格式驗證正確"

  
  

  
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



OPCODE="SH1005";
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

SH1005Process $AllParameterNums;




endExit 0;
