FROM ubuntu:16.04

COPY ./techroadcoin.conf /root/.techroadcoin/techroadcoin.conf

COPY . /techroadcoin
WORKDIR /techroadcoin

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:bitcoin/bitcoin

RUN apt-get update
RUN apt-get install -y libdb4.8-dev libdb4.8++-dev build-essential libtool autotools-dev automake pkg-config libssl-dev
RUN apt-get install -y libevent-dev bsdmainutils libboost-all-dev libminiupnpc-dev libzmq3-dev

RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install

EXPOSE 4921
EXPOSE 14921

CMD ["techroadcoin", "--printtoconsole"]
