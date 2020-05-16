# SPDX-License-Identifier: MIT
FROM ffurrer/bats:1.2.0

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
