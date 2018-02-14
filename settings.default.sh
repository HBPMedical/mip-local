: ${SHOW_SETTINGS:=false}

#############################################################################
# DATABASES
# Service Parameters
: ${DB_IMAGE:="postgres"}
: ${DB_VERSION:=":9.6.5-alpine"}
: ${DB_HOST:="db"}
: ${DB_PORT:="5432"}
: ${DB_DATA:="${PWD}/postgres"}
: ${DB_DATASETS:="${PWD}/datasets"}
: ${DB_USER_ADMIN:="postgres"}
: ${DB_PASSWORD_ADMIN:="test"}

# Databases Definitions:
#  1. To add a new DB, copy the last 3 lines below and increment the id
#  2. Add the new number in DB_CREATE_LIST
: ${DB_NAME1:="meta"}
: ${DB_USER1:="meta"}
: ${DB_PASSWORD1:="metapwd"}

: ${DB_NAME2:="features"}
: ${DB_USER2:="features"}
: ${DB_PASSWORD2:="featurespwd"}

: ${DB_NAME3:="woken"}
: ${DB_USER3:="woken"}
: ${DB_PASSWORD3:="wokenpwd"}

: ${DB_NAME4:="portal"}
: ${DB_USER4:="portal"}
: ${DB_PASSWORD4:="portalpwd"}

# Database setup tools
: ${DB_CREATE_IMAGE:="hbpmip/create-databases"}
: ${DB_CREATE_VERSION:=":1.0.0"}
# List of databases to create
: ${DB_CREATE_LIST:="1 2 3 4"}

: ${WOKEN_SETUP_IMAGE:="hbpmip/woken-db-setup"}
: ${WOKEN_SETUP_VERSION:=":1.0.2"}
: ${WOKEN_SETUP_DB:=${DB_NAME3}}

: ${METADATA_SETUP_IMAGE:="hbpmip/sample-meta-db-setup"}
: ${METADATA_SETUP_VERSION:=":0.4.0"}
: ${METADATA_SETUP_DB:=${DB_NAME1}}

: ${DATA_SETUP_IMAGE:="hbpmip/sample-data-db-setup"}
: ${DATA_SETUP_VERSION:=":0.5.0"}
: ${DATA_SETUP_DB:=${DB_NAME2}}

# List of databases to populate
: ${DB_SETUP_LIST:="WOKEN_SETUP METADATA_SETUP DATA_SETUP"}

#############################################################################
: ${MIP_PRIVATE_NETWORK:="mip_local"}
: ${COMPOSE_PROJECT_NAME:="mip"}

: ${PORTAINER_IMAGE:="portainer/portainer"}
: ${PORTAINER_VERSION:=":latest"}
: ${PORTAINER_HOST:="portainer"}
: ${PORTAINER_PORT:="9000"}
: ${PORTAINER_DATA:="${PWD}/portainer"}
: ${PORTAINER_ENABLED:="true"}

#############################################################################
# Services
: ${ZOOKEEPER_IMAGE:="zookeeper"}
: ${ZOOKEEPER_VERSION:=":3.4.11"}
: ${ZOOKEEPER_PORT1:="2181"}
: ${ZOOKEEPER_PORT2:="2888"}
: ${ZOOKEEPER_PORT3:="3888"}

: ${MESOS_MASTER_IMAGE:="mesosphere/mesos-master"}
: ${MESOS_MASTER_VERSION:=":1.3.0"}
: ${MESOS_MASTER_PORT:="5050"}
: ${MESOS_MASTER_LOGS:="${PWD}/mesos-master/logs"}
: ${MESOS_MASTER_TMP:="${PWD}/mesos-master/tmp"}

: ${MESOS_SLAVE_IMAGE:="mesosphere/mesos-slave"}
: ${MESOS_SLAVE_VERSION:=":1.3.0"}
: ${MESOS_SLAVE_PORT:="5051"}
: ${MESOS_SLAVE_LOGS:="${PWD}/mesos-slave/logs"}
: ${MESOS_SLAVE_TMP:="${PWD}/mesos-slave/tmp"}

: ${CHRONOS_IMAGE:="mesosphere/chronos"}
: ${CHRONOS_VERSION:=":v3.0.2"}
: ${CHRONOS_HOST:="chronos"}
: ${CHRONOS_PORT1:="4400"}
: ${CHRONOS_PORT2:="4401"}

: ${WOKEN_IMAGE:="hbpmip/woken"}
: ${WOKEN_VERSION:=":2.1.4"}
: ${WOKEN_HOST:="woken"}
: ${WOKEN_PORT1:="8088"}
: ${WOKEN_PORT2:="8087"}
: ${WOKEN_CONF:="${PWD}/woken/application.conf"}
: ${WOKEN_MAIN_TABLE:="cde_features_a"}
: ${WOKEN_EXAREME_URL:="http://prozac.madgik.di.uoa.gr:9090/mining/query"}

: ${WOKEN_VALIDATION_IMAGE:="hbpmip/woken-validation"}
: ${WOKEN_VALIDATION_VERSION:=":2.1.0"}
: ${WOKEN_VALIDATION_HOST:="woken-validation"}
: ${WOKEN_VALIDATION_PORT:="8082"}
: ${WOKEN_VALIDATION_CONF:="${PWD}/woken/validation.conf"}

: ${PORTAL_BACKEND_IMAGE:="hbpmip/portal-backend"}
: ${PORTAL_BACKEND_VERSION:=":2.5.4"}
: ${PORTAL_BACKEND_AUTHENTICATION:="0"}
: ${PORTAL_BACKEND_CLIENT_ID:="none"}
: ${PORTAL_BACKEND_CLIENT_SECRET:="none"}

: ${PORTAL_FRONTEND_IMAGE:="hbpmip/portal-frontend"}
: ${PORTAL_FRONTEND_VERSION:=":2.6.0"}
: ${PORTAL_FRONTEND_PORT:="80"}
: ${PORTAL_FRONTEND_URL:="http://172.16.22.176:80"}