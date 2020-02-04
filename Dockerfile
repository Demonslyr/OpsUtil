FROM debian:stretch-slim
WORKDIR /app
COPY ["Delete_Index_Action.yml","."]
COPY ["curatorconfig.yml","."]
RUN apt-get update && apt-get install -y gnupg2 && apt-get install -y wget apt-transport-https ca-certificates && wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add - && echo "deb [arch=amd64] https://packages.elastic.co/curator/5/debian9 stable main" >> /etc/apt/sources.list.d/curator.list
RUN apt-get update && apt-get install -y elasticsearch-curator && apt-get purge -y wget apt-transport-https ca-certificates && apt-get purge -y gnupg2
ENTRYPOINT ["curator","./Delete_Index_Action.yml", "--config ./curatorconfig.yml"]
