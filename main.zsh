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

# git shortcuts
alias diff="git diff --stat"
alias jump="git jump merge"
alias slog="git log origin.. --oneline 2> /dev/null || git log --oneline"
alias mlog="git log $(git merge-base origin HEAD)~1 .. --oneline 2> /dev/null || git log --oneline"
alias branch="git branch --show-current"
alias rebase="git rebase origin/master"
alias pull="git pull"
alias push="git push"
alias pushf="git push -f"
alias cnew="git checkout -b"
alias cout="git checkout"
# Diffview
function pr { att; nvim -c "DiffviewOpen $(git merge-base origin origin/$1) origin/$1"; }
# Worktree-level cout
function go { local _cout=$(cout $1 2>&1); if ( (($? != 0)) && (echo $_cout | rg -q fatal)); then cd $(echo $_cout | sed -nE "s/.*'([^']*)'/\1/p"); else echo $_cout; fi; }
function clone { git clone "https://github.com/$1"; }
function publish { git commit -am $1 && (pull ; push) ; }
function publishf { git commit -am $1 --no-verify && pushf ; }

