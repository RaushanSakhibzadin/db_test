FROM jenkins/jenkins:lts
USER root
RUN apt-get update &&     apt-get install -y python3 python3-pip python3-venv openjdk-11-jdk &&     python3 -m venv /opt/venv &&     /opt/venv/bin/pip install pytest psycopg2-binary
ENV PATH="/opt/venv/bin:/opt/homebrew/bin:/Users/roha/.nvm/versions/node/v16.19.0/bin:/Users/roha/Library/Android/sdk/tools:/Users/roha/Library/Android/sdk/tools/bin:/Users/roha/Library/Android/sdk/platform-tools:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Library/Apple/usr/bin:/usr/local/go/bin:/Library/Frameworks/Mono.framework/Versions/Current/Commands"
USER jenkins
