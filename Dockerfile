FROM golang:1.15.7-buster

ENV HUGO_BASEURL=http://localhost/ \
    HUGO_ENV=production

WORKDIR /root

RUN git clone https://github.com/gohugoio/hugo.git && \
  cd hugo && \
  git checkout v0.80.0 && \
  go install . && \
  cd ..

RUN git clone https://github.com/negrel/sethg.info.git && \
  cd sethg.info && \
  git submodule update --init && \
  cd sethg && \
  ./update.sh

WORKDIR /root/sethg.info/sethg

CMD hugo server \
	--bind 0.0.0.0 \
	--minify \
    --baseURL ${HUGO_BASEURL} \
