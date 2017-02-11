#!/usr/bin/env bash

__powerline() {
    # colorscheme
    FG_BLACK="\[$(tput setaf 0)\]"
    FG_RED="\[$(tput setaf 1)\]"
    FG_GREEN="\[$(tput setaf 2)\]"
    FG_YELLOW="\[$(tput setaf 3)\]"
    FG_BLUE="\[$(tput setaf 4)\]"
    FG_MAGENTA="\[$(tput setaf 5)\]"
    FG_CYAN="\[$(tput setaf 6)\]"
    FG_WHITE="\[$(tput setaf 7)\]"
    
    BG_BLACK="\[$(tput setab 0)\]"
    BG_RED="\[$(tput setab 1)\]"
    BG_GREEN="\[$(tput setab 2)\]"
    BG_YELLOW="\[$(tput setab 3)\]"
    BG_BLUE="\[$(tput setab 4)\]"
    BG_MAGENTA="\[$(tput setab 5)\]"
    BG_CYAN="\[$(tput setab 6)\]"
    BG_WHITE="\[$(tput setab 7)\]"

    DIM="\[$(tput dim)\]"
    REVERSE="\[$(tput rev)\]"
    RESET="\[$(tput sgr0)\]"
    BOLD="\[$(tput bold)\]"

    # Unicode symbols
    GIT_PROMPT_SYMBOL_BRANCH='➦'
    GIT_PROMPT_SYMBOL_ADD="${FG_WHITE}Ⓐ ${RESET}"
    GIT_PROMPT_SYMBOL_DELETE="${FG_RED}Ⓓ ${RESET}"
    GIT_PROMPT_SYMBOL_MODIFY="${FG_MAGENTA}Ⓜ ${RESET}"
    GIT_PROMPT_SYMBOL_RENAME="${FG_CYAN}Ⓡ ${RESET}"
    GIT_PROMPT_SYMBOL_COMMIT="${FG_YELLOW}Ⓒ ${RESET}"
    GIT_PROMPT_SYMBOL_PUSH="⬆"
    GIT_PROMPT_SYMBOL_PULL="⬇"

    SYSTEM_PROMPT_SYMBOL_TRUE='✔'
    SYSTEM_PROMPT_SYMBOL_FALSE='✘'
    SYSTEM_PROMPT_SYMBOL_JOBS='⚙'
    SYSTEM_PROMPT_SYMBOL_ROOT='⚡'
    SYSTEM_PROMPT_SYMBOL_AT='@'
    SYSTEM_PROMPT_SYMBOL_USER='➜'

    __git_info() { 
        [ -x "$(which git)" ] || return    # git not found

        # get current branch name or short SHA1 hash for detached head
        local BRANCH="$(git symbolic-ref --short HEAD 2> /dev/null || git describe --tags --always 2>/dev/null)"
        [ -n "$BRANCH" ] || return  # git branch not found

        local INDEX=$(command git status --porcelain -b 2> /dev/null)
        local STATUS=""
        local GIT_PROMPT_SYMBOL

        local stat="$(echo $INDEX | grep '^##' | grep -o '\[.\+\]$')"
        local aheadN="$(echo $stat | grep -o 'ahead \d\+' | grep -o '\d\+')"
        local behindN="$(echo $stat | grep -o 'behind \d\+' | grep -o '\d\+')"

        if [ -n "$behindN" ]; then
             STATUS="${FG_YELLOW}$GIT_PROMPT_SYMBOL_PULL $behindN${RESET}$STATUS"
        fi
        if [ -n "$aheadN" ]; then
             STATUS="${FG_YELLOW}$GIT_PROMPT_SYMBOL_PUSH $aheadN${RESET}$STATUS"
        fi

        if $(echo "$INDEX" | grep '^A  ' &> /dev/null); then
            STATUS="$GIT_PROMPT_SYMBOL_COMMIT$STATUS"
        elif $(echo "$INDEX" | grep '^M  ' &> /dev/null); then
            STATUS="$GIT_PROMPT_SYMBOL_COMMIT$STATUS"
        fi
        if $(echo "$INDEX" | grep '^R  ' &> /dev/null); then
            STATUS="$GIT_PROMPT_SYMBOL_RENAME$STATUS"
        fi
        if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
            STATUS="$GIT_PROMPT_SYMBOL_MODIFY$STATUS"
        elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
            STATUS="$GIT_PROMPT_SYMBOL_MODIFY$STATUS"
        elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
            STATUS="$GIT_PROMPT_SYMBOL_MODIFY$STATUS"
        fi
        if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
            STATUS="$GIT_PROMPT_SYMBOL_DELETE$STATUS"
        elif $(echo "$INDEX" | grep '^D  ' &> /dev/null); then
            STATUS="$GIT_PROMPT_SYMBOL_DELETE$STATUS"
        elif $(echo "$INDEX" | grep '^AD ' &> /dev/null); then
            STATUS="$GIT_PROMPT_SYMBOL_DELETE$STATUS"
        fi
        if $(echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null); then
            STATUS="$GIT_PROMPT_SYMBOL_ADD$STATUS"
        fi

        if [ -n "${STATUS}" ]; then
            GIT_PROMPT_SYMBOL="${FG_YELLOW}git ${GIT_PROMPT_SYMBOL_BRANCH} (${BRANCH} ${RESET}${STATUS}${FG_YELLOW})${RESET} "
        else
            GIT_PROMPT_SYMBOL="${FG_GREEN}git ${GIT_PROMPT_SYMBOL_BRANCH} (${BRANCH}) ${RESET}"
        fi
        printf "${GIT_PROMPT_SYMBOL}"
    }

    ps1() {
        local RETVAL=$?
        local PROMPT_SYMBOL_DATE="${FG_MAGENTA}"`date "+%Y-%m-%d %H:%M:%S %A"`"$RESET"
        local PROMPT_SYMBOL_DIR="${FG_BLUE}\w$RESET"
        local PROMPT_USER_HOST_COLOR="${FG_GREEN}"
        local PROMPT_USER_HOST="\u${SYSTEM_PROMPT_SYMBOL_AT}\h"
        if [ $UID -eq 0 ]; then
            PROMPT_USER_HOST_COLOR="${FG_CYAN}"
            PROMPT_USER_HOST="${SYSTEM_PROMPT_SYMBOL_ROOT} ─${PROMPT_USER_HOST}"
        fi
        local PROMPT_SYMBOL
        [[ $(jobs -l | wc -l) -gt 0 ]] && PROMPT_SYMBOL+="${PROMPT_USER_HOST_COLOR}${SYSTEM_PROMPT_SYMBOL_JOBS}─${RESET}"
        [[ $RETVAL -ne 0 ]] && PROMPT_SYMBOL+="${FG_RED}${SYSTEM_PROMPT_SYMBOL_FALSE}${RESET}${PROMPT_USER_HOST_COLOR}─${RESET}"

        PS1_U="${PROMPT_USER_HOST_COLOR}╭─${PROMPT_USER_HOST_H}${PROMPT_USER_HOST} ${PROMPT_SYMBOL_DIR} $(__git_info)${PROMPT_SYMBOL_DATE}"
        PS1_D="${PROMPT_USER_HOST_COLOR}╰─${PROMPT_SYMBOL}${PROMPT_USER_HOST_COLOR}\$ ${RESET}"
        PS1="${PS1_U}\n${PS1_D}"
    }

    PROMPT_COMMAND=ps1
}

__powerline
unset __powerline
