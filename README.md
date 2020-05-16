<!-- SPDX-License-Identifier: MIT -->
# Bats Action

[![CI](https://github.com/ffurrer2/bats-action/workflows/CI/badge.svg)](https://github.com/ffurrer2/bats-action/actions?query=workflow%3ACI)
[![MIT License](https://img.shields.io/github/license/ffurrer2/bats-action)](https://github.com/ffurrer2/bats-action/blob/master/LICENSE)
[![GitHub Release](https://img.shields.io/github/v/release/ffurrer2/bats-action?sort=semver)](https://github.com/ffurrer2/bats-action/releases/latest)

This GitHub Action allows you to run your [Bats](https://github.com/bats-core/bats-core) tests in a customizable Docker container based on the [ffurrer/bats](https://hub.docker.com/r/ffurrer/bats) image.

## Usage

### Prerequisites

- Create a workflow `.yml` file in your `.github/workflows` directory. An [example workflow](#example-workflow) is available below. For more information, reference the GitHub Help Documentation for [Creating a workflow file](https://help.github.com/en/articles/configuring-a-workflow#creating-a-workflow-file).
- Create a Bats test file. For more information, reference the bats-core documentation for [Writing tests](https://github.com/bats-core/bats-core#writing-tests).

### Inputs

| Input                  | Description                                                                       |
| ---------------------- | --------------------------------------------------------------------------------- |
| `main` (optional)      | The Alpine packages to install from the main repository (e.g. `bash curl git`).   |
| `community` (optional) | The Alpine packages to install from the community repository (e.g. `docker-cli`). |
| `testing` (optional)   | The Alpine packages to install from the testing repository.                       |
| `args`                 | The flags, options and arguments of `bats` (e.g. `-p -r ./test`).                 |

## Example: Test a Docker container with Bats

### Example workflow

On every `push` to the master branch, run all tests in the `test_docker_container.bats` file:

```yaml
name: Run Bats tests

on:
  push:
    tags:
      - master

jobs:
  test:
    name: Test Docker container
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: Run Bats tests
        uses: ffurrer2/bats-action@v1
        with:
          community: docker-cli
          args: ./test_docker_container.bats
```

### Example `test_docker_container.bats` file

```bash
#!/usr/bin/env bats

load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "Docker container should include bash" {
    run docker run \
                --rm \
                --entrypoint /bin/sh \
                ffurrer/bats:latest \
                -c '[ -x "$(command -v parallel)" ] || { echo "error: command not found: parallel" >&2; exit 1; }'
    assert_success
}
```

This will use the [ffurrer/bats:1.2.0](https://hub.docker.com/r/ffurrer/bats) image, install the `docker-cli` package from the Alpine community repository and test if `parallel` is installed.

## License

The scripts and documentation in this project are released under the [MIT License](LICENSE).
