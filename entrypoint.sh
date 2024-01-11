#!/bin/sh
export TARGET_S3_FOLDER="s3://${S3_FOLDER}/${PROJECT_NAME}"
# export USE_MODE=$USE_MODE
echo 'Config S3 with credentials'
eval s3config.sh
echo 'Start working'

$VOLUME_DATA = /backup

if [[ "$USE_MODE" == restore ]]; then
    echo 'No feature actually'
elif [[ "$USE_MODE" == backup ]]; then
    if [[ "$BACKUP_TYPE" == "folder" ]]; then
        echo 'Backup mode for folder'
        gzip $FOLDER_TO_BACKUP /backup/${FOLDER_TO_BACKUP}.gz
        eval s3push.sh /backup/${FOLDER_TO_BACKUP}-${(date +%Y%m%d_%H%M%S)}.gz $TARGET_S3_FOLDER
        echo "Folder ${FOLDER_TO_BACKUP} is backup !"
    # exec /backupMongo.sh
    elif [[ "$BACKUP_TYPE" == "k8sAPI" ]]; then

else
    echo "Mauvais configuration de la variable d'environnement USE_MODE"
fi

