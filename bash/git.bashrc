# Allows to have the branch name in shell prompt and lots more
# It marks with a '+' if you've added some files and you're ready to commit
# It marks with a '*' if you've changed some files
# And lots more! :D
# Just make sure the path below is correct in your distribution
# For me (ArchLinux) it is

source /usr/share/git/completion/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
PS1='\u@\h:\W $(__git_ps1 "(%s) ")\$ '
