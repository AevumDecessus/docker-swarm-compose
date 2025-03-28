#!/usr/bin/env bash
#set +x
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

if [ ! -f ${SCRIPT_DIR}/nets.sh ]; then
  echo "${SCRIPT_DIR}/nets.sh must exist"
  exit 1
else
  source ${SCRIPT_DIR}/nets.sh
fi

NET=""

check_net()
{
  if ! docker network inspect ${NET} 2>&1 > /dev/null; then
    echo "Starting Net ${NET}"
    start_net
  else
    echo "Net ${NET} already exists"
  fi
}

start_net()
{
  docker run -dit --rm --net ${NET} --name net_${NET}_`hostname` alpine
}

for NET in "${nets[@]}"
do
  echo $NET
  check_net
done
