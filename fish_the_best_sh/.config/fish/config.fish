# Felina A. Rivera's FISH config
set START_TIME (date +%s.%N)

# Dependencies for fzf plugin are: fzf, fd, optional bat

function debug
  status is-interactive && [ "$PWD" = "$HOME" ] && echo "$FISH_LOGO $(date +%s.%N) $argv"
end

function addpaths --argument-names 'path' --description "Add binary to $PATH"
  test -d "$path" && not contains -- "$path" $fish_user_paths && set -U fish_user_paths $fish_user_paths "$path" && debug Added path "$path"
end

function source_if_exists --argument-names 'file'
  test -e "$file" && source "$file" && debug "Source $file"
end

function set_global
  set -gx $argv && debug "Set variable $argv[1]"
end

source_if_exists $HOME/.config/fish/local_env.fish
set_global FISH_LOGO 🐠

# Load aliases before abbreviations: tryalias is almost as fast as fish's builtin alias so I'll keep it.
source_if_exists $HOME/.aliases

abbr ,, commacomma  # commacomma is defined as a fish function so should not be shared with other shells

abbr site "cd ~/src/felina.art || git clone git@github.com:felina0/felina.art ~/src/felina.art"
abbr mcr 'make commitready'
abbr gdbb "gdb -ex run --args"
abbr o "ollama.sh run $DEFAULT_OLLAMA_MODEL --"
abbr l 'ls -F -a'
abbr ll 'ls -F -a -l -h'
abbr e evince   # alternatives: 'zathura --fork' mupdf mupdf-x11 qpdfview 'wine READER10.exe'
abbr MONKEY 'echo MONKEY'
abbr em 'emacs -nw'
abbr emc 'emacsclient -nw --alternate-editor=""'
abbr z 'zeditor $(projectroot.sh)'
abbr rsync 'rsync -rh --info=progress2'

# Python and Scientific commands
abbr py python3
abbr ipy ipython3
abbr jwt_decode "python3 -c \"import datetime,jwt,json ; print(json.dumps({k: datetime.datetime.fromtimestamp(v).isoformat() if k in 'iat exp' else v for k,v in jwt.api_jwt.decode(input('token> ').replace('Bearer ', '').strip(), options={'verify_signature': False}).items()}, indent=2))\""
abbr msgpack_unpack "python3 -c 'import sys,msgpack;print(msgpack.unpack(open(0,\'rb\')))'"

# Common directories
abbr mc "cd ~/src/minecraft-server"  # Minecraft by Mojang
abbr art "cd ~/src/art/"
abbr games "cd ~/src/games/"
abbr golf "cd ~/src/golf/"
abbr leet "cd ~/src/golf/0notgolf/speed/Fire_of_the_Phoenix/1/3/3/7/faang_likes_puzzles/leetcode"
abbr grugai "dragon-drop $HOME/sync/ai/GRUG.md"

# Git shortcuts
# When I retire, I'll switch to mercurial or somesuch
abbr ga 'git add'
abbr gr 'git rebase'
abbr gc 'git commit'
abbr gcw 'git commit-with-claude'
abbr gch 'git checkout'
abbr gchr 'git cherry-pick'
abbr gs '_fzf_search_git_status || git status'
abbr gst 'git stash push --'
abbr gstp 'git stash apply && git stash drop'
abbr gd 'git diff'
abbr gl '_fzf_search_git_log || git log'
abbr gcl 'git clone'
abbr ghch 'gh pr checkout'
abbr ghw 'gh pr checks --watch && notification-sound.sh'
abbr ghl 'gh pr list'

abbr kx kubectx  # Switch kube clusters
abbr k kubectl
abbr kg 'kubectl get'
abbr kgp 'kubectl get pods'
abbr kd 'kubectl describe'
abbr kl stern  # Kubectl logs
abbr kex 'kubectl exec'
abbr kpf 'kubectl port-forward'
abbr krr 'correct-kubernetes-cluster.sh && kubectl rollout restart'

abbr app 'cd ~/pf && cd ~/pf/driver_experience'
abbr ax 'cd ~/pf && cd ~/pf/powerflex_cloud_customer_portal && nvm use lts'
abbr cs 'cd ~/pf && cd ~/pf/powerflex_edge_ocpp_central_system && source venv/bin/activate.fish'
abbr devman 'cd ~/pf && cd ~/pf/powerflex_cloud_edge_device_manager'
abbr ev 'cd ~/pf && cd ~/pf/pfc_ev'
abbr ff 'cd ~/pf && cd ~/pf/powerflex_edge_traffic_manager && source venv/bin/activate.fish'
abbr ful 'cd ~/pf && ~/pf/pfc_fulfillment_api'
abbr natsinfra 'cd ~/pf && cd ~/pf/pfc_nats_infrastructure/'
abbr pfapi 'cd ~/pf && ~/pf/powerflex_api && source venv/bin/activate.fish'
abbr scale 'cd ~/pf && cd ~/pf/scale'
abbr scalepass 'cd ~/pf && cd ~/pf/scale/powerflex_cloud_nexus_password_management'
abbr sites 'cd ~/pf && cd ~/pf/scale/powerflex_cloud_nexus_sites'
abbr uplo2 'cd ~/pf && ~/pf/pfc_site_uploader2'
abbr uplob 'cd ~/pf && ~/pf/pfc_site_uploader/site-uploader/'
abbr uplo 'cd ~/pf && ~/pf/pfc_site_uploader'
abbr uplof 'cd ~/pf && ~/pf/pfc_site_uploader/*front*/'

# Docker shortcuts
abbr dcls 'docker container ls'
abbr dl 'docker logs'
abbr dex 'docker exec'
abbr dcrm 'docker container rm'
abbr dck "docker container stop --timeout 3 (docker container ls --format json | jq '.ID' | sed 's/\"//g')"
abbr dckk "docker container kill (docker container ls --format json | jq '.ID' | sed 's/\"//g')"
debug "Setup abbreviations"


addpaths $HOME/bin
addpaths $HOME/.local/bin
addpaths $HOME/.luarocks/bin
addpaths $HOME/.cargo/bin

set_global ANDROID_HOME "/opt/android-sdk"
set_global SILENT true
addpaths "$ANDROID_HOME/tools/bin/"
addpaths "$ANDROID_HOME/platform-tools/"
addpaths "$ANDROID_HOME/cmdline-tools/latest/bin"
addpaths "$ANDROID_HOME/emulator"
addpaths "$ANDROID_HOME/bin"

source_if_exists /opt/asdf-vm/asdf.fish
addpaths /opt/asdf-vm/bin  # from AUR

set_global EDITOR vis

# Caused bitsandbytes package from  oobabooga/text-generation-webui to crash as it scanned through all env vars in search of CUDA stuff
set --unexport XDG_GREETER_DATA_DIR
set_global CUDA_LIB /opt/cuda/targets/x86_64-linux/lib/
set_global PYTHONSTARTUP "$HOME/.ipython/profile_default/startup/10-imports.py"
set_global DEFAULT_OLLAMA_MODEL qwen3:14b    # keep this updated
set_global OLLAMA_KEEP_ALIVE 8h
set_global OLLAMA_MAX_LOADED_MODELS 3
set_global OLLAMA_NUM_PARALLEL 3
set_global OLAMA_ORIGINS localhost
set_global OLLAMA_NOPRUNE true  # allow continuing downloads

# kubectl krew plugin manager
set -q KREW_ROOT; and set -gx PATH $PATH $KREW_ROOT/.krew/bin; or set -gx PATH $PATH $HOME/.krew/bin

abbr ma makeanywhere
function makeanywhere --wraps make --description "makeanywhere --wraps make makeanywhere"
  makeanywhere $argv
end
function pma --wraps make --description "pma --wraps make pipenv run makeanywhere"
  python -m pipenv run makeanywhere $argv
end

set_global CUSTOM_CURL_WRAPPER (command -v curl_device_manager.sh)
function curl_device_manager.sh --wraps curl --description "makeanywhere --wraps make $CUSTOM_CURL_WRAPPER"
  "$CUSTOM_CURL_WRAPPER" $argv
end

function n --description "call nushell inline"
  # TODO handle strings
  # e.g. n open site-uploader/tests/sample_input_files/v003_integration_testing/djw8_3.xlsx \| get \'Site Information\'
  nu -c "$argv"
end

# Have fzf use ag to find files
set_global FZF_DEFAULT_COMMAND 'ag -l --path-to-ignore .gitignore --nocolor --hidden -g ""'
set_global FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set_global fzf_preview_file_cmd cat
set fzf_fd_opts --hidden --exclude=.git  # list hidden files when searching with ctrl-p
debug Set fzf options

if status is-interactive
  [ -n "$DISPLAY" ] && xset r rate 77 39
  debug Set keyboard rate
  [ -n "$DISPLAY" ] && max-mic.sh 2>&1 >/dev/null &
  debug Set audio

  function fish_user_key_bindings
    # ctrl-p to find files with fzf, ctrl-f to autocomplete a command with fish
    bind \cp _fzf_search_directory
    bind \cf forward-char
  end

  command -v starship > /dev/null && starship init fish | source

  # WHYYYYYYYYYYY
  # command -v pyenv > /dev/null && pyenv init - fish | source

  # Gold
  if ! grep PatrickF1/fzf.fish ~/.config/fish/fish_plugins >/dev/null && command -v fzf 2>&1 >/dev/null
    echo 'Installing fzf.fish https://github.com/PatrickF1/fzf.fish'
    fisher install PatrickF1/fzf.fish
  end

  set TOTAL_STARTUP_TIME (echo (date +%s.%N) "$START_TIME" | awk '{print ($1 - $2) * 1000}' || echo UNKNOWN)
  debug "Startup time: $TOTAL_STARTUP_TIME ms"

  command -v rbenv 2>&1 >/dev/null && rbenv init - --no-rehash fish | source

  # Load SSH keys last so user can ctrl-c, timeout after 14 hours
  # command -v keychain > /dev/null 2>&1 && eval (keychain --quick --timeout 840 --eval -Q --quiet (ls ~/.ssh/*.pub | sed s/.pub//g))
  command -v keychain > /dev/null 2>&1 && eval (keychain --quick --timeout 840 --eval -Q --quiet id_ed25519_felina0)
end

function install_plugin_manager
  curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
end

function install_plugins
  # Use this function on first run to install plugins
  fisher install franciscolourenco/done
  fisher install PatrickF1/fzf.fish
  fisher install evanlucas/fish-kubectl-completions
  gh completion --shell fish > ~/.config/fish/completions/gh.fish || echo "No gh"
  omnictl completion fish > ~/.config/fish/completions/omnictl.fish || echo "No omnictl"
end

function miniconda_fish_init
  eval "/opt/miniconda3/bin/conda" "shell.fish" "hook" | source
  conda activate $argv[1]
  echo Loaded miniconda and the $argv[1] environment
end
