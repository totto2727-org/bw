set shell := ["bash", "-euo", "pipefail", "-c"]

check:
    moon check

test:
    moon test

package-list:
    moon package --list
