eval "$(coverish-eval bash)"

# Prevent actual execution of script
export LIB=1

# Provide access to project root
export SRCDIR=${TESTDIR/\/test*/}

# Place mocks on $PATH (e.g. curl)
export PATH="$SRCDIR/test/bin:$PATH"

# Set script defaults for test environment
export PACMAN_CONF=$(mktemp)
export DOWNGRADE_FROM_ALA=0
export DOWNGRADE_FROM_CACHE=0

# Stub functions that won't work (on CI) or need different behavior.
pacsort() { cat; }
sudo() { "$@"; }

# Utilities
write_pacman_conf() {
  printf "%s\n" "$@" > "$PACMAN_CONF"
}

ignore() { yes | prompt_to_ignore "$@" >/dev/null; }

# Load implementation
source "$SRCDIR"/downgrade
