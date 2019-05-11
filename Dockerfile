FROM mvertes/alpine-mongo:4.0.5-0

COPY run.sh /root

COPY pre_install.js /root

RUN chmod +x /root/run.sh && \
    chmod +x /root/pre_install.js

CMD [ "mongod", "--bind_ip", "0.0.0.0", "--auth" ]
