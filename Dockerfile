FROM pihole/pihole:latest

RUN apt-get update && apt-get install -Vy php-cli php-sqlite3 php-intl php-curl wget unbound

RUN wget https://www.internic.net/domain/named.root -qO- | tee /var/lib/unbound/root.hints

RUN wget -O - https://raw.githubusercontent.com/jacklul/pihole-updatelists/master/install.sh | bash /dev/stdin docker

COPY start_unbound_and_s6_init.sh start_unbound_and_s6_init.sh

RUN chmod +x start_unbound_and_s6_init.sh

ENTRYPOINT ./start_unbound_and_s6_init.sh