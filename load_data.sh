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

created_network=false
if ! docker network ls | grep -q ${MIP_PRIVATE_NETWORK}
then
	docker network create ${MIP_PRIVATE_NETWORK}
	created_network=true
fi

# 1. Create all the DB at once
echo "Create databases..."
if [ ! -d ${DB_DATA} ]
then
	mkdir -p ${DB_DATA}
	sudo chown -R 999:999 ${DB_DATA}
fi

db_id=$(docker run --rm -d \
	-e POSTGRES_USER="${DB_USER_ADMIN}" \
	-e POSTGRES_PASSWORD="${DB_PASSWORD_ADMIN}" \
	-e PGDATA="/data/pgdata" \
	-v ${DB_DATA}:/data:rw \
	-v ${DB_DATASETS}:/datasets:ro \
	--network=${MIP_PRIVATE_NETWORK} \
	--name ${DB_HOST} \
	${DB_IMAGE}${DB_VERSION}
	)

db_list=""
for f in ${DB_CREATE_LIST}
do
	eval "t=\"\
-e DB${f}=\${DB_NAME${f}} \
-e USER${f}=\${DB_USER${f}} \
-e PASSWORD${f}=\${DB_PASSWORD${f}}\""
	db_list="$db_list $t"
done

sleep 5

docker run --rm \
	-e DB_HOST="${DB_HOST}" \
	-e DB_PORT="${DB_PORT}" \
	-e DB_ADMIN_USER="${DB_USER_ADMIN}" \
	-e DB_ADMIN_PASSWORD="${DB_PASSWORD_ADMIN}" \
	${db_list} \
	--network=${MIP_PRIVATE_NETWORK} \
	${DB_CREATE_IMAGE}${DB_CREATE_VERSION}

# 2. Pre-populate the DBs which needs it
for f in ${DB_SETUP_LIST}
do
	eval "img=\${${f}_IMAGE}"
	eval "version=\${${f}_VERSION}"
	eval "db=\${${f}_DB}"

	echo
	echo "Executing ${img}${version}"

	docker run --rm \
		-e FLYWAY_HOST="${DB_HOST}" \
		-e FLYWAY_PORT="${DB_PORT}" \
		-e FLYWAY_USER="${DB_USER_ADMIN}" \
		-e FLYWAY_PASSWORD="${DB_PASSWORD_ADMIN}" \
		-e FLYWAY_DATABASE_NAME="${db}" \
		--network=${MIP_PRIVATE_NETWORK} \
		${img}${version}
done

docker stop ${db_id}

if ${created_network}
then
	docker network rm ${MIP_PRIVATE_NETWORK}
fi
