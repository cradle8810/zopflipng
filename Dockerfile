# BUILD #################
FROM alpine:3.12.1 as builder

RUN apk add --no-cache \
        g++ \
        gcc \
        git \
        make

WORKDIR /work

RUN git clone https://github.com/google/zopfli.git && \
    cd /work/zopfli/ && \
    make -j 2 && \
    cp -p zopfli zopflipng /usr/local/bin/ && \
    cd /work && \
    rm -fr /work/zopfli/

# DEPLOY #################
FROM alpine:3.12.1

COPY --from=builder /usr/local/bin/zopfli /usr/local/bin/
COPY --from=builder /usr/local/bin/zopflipng /usr/local/bin/

COPY ./*.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/kai_zopflipng.sh

ENV ZOPFLIPNG /usr/local/bin/zopflipng

ENTRYPOINT ["/usr/local/bin/kai_zopflipng.sh" ]
