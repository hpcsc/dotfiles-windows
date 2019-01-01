$env:TERM="xterm"

function gb() { git branch $args }

Remove-Item "Alias:gc" -Force
function gc() { git commit $args }

Remove-Item "Alias:gcm" -Force
function gcm() { git commit --message $args }

function gco() { git checkout $args }
function gcf() { git commit --amend --reuse-message HEAD $args }
function gfc() { git clone $args }
function gfr() { git pull --rebase $args }
function gia() { git add $args }

Remove-Item "Alias:gp" -Force
function gp() { git push $args }

function gs() { git stash $args }
function gsa() { git stash apply $args }
function gsp() { git stash pop $args }

function gws() { git status $args }

function gloc() {
    git log --topo-order --graph --decorate --pretty=format:"%C(green)%h%C(reset) %s%C(red)%d%C(reset)"
}

function dk() { docker $args }
function dls() { docker container ls -a $args }
function dsa() { docker container start $args }
function dso() { docker container stop $args }
function drm() { docker container rm -v $args }
function di() { docker container inspect $args }
function de() { docker container exec $args }
function dl() { docker container logs $args }
function dit() { docker container run -it $args }

function dils() { docker image ls $args }
function dirm() { docker image rm $args }

function dnls() { docker network ls $args }
function dni() { docker network inspect $args }

function dvls() { docker volume ls $args }
function dvi() { docker volume inspect $args }
function dvrm() { docker volume rm -f $args }

function dc() { docker-compose $args }
function dcls() { docker-compose ps $args }
function dcu() { docker-compose up $args }
function dcd() { docker-compose down -v $args }
function dcr() { docker-compose run $args }
function dcub() { docker-compose up --build $args }
function dcso() { docker-compose stop $args }
function dcsa() { docker-compose start $args }
function dcra() { docker-compose restart $args }
function dce() { docker-compose exec $args }
function dcb() { docker-compose build $args }
function dcl() { docker-compose logs $args }
function dcrm() { docker-compose rm -f $args }
