export GPG_TTY=$(tty)

if [ $(gpg -K | grep -c 0xD59E628B324782E1) ] ; then
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    gpgconf --launch gpg-agent

    alias yubico-reload="gpg-connect-agent reloadagent /bye"
fi
