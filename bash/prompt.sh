# https://wiki.archlinux.org/index.php/Bash/Prompt_customization

bold="$(tput bold)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
cyan="$(tput setaf 6)"
white="$(tput setaf 15)"
reset="$(tput sgr0)"

smiley_color()
{
    if [ $OK = 0 ]; then
        echo -n "${bold}${green}"
    else
        echo -n "${bold}${red}"
    fi
}

smiley_face()
{
    if [ $OK = 0 ]; then
        echo -n ":)"
    else
        echo -n ":("
    fi
}

git_branch()
{
    local branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [[ -n "$branch" ]]; then
        echo -n "($branch) "
    fi
}

is_screen()
{
    if [ -n "$STY" ]; then
        echo -n "(screen) "
    fi
}

# This is the default prompt command. This prints a text in the terminal window
# title.
TERM_SYNC='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
PROMPT_COMMAND="$TERM_SYNC; $PROMPT_COMMAND"

PS1="\[${bold}${green}\]\u@\h \[${cyan}\]\$(is_screen)\[${bold}${white}\]\$(git_branch)\[${bold}${yellow}\]\w\n\[\$(smiley_color)\]\$(smiley_face) \[${bold}${blue}\]\$\[${reset}\] "
