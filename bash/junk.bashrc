# Some junk functions I wrote... sometimes useful, sometimes not

android-screen(){
if [ -z $1 ]
then
	echo $0 "name_future_png -> creates 'name_future_png'.png as screenshot" 
else
	echo "Saving as " $1".png ..."
	# Thanks to Koushik Dutta (Koush): https://plus.google.com/110558071969009568835/posts/Ar3FdhknHo3
	adb exec-out screencap -p > $1.png
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
