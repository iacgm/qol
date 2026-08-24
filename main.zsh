# Increase history length
HISTSIZE=50000
SAVEHIST=50000

# ATT shortcuts
function uw { cd $(git rev-parse --show-toplevel)/deployable/uw ; }
function groot { cd $(git rev-parse --show-toplevel) ; }
alias att="cd ~/work_space/all-the-things && ucp"
alias atc="att && claude"
alias atcd="att && claude --dangerously-skip-permissions"
alias yolo="claude --dangerously-skip-permissions"
alias bk="att && python <(git show origin/bk_cli:build-tools/bin/buildkite.py)" 
alias mkdev="make -C deployable/ucp dev"
alias ucp="source /Users/ian.martinez/work_space/all-the-things/deployable/ucp/src/.venv39/bin/activate"
alias monolith="source /Users/ian.martinez/work_space/all-the-things/deployable/monolith/src/.venv39/bin/activate"
alias risk="source /Users/ian.martinez/work_space/all-the-things/deployable/risk-offline/src/.venv39/bin/activate"
alias rcli="risk-cli"
function path { rcli find-path-between-signals Signal.$1 Signal.$2 }
function scmp { rcli signal-relation Signal.$1 Signal.$2 }
function pcmp { rcli policy-relation Signal.$1 Signal.$2 }
alias sigtest="ucp; pytest signals/tests"
alias inttest="ucp; pytest underwriting/terms/service/tests"
function login { ucp; local role="${1:-prod}"; echo $role ; affirm.onelogin --aws-account $role }
# UW
function parity { PARITY_FAST_EXIT_ENV=1 ./gradlew batch --args="LocalFatlogParityTask -d $1 -o $2 -dt ${3:-AA}" }
function iparity { PARITY_FAST_EXIT_ENV=1 ./gradlew batch --args="LocalFatlogParityTask -i $1 -o $2 -dt ${3:-AA}" }
alias gr="./gradlew"
alias grfix="gr --stop ; gr --no-configuration-cache :jvm-uw:decisioning:detekt"
alias compile="gr :jvm-uw:orchestration:compileKotlin :jvm-uw:decisioning:compileKotlin -q"
alias detekt="gr :jvm-uw:orchestration:detekt :jvm-uw:decisioning:detekt"
alias testuw="gr :jvm-uw:orchestration:test :jvm-uw:decisioning:test"

# git shortcuts
alias diff="git diff --stat"
alias jump="git jump merge"
alias cont="git add . ; git rebase --continue"
alias abort="git rebase --abort"
alias slog="git log origin.. --oneline 2> /dev/null || git log --oneline"
alias mlog="git log $(git merge-base origin HEAD)~1 .. --oneline 2> /dev/null || git log --oneline"
alias branch="git branch --show-current"
alias rebase="git fetch origin master && git rebase origin/master"
alias pull="git pull"
alias push="git push"
alias pushf="git push -f"
alias cnew="git checkout -b"
alias cout="git checkout"
alias unstage="git restore --staged $(git rev-parse --show-toplevel)"
# Diffview
function pr { att; nvim -c "DiffviewOpen $(git merge-base origin origin/$1) origin/$1"; }
# Worktree-level cout
function go { local _cout=$(cout $1 2>&1); if ( (($? != 0)) && (echo $_cout | rg -q fatal)); then cd $(echo $_cout | sed -nE "s/.*'([^']*)'/\1/p"); else echo $_cout; fi; }
function clone { git clone "https://github.com/$1"; }
function publish { git commit -am $1 && (pull ; push) ; }
function publishf { git commit -am $1 --no-verify && pushf ; }

# Misc.
alias qol="nvim ~/qol/main.zsh"
alias shrc="nvim ~/.zshrc"
alias config=". ~/.zshrc"
alias q="exit"
alias n="nvim"
alias xargs="xargs -S 1048" # Raise command length limit on xargs
alias njq="nvim -c 'luafile ~/qol/jq.lua'"
alias nsh="nvim -c 'luafile ~/qol/sh.lua'"
