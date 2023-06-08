# /data/local/tmp/chk_input_syy.sh

echo "[$0] $1 started, process id: $$, time is `date`"

handleInput() {
  nowTime=`date +%Y-%m-%d_%H-%M-%S`
  echo "starting to input, now is `date +%Y-%m-%d\ %H:%M:%S\ 星期%w`"
  echo "waking up the phone..."
  input keyevent 82
  sleep 1
  echo "unlocking the phone..."
  input swipe 500 1500 500 500 200
  sleep 2
  echo "killing the app..."
  am force-stop com.alibaba.android.rimet
  sleep 2
  echo "restarting the app..."
  am start -n com.alibaba.android.rimet/.biz.LaunchHomeActivity
  sleep 15
  echo "screencap before tapping..."
  mkdir /sdcard/chk_input_syy
  screencap /sdcard/chk_input_syy/${nowTime}_begin.png
  echo "tapping step 1..."
  input tap 540 2300
  sleep 5
  echo "tapping step 2..."
  input tap 80 1000
  sleep 5
  echo "tapping step 3..."
  input tap 540 1400
  echo "screencap after tapping..."
  screencap /sdcard/chk_input_syy/${nowTime}_end.png
  echo "input all done!!!!!!!"
}

if [ "$1" -eq "1" ]; then
  handleInput
  exit 0
fi

while [ "a" != "b" ]
do
  nowWeek=`date +%w`
  nowHour=`date +%H`
  nowMinute=`date +%M`
  echo "now is 星期$nowWeek $nowHour:$nowMinute"

  if [ $nowWeek -le 5 ] && [ $nowWeek -gt 0 ]; then
    if [ $nowHour -eq 8 ] && [ $nowMinute -ge 20 ] && [ $nowMinute -lt 30 ]; then
      waitTime=$((RANDOM % 300))
      echo "work day morning time is right, wait $waitTime seconds then do input."
      sleep $waitTime
      handleInput
    elif [ $nowHour -eq 22 ] && [ $nowMinute -ge 10 ] && [ $nowMinute -lt 20 ]; then
      waitTime=$((RANDOM % 300))
      echo "work day night time is right, wait $waitTime seconds then do input."
      sleep $waitTime
      handleInput
    fi
  else
    if [ $nowHour -eq 11 ] && [ $nowMinute -ge 20 ] && [ $nowMinute -lt 30 ]; then
      waitTime=$((RANDOM % 300))
      echo "weekend morning time is right, wait $waitTime seconds then do input."
      sleep $waitTime
      handleInput
    elif [ $nowHour -eq 17 ] && [ $nowMinute -ge 10 ] && [ $nowMinute -lt 20 ]; then
      waitTime=$((RANDOM % 300))
      echo "weekend night time is right, wait $waitTime seconds then do input."
      sleep $waitTime
      handleInput
    fi
  fi

  echo "waiting for next check..."
  sleep 480s
done