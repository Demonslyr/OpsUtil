FROM debian:stretch-slim
WORKDIR /app
COPY ["Delete_Index_Action.yml","."]
RUN wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
RUN nano /etc/atp/sources.list.d/curator.list << "deb [arch=amd64] https://packages.elastic.co/curator/5/debian9 stable main"
RUN apt-get update && apt-get install -y elasticsearch-curator
ENTRYPOINT ["curator","./Delete_Index_Action.yml"]
