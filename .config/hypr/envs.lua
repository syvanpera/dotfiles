-- hl.env("SSH_AUTH_SOCK", os.getenv("HOME") .. "/.bitwarden-ssh-agent.sock")
hl.env("SSH_AUTH_SOCK", os.getenv("XDG_RUNTIME_DIR") .. "/ssh-agent.socket")
