# SPDX-License-Identifier: MIT
FROM ffurrer/bats:1.2.1

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
