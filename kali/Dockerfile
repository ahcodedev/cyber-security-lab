FROM kalilinux/kali-rolling:latest@sha256:6ec743d9fc5cd397451eeddeff3869bcfab5de9bd5dec5b1f34cbfbd80313073

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y \
        kali-linux-default \
        kali-desktop-xfce \
        burpsuite \
        dbus-x11 \
        novnc \
        sudo \
        tigervnc-standalone-server \
        tigervnc-tools \
        websockify \
        zaproxy \
    && rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --shell /bin/bash --groups sudo kali \
    && echo "kali ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/kali \
    && mkdir -p /tmp/.X11-unix \
    && chmod 1777 /tmp/.X11-unix

# nuclei fetches its templates at runtime, which the offline lab cannot do.
# Kept outside /home/kali, which is hidden by the shared volume.
RUN git clone --depth 1 https://github.com/projectdiscovery/nuclei-templates /opt/nuclei-templates \
    && rm -rf /opt/nuclei-templates/.git \
    && chown -R kali:kali /opt/nuclei-templates
ENV NUCLEI_TEMPLATES_DIR=/opt/nuclei-templates

COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh

USER kali
ENV USER=kali
WORKDIR /home/kali

EXPOSE 6080
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
