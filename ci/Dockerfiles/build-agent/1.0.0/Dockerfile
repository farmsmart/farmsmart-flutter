FROM google/cloud-sdk:241.0.0

RUN SOPS_PKG=/tmp/sops/sops.deb \
    && SOPS_SOURCE=https://github.com/mozilla/sops/releases/download/3.2.0/sops_3.2.0_amd64.deb \
    && mkdir /tmp/sops \
    && curl -L ${SOPS_SOURCE} --output ${SOPS_PKG} \
    && apt install ${SOPS_PKG} \
    && rm ${SOPS_PKG}
