FROM node:10-slim
MAINTAINER Steven Bower <steven@purse.io>

ARG BCOIN_VERSION
ENV BCOIN_VERSION=${BCOIN_VERSION} \
    BCOIN_REPO=https://github.com/bcoin-org/bcoin.git \
    BCOIN_DIR=/code/bcoin

RUN apt-get update \
  && apt-get install -y build-essential git make python \
  && mkdir -p $BCOIN_DIR /data \
  && git clone $BCOIN_REPO $BCOIN_DIR \
  && cd $BCOIN_DIR \
  && git checkout $BCOIN_VERSION \
  && npm install --production \
  && npm uninstall node-gyp \
  && apt-get remove -y build-essential make python git \
  && apt-get autoremove -y

WORKDIR $BCOIN_DIR

CMD ["node", "/code/bcoin/bin/node"]
