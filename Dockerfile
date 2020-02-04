FROM debian:stretch-slim
WORKDIR /app
COPY ["Delete_Index_Action.yml","."]
RUN apt-get update && apt-get install -y gnupg2 && apt-get install -y wget && wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add - && mkdir /etc/apt/sources.list.d && echo "deb [arch=amd64] https://packages.elastic.co/curator/5/debian9 stable main" >> /etc/atp/sources.list.d/curator.list
RUN apt-get update && apt-get install -y elasticsearch-curator && apt-get purge -y wget && apt-get purge -y gnupg2
ENTRYPOINT ["curator","./Delete_Index_Action.yml"]
