
#!/bin/bash
default(){
    start
}
install(){
    npm install --prefix api
    echo "API Packages Installed"
}
start() {
    cd api && npm run-script test
}
heroku() {
    cd api && npm run-script heroku-start
}

"${@:-default}"