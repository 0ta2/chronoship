# vim:et sts=2 sw=2 ft=zsh

typeset -g VIRTUAL_ENV_DISABLE_PROMPT=1

setopt nopromptbang prompt{cr,percent,sp,subst}

# Depends on git-info module to show git information.
typeset -gA git_info
if (( ${+functions[git-info]} )); then
  zstyle ':zim:git-info:branch' format '%b'
  zstyle ':zim:git-info:commit' format 'HEAD %F{green}(%c)'
  zstyle ':zim:git-info:action' format ' %F{yellow}(${(U):-%s})'
  zstyle ':zim:git-info:stashed' format '\\\$'
  zstyle ':zim:git-info:unindexed' format '!'
  zstyle ':zim:git-info:indexed' format '+'
  zstyle ':zim:git-info:ahead' format '>'
  zstyle ':zim:git-info:behind' format '<'
  zstyle ':zim:git-info:keys' format \
      'status' '%S%I%i%A%B' \
      'prompt' ' %%B%F{magenta}%b%c%s${(e)git_info[status]:+" %F{red}[${(e)git_info[status]}]"}%f%%b'
  add-zsh-hook precmd git-info
fi

# Display the time in real time.
TMOUT=1
TRAPALRM() {
  if [[ "${WIDGET}" != "expand-or-complete" && ( -z "${EXCLUDE_WIDGETS_REGEX}" || ! "${WIDGET}" =~ "(${EXCLUDE_WIDGETS_REGEX})" ) ]]; then
    zle reset-prompt
  fi
}

PS1='%F{cyan}%D{%Y-%m-%d %H:%M:%S}%f%b $(kube_ps1)${(e)git_info[prompt]} $ '
unset RPS1
