#!/bin/sh
#                    Copyright (c) 2018-2018
#   Data Intensive Applications and Systems Labaratory (DIAS)
#            Ecole Polytechnique Federale de Lausanne
#
#                      All Rights Reserved.
#
# Permission to use, copy, modify and distribute this software and its
# documentation is hereby granted, provided that both the copyright notice
# and this permission notice appear in all copies of the software, derivative
# works or modified versions, and any portions thereof, and that both notices
# appear in supporting documentation.
#
# This code is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. THE AUTHORS AND ECOLE POLYTECHNIQUE FEDERALE DE LAUSANNE
# DISCLAIM ANY LIABILITY OF ANY KIND FOR ANY DAMAGES WHATSOEVER RESULTING FROM THE
# USE OF THIS SOFTWARE.

# Import settings
. ./settings.sh

# Permanent storage for Portainer
test -d ${PORTAINER_DATA} \
	|| mkdir -p ${PORTAINER_DATA} \
	|| ( echo Failed to create ${PORTAINER_DATA}; exit 1 )

sudo docker run -d -p ${PORTAINER_PORT}:9000 \
	--restart unless-stopped \
	-v /var/run/docker.sock:/var/run/docker.sock:rw \
	-v ${PORTAINER_DATA}:/data:rw \
	--name ${COMPOSE_PROJECT_NAME}_${PORTAINER_HOST} \
	${PORTAINER_IMAGE}${PORTAINER_VERSION}
