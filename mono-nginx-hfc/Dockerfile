FROM mono-nginx-xsp

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libmonosgen-2.0-dev git autoconf libtool-bin \
        automake libtool make libglib2.0-dev libevent-dev \
        libevent-2.0-5 libevent-pthreads-2.0-5 libmonosgen-2.0 \
    && mkdir -p /opt/hfc-install \
    && cd /opt/hfc-install \
    && git clone --depth=1 https://github.com/xplicit/hyperfastcgi \
    && cd /opt/hfc-install/hyperfastcgi \
    && ./autogen.sh --prefix=/usr \
    && make \
    && make install \
    && rm -rf /opt/hfc-install \
    && apt-get remove -y git autoconf automake libtool libtool-bin make libglib2.0-dev libevent-dev libmonosgen-2.0-dev \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/*
