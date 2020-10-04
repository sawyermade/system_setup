### ALIAS ###
alias lsl='ls -lh'
alias aar='sudo apt autoremove -y'
alias adga='adg -y && aar'
#alias rstart='screen -dmS rtorrent rtorrent'
#alias rt='stty stop undef; stty start undef; screen -x rtorrent'
alias rstart='tmux new -d -s rtorrent rtorrent'
alias rt='tmux a #rtorrent'
alias tsd='tmux new-session -d -s'
alias aii='$HOME/.aii.sh'
alias vu='globalprotect connect'
alias vd='globalprotect disconnect'
alias vs='globalprotect show --status'
alias reload='exec zsh'
alias py='python3'
alias gpr='git pull --recurse-submodules'
alias rsync-app='rsync -rzvP --append --inplace'
alias xming="export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0"
### ALIAS ###

### SSH ALIAS ###
alias home1='ssh home1'
alias home1-m='mountsshfs home1 /home/smc'
alias home1-um='umountsshfs home1'
alias home2='ssh home2'
alias home1l='ssh home1l'
alias home2l='ssh home2l'
alias seedbox='ssh seedbox'
alias deepv='ssh deepv'
alias deepv-m='mountsshfs deepv /home/danielsawyer'
alias deepv-um='umountsshfs deepv'
alias aivi='ssh aivi'
alias gaivi='ssh gaivi'
alias gaivi2='ssh gaivi2'
alias carrt='ssh carrt'
alias puppy='ssh puppy'
alias beast='ssh beast'
alias beast-m='mountsshfs beast /home/smc'
alias beast-um='umountsshfs beast'
alias hulk='ssh hulk'
alias hulk-m='mountsshfs hulk /home/smc'
alias hulk-um='umountsshfs hulk'
### SSH ALIAS ###
