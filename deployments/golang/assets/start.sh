#!/bin/sh

export CURDIR="$(cd $(dirname ${0}); pwd)"

cd ${CURDIR}

echo "current user:$(id)"
echo "current path:$(cd .; pwd)"
echo "current timestamp:$(date -u '+%Y.%M.%d.%H.%m.%s.%Z')"

if [ "$(id -u)" -ne "$(id -u appuser)" ] 
then
    >&2 echo "Service can only be run by appuser - $(id -u) is not permitted."
    exit 1
else
    if [ ! -x ${CURDIR}/service ]
    then
        echo "${CURDIR}/service doesn't exist, or it is not executable, press Ctrl+C to exit"
        watch watch date -u '+%Y.%m.%d.%H.%M.%S.%Z'
    else
        ${CURDIR}/service ${*}
    fi
fi

echo "done."


