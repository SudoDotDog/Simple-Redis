FROM redis:alpine3.10

ADD master.sh /master.sh
RUN chmod a+x /master.sh
CMD /master.sh
