#!/bin/bash



# 計算BMI
function bmi
{
  
  height=$1
  weight=$2
  
  echo "身高 $height cm"
  echo "體重 $weight kg"
  #because i need chage height's cm to m, and 1m = 100cm
  m=100
  height=`echo "scale=2; $height / $m"|bc`
  
  BMI=`echo "scale=2; $weight / ($height*$height)" |bc`
  #echo "---------Result---------"
  echo "BMI $BMI"
  
  #設定值(set value時)不能有 $ 在前面
  #取值(get value)要有 $
  #四則運算要使用 expr, +-*/ 左右都要有空白
  #不過因為要取到小數點第二位，因此在這裡就不用 expr
  #所以不用在乎 expr 使用加減乘除運算的規定(ex: +-*/ 左右要空白)
  
  if [[ `echo "$BMI < 18.5" | bc` -eq 1 ]]; then
    echo "below 18.5   | 過輕"
  elif [[ `echo "18.5 <= $BMI" | bc` -eq 1 ]] && [[ `echo "$BMI < 24.0" | bc` -eq 1 ]]; then
    echo "18.5-24.0    | 標準"
  elif [[ `echo "24.0 <= $BMI" | bc` -eq 1 ]] && [[ `echo "$BMI < 27.0" | bc` -eq 1 ]]; then
    echo "24.0-27.0    | 過重"
  elif [[ `echo "27.0 <= $BMI" | bc` -eq 1 ]] && [[ `echo "$BMI < 30.0" | bc` -eq 1 ]]; then
    echo "27.0-30.0   | 輕度肥胖"
  elif [[ `echo "30.0 <= $BMI" | bc` -eq 1 ]] && [[ `echo "$BMI < 35.0" | bc` -eq 1 ]]; then
    echo "30.0-35.0   | 中度肥胖"
  else
    echo "35.0 above   | 重度肥胖"
  fi
  
}




bmi $1 $2







exit  0
