FROM node:10-slim
MAINTAINER nhutvd <nhutvd@wakumo.vn>

ARG BCOIN_VERSION
ENV BCOIN_VERSION=${BCOIN_VERSION}
ENV BCOIN_DIR=/code/bcoin

COPY . $BCOIN_DIR

RUN apt-get update \
  && apt-get install -y build-essential git make python \
  && cd $BCOIN_DIR \
  && npm install -g --production \
  && npm uninstall node-gyp \
  && apt-get remove -y build-essential make python git \
  && apt-get autoremove -y

WORKDIR $BCOIN_DIR

CMD ["node", "/code/bcoin/bin/node"]
