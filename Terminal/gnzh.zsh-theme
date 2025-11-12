# Based on bira theme
setopt prompt_subst
() {
local PR_USER PR_USER_OP PR_PROMPT PR_HOST
# Check the UID
if [[ $UID -ne 0 ]]; then # normal user
  PR_USER='%F{green}%n%f'
  PR_USER_OP='%F{green}%#%f'
  PR_PROMPT='%f➤ %f'
else # root
  PR_USER='%F{red}%n%f'
  PR_USER_OP='%F{red}%#%f'
  PR_PROMPT='%F{red}➤ %f'
fi
# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
  PR_HOST='%F{red}%M%f' # SSH
else
  PR_HOST='%F{green}%m%f' # no SSH
fi
local return_code="%(?..%F{red}%? ↵%f)"
local user_host="${PR_USER}%F{cyan}@${PR_HOST}"
local current_dir="%B%F{blue}%~%f%b"
local git_branch='$(git_prompt_info)'
local timestamp="%F{cyan}%D{%L:%M:%S}%f"

# Define virtualenv format - we'll be using a custom approach
# These are kept for compatibility with plugins but not used directly
ZSH_THEME_VIRTUALENV_PREFIX="%F{white}("
ZSH_THEME_VIRTUALENV_SUFFIX=")%f"

# Custom venv display that puts it directly after ╭─
# We check if VIRTUAL_ENV is set and then format it
local venv_display='$([ -n "$VIRTUAL_ENV" ] && echo " %F{magenta}(${VIRTUAL_ENV:t})%f")'

PROMPT="╭─${venv_display} [$timestamp] [${user_host}] [${current_dir}] \$(ruby_prompt_info) ${git_branch}
╰─$PR_PROMPT "
RPROMPT="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %f"
ZSH_THEME_RUBY_PROMPT_PREFIX="%F{red}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="›%f"
}
