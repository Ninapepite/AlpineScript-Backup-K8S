#!/bin/sh
export TARGET_S3_FOLDER="s3://${S3_FOLDER}/${PROJECT_NAME}"
# export USE_MODE=$USE_MODE
echo 'Config S3 with credentials'
eval s3config.sh
echo 'Start working'
DATE=$(date +%Y%m%d_%H%M%S)

COMPRESS_NAME=${PROJECT_NAME}-${BACKUP_TYPE}-${NODE_NAME}-${DATE}.tar.gz
# export VOLUME_DATA="/backup"
if [[ "$USE_MODE" == restore ]]; then
    echo 'No feature actually'
elif [[ "$USE_MODE" == backup ]]; then
    if [[ "$BACKUP_TYPE" == "folder" ]]; then
        echo 'Backup mode for folder'
        # tar -xzf ${FOLDER_TO_BACKUP} -C /backup
        tar -C $FOLDER_TO_BACKUP -zcf /backup/${COMPRESS_NAME} .
        # gzip /backup/$FOLDER_NAME /backup/${FOLDER_TO_BACKUP}.gz
        eval s3push.sh /backup/${COMPRESS_NAME} ${TARGET_S3_FOLDER}/${COMPRESS_NAME}
        echo "Folder ${FOLDER_TO_BACKUP} is backup !"
    # exec /backupMongo.sh
    elif [[ "$BACKUP_TYPE" == "k8sAPI" ]]; then
        echo "Backup mode for k8sAPI"
    elif [[ "$BACKUP_TYPE" == "logs" ]]; then
        echo "Backup mode for logs"
        mkdir -p /backup/logs
        cp ${LOGS_PATH}/* /backup/logs
        tar -C /backup/logs -zcf /backup/${COMPRESS_NAME} .
        eval s3push.sh /backup/${COMPRESS_NAME} ${TARGET_S3_FOLDER}/${COMPRESS_NAME}
    else
        echo "Mauvais configuration de la variable d'environnement BACKUP_TYPE"
    fi
else
    echo "Mauvais configuration de la variable d'environnement USE_MODE"
fi