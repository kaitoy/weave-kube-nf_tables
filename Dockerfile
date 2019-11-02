FROM weaveworks/weave-kube:2.5.2 AS weave

RUN cp /home/weave/weave /tmp/ \
    && \
    cp /home/weave/weaver /tmp/ \
    && \
    cp /usr/bin/weaveutil /tmp/ \
    && \
    cp /home/weave/launch.sh /tmp/ \
    && \
    cp /home/weave/kube-utils /tmp/

FROM alpine:3.10.2

COPY --from=weave /tmp/weave /home/weave/
COPY --from=weave /tmp/weaver /home/weave/
COPY --from=weave /tmp/launch.sh /home/weave/
COPY --from=weave /tmp/kube-utils /home/weave/
COPY --from=weave /tmp/weaveutil /usr/bin/

RUN apk update \
    && \
    apk --no-cache add \
        curl \
        ethtool \
        iptables \
        ipset \
        iproute2 \
        util-linux \
        conntrack-tools \
        bind-tools \
        ca-certificates \
    && \
    ln -fs /sbin/xtables-nft-multi /sbin/iptables \
    && \
    ln -fs /sbin/xtables-nft-multi /sbin/iptables-restore \
    && \
    ln -fs /sbin/xtables-nft-multi /sbin/iptables-save

WORKDIR /home/weave
ENTRYPOINT ["/home/weave/launch.sh"]
