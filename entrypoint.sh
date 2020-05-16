#!/bin/bash
# SPDX-License-Identifier: MIT
set -euo pipefail

entrypoint() {
    local main_packages="${INPUT_MAIN:-}"
    if [[ -n "${main_packages}" ]]; then
        echo "::debug file=docker-entrypoint.sh,line=8::using input variable: main='${main_packages}'"
        # shellcheck disable=SC2086
        apk --no-cache add ${main_packages}
    fi

    local community_packages="${INPUT_COMMUNITY:-}"
    if [[ -n "${community_packages}" ]]; then
        echo "::debug file=docker-entrypoint.sh,line=15::using input variable: community='${community_packages}'"
        # shellcheck disable=SC2086
        apk --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/latest-stable/community add ${community_packages}
    fi

    local testing_packages="${INPUT_TESTING:-}"
    if [[ -n "${testing_packages}" ]]; then
        echo "::debug file=docker-entrypoint.sh,line=22::using input variable: testing='${testing_packages}'"
        # shellcheck disable=SC2086
        apk --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing add ${testing_packages}
    fi

    local args="${INPUT_ARGS:-}"
    echo "::debug file=docker-entrypoint.sh,line=28::using input variable: args='${args}'"
    # shellcheck disable=SC2086
    /usr/local/bin/bats ${args}
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    entrypoint "$@"
fi
