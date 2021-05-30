#!/bin/bash
default() {
    start
}
install() {
    npm install --prefix api
    echo "API Packages Installed"
}
start() {
    cd api && npm run-script test
}
heroku() {
    cd api && npm run-script start
}
emptyRedis() {
    redis-cli -h scat.redistogo.com -p 11933 -a 2e466ea010dee06ad8910bb678418b81 flushall
}
"${@:-default}"
