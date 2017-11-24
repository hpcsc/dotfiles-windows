$env:TERM="xterm"

function gws($p) {
    &callGit "status" "-u" $p
}

function gia($p) {
    &callGit "add" "-A" $p
    &gs
}

function gco($p) {
    &callGit "checkout" $p
}

function glg() {
    git log --oneline --graph --decorate
}

function gloc() {
    git log --topo-order --graph --decorate --pretty=format:"%C(green)%h%C(reset) %s%C(red)%d%C(reset)"
}

function gfr() {
    git pull -r --prune
}

function dls() {
    docker ps -a
}

function dlsi() {
    docker images
}

function dsa($p) {
    docker start $p
}

function dso($p) {
    docker stop $p
}

function drm($p) {
    docker rm $p
}

function drmi($p) {
    docker rmi $p
}

function di($p) {
    docker inspect $p
}

function callGit($base, $default, $param) {
    &call "git" $base $default $param
}

function callDocker($base, $default, $param) {
    &call "docker" $base $default $param
}

function call($program, $base, $default, $param) {
    if($param) {
        &$program $base $param
    }
    else {
        &$program $base $default
    }
}
