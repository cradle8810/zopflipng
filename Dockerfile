FROM centos:8

RUN dnf install -y \
        gcc \
        git \
        gcc-c++ \
        make \
        &&\
    dnf clean all

WORKDIR /work

RUN git clone https://github.com/google/zopfli.git && \
    cd /work/zopfli/ && \
    make -j 2 && \
    cp -p zopfli zopflipng /usr/local/bin/ && \
    cd /work && \
    rm -fr /work/zopfli/

ADD kai_zopflipng.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/kai_zopflipng.sh

ENTRYPOINT [ "/usr/local/bin/kai_zopflipng.sh" ]
