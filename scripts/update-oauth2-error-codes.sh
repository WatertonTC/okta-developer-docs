#!/usr/bin/env bash
# See https://bit.ly/2WRXVta for details

# Strict
set -o errexit -o pipefail

# Constants
readonly url=https://artifactory.es.atko.services/artifactory/okta-all/com/okta/monolith/platform.tokens.api/%5BRELEASE%5D/platform.tokens.api-%5BRELEASE%5D-metadata.jar
readonly archive=/tmp/oauth2-error-codes.zip
readonly file=oauth2-error-codes.json
readonly dir=packages/@okta/vuepress-site/data

main() {
    oauth2-error-codes-download
    echo
    oauth2-error-codes-update
    echo
    oauth2-error-codes-diff
}

oauth2-error-codes-download() {
    banner "Downloading jar from $url..."
    curl -k -L $url > $archive || die "Could not download file"
}

oauth2-error-codes-update() {
    banner "Updating $file..."
    unzip -o $archive $file -d $dir || die "Could not unzip file"
    rm $archive
}

oauth2-error-codes-diff() {
    banner "Showing differences in $file..."
    git --no-pager diff $dir/$file || die "Could not diff file"
}

banner() {
    local -r line=$(printf -- '-%.0s' {1..100}); status $line; status "$1"; status $line;
}

status() {
    green "$1";
}

die() {
    red "${1:-Exiting}" >&2 && exit 1;
}

green() {
    ansi 32 "$@";
}
red() {
    ansi 91 "$@";
}
ansi() {
    echo -e "\033[${1}m${*:2}\033[0m";
}

# Entry point
main
