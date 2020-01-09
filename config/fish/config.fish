set SSH_AUTH_SOCK
neofetch

function v
    vim $argv
end

function sv
    sudo vim $argv
end

function p
    sudo pacman $argv
end

function fuck
    eval command sudo $history[1]
end

