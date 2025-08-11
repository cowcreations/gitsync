FROM ghcr.io/pterodactyl/yolks:java_21

USER root

RUN printf '%s\n' \
  '#!/bin/bash' \
  'set -e' \
  'cd /home/container' \
  'echo "[prestart] Running GitSync..."' \
  '[[ -f GitSync-standalone.jar ]] && java -jar GitSync-standalone.jar || echo "[prestart] JAR not found, skipping."' \
  'echo "[prestart] GitSync completed."' \
  'exec /entrypoint.sh "$@"' \
  > /entrypoint_custom.sh \
  && chmod +x /entrypoint_custom.sh \
  && chown container:container /entrypoint_custom.sh

USER container
WORKDIR /home/container
ENTRYPOINT ["/entrypoint_custom.sh"]
