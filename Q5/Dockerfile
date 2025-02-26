FROM ubuntu:latest 
RUN apt-get update && apt-get install -y bash coreutils
COPY My_species.sh /usr/local/bin/My_species.sh
RUN chmod +x /usr/local/bin/My_species.sh
CMD ["/usr/local/bin/My_species.sh"]

