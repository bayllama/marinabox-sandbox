FROM alpine:3.19

# Install required packages
RUN apk add --no-cache \
    xvfb \
    x11vnc \
    supervisor \
    chromium \
    websockify \
    bash \
    curl \
    socat \
    ffmpeg \
    python3 \
    py3-pip \
    aws-cli

# Create supervisor config directory
RUN mkdir -p /etc/supervisor.d

COPY noVNC /usr/share/novnc
# Copy the noVNC files to the correct location
RUN cp -r /usr/share/novnc/vnc.html /usr/share/novnc/index.html

# Copy supervisor config
COPY supervisord.conf /etc/supervisor.d/supervisord.ini

# Copy start script and make it executable
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose both VNC and noVNC ports
EXPOSE 5900 6081 9222

CMD ["/start.sh"]