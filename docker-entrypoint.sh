#!/bin/bash

function defaults {
    : ${PORT=8000}
    : ${DATADIR='~/packages'}

    echo "PORT is ${PORT}"
    echo "DATADIR is ${DATADIR}"

    export PORT DATADIR
}

defaults

if [ "$1" = 'pypiserver' ]; then
    echo "[RUN]: Launching pypiserver"
    exec pypi-server -p ${PORT} -P ~/htpasswd.txt ${DATADIR}
fi

echo "[RUN]: Builtin command not provided [pypiserver]"
echo "[RUN]: $@"

exec "$@"