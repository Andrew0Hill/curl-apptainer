FROM rockylinux/rockylinux:9

WORKDIR /app

RUN dnf install -y epel-release && \
    dnf install -y apptainer-suid

COPY entrypoint.sh ./entrypoint.sh

RUN chmod +x ./entrypoint.sh

VOLUME /build

ENTRYPOINT [ "/app/entrypoint.sh" ]