# Some junk functions I wrote... sometimes useful, sometimes not

android-screen(){
if [ -z $1 ]
then
	echo $0 "name_future_png -> creates 'name_future_png'.png as screenshot" 
else
	echo "Saving as " $1".png ..."
	adb shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > $1.png
fi
}

webserver(){
	if [ -z $1 ]
	then
		echo "Usage: webserver ACTION -> systemctl VARIOUS_WEB_SERVICES ACTION"
	else
		systemctl "$1" httpd
		systemctl "$1" mysqld
	fi
}

# Fix Telegram Desktop launcher
alias telegram-fix='sed "s/Exec=-- %u/Exec=telegram -- %u/" -i .local/share/applications/telegramdesktop.desktop'

# To see disk usage
function diskusage {
	if [ -z $1 ]
	then
		dir=$PWD
	else
		dir=$1
	fi

	du -ad1 $1 | sort -nr | cut -f 2 | tail -n +2 | xargs du -hd0
}
