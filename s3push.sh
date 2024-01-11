#/bin/sh

echo "Transfert en cours"
aws s3 cp $1 $2
if [ $? -eq 0 ]; then
    echo "Transfert effectué"
else
    echo "Transfert non effectué"
fi

if [ "$3" = 'glacier' ]; then
    echo 'Transfert en mode glacier'
    aws s3 cp $1 $2 --storage-class=GLACIER --profile default
fi