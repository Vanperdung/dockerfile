#!/bin/bash
set -e

USER_NAME=openwrt-user
GROUP_NAME=openwrt-group

if [ -d "/workspace" ]; then
    USER_ID=$(stat -c %u /workspace/)
    GROUP_ID=$(stat -c %g /workspace/)

    echo "Init ${USER_NAME} with uid: ${USER_ID} & gid: ${GROUP_ID}"
    cd /workspace || exit
    # Check if the group already exists; if not, create it
    if ! getent group "${GROUP_ID}" &>/dev/null; then
        groupadd -g "${GROUP_ID}" "${GROUP_NAME}"
    fi

    # Check if the user already exists; if not, create it
    if ! id -u "${USER_NAME}" &>/dev/null; then
        useradd "${USER_NAME}" -u "${USER_ID}" -g "${GROUP_ID}" -ml -s /bin/bash
        usermod -aG sudo "${USER_NAME}"
    fi

    chown -R "${USER_NAME}:${GROUP_NAME}" /workspace
fi

# Execute any passed command as the non-root user, defaulting to bash
if [ "$#" -eq 0 ]; then
    exec sudo -u "${USER_NAME}" -- /bin/bash
else
    exec sudo -u "${USER_NAME}" -- "$@"
fi
