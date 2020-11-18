FROM alpine:3.12.1

RUN apk add --no-cache \
        g++ \
        gcc \
        git \
        make

WORKDIR /work

RUN git clone https://github.com/google/zopfli.git && \
    cd /work/zopfli/ && \
    CFLAGS=-static make -j 2 && \
    cp -p zopfli zopflipng /usr/local/bin/ && \
    cd /work && \
    rm -fr /work/zopfli/

COPY ./*.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/kai_zopflipng.sh

ENV ZOPFLIPNG /usr/local/bin/zopflipng

ENTRYPOINT ["/usr/local/bin/kai_zopflipng.sh" ]
