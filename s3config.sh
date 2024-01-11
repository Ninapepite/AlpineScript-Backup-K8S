#!/bin/sh

# Création du répertoire .aws s'il n'existe pas déjà
mkdir ~/.aws

# Affichage des variables d'environnement (utile pour le débogage)
env

# Configuration des paramètres AWS pour l'utilisation avec la CLI AWS
echo -e "\
[plugins]
endpoint = awscli_plugin_endpoint

[default]
region = fr-par
s3 =
  endpoint_url = ${AWS_ENDPOINT_URL}

  signature_version = s3v4
  max_concurrent_requests = 100
  max_queue_size = 1000
  multipart_threshold = 50MB
  # Edit the multipart_chunksize value according to the file sizes that you want to upload. The present configuration allows to upload files u$
  multipart_chunksize = 10MB
s3api =

  endpoint_url = ${AWS_ENDPOINT_URL}

" > ~/.aws/config

# Création du fichier de configuration des identifiants AWS
echo -e "\
[default]

aws_access_key_id=${AWS_ACCESS_KEY_ID}
aws_secret_access_key=${AWS_SECRET_ACCESS_KEY}


" > ~/.aws/credentials
