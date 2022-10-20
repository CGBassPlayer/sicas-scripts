#!/bin/bash

docker run --rm -it -v $(pwd):/app joskfg/npx npx -p https://cdn.elluciancloud.com/assets/SDK/latest/ellucian-create-experience-extension-latest.tgz create-experience-extension $1
sudo chown -R $UID:$UID $1
