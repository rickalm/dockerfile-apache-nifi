docker run -d \
  --name=nifi \
  -p 8081:80 \
  -e DISABLE_SSL=true \
  -v flowfiles:/opt/nifi/flowfile_repository \
  -v content:/opt/nifi/content_repository \
  -v database:/opt/nifi/database_repository \
  -v provenance:/opt/nifi/provenance_repository \
  apiri/apache-nifi
