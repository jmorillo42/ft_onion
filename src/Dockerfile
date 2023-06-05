# Un dockerfile debe comenzar siempre importando la imagen base.
# Para ello, se utiliza la palabra clave "FROM".
FROM nginx

# Con "RUN" se ejecutan los comandos que siguen dentro del contenedor.
# Están enlazados con && para que en el momento que falle uno de ellos, se corte la ejecución.
# `set -x -e` configura el terminal para que imprima todas las salidas de los comandos y que salga en el momento que haya un fallo.
# `apt update` actualiza los índices de los repos (muy importante antes de instalar algún paquete).
# `apt -y install openssh-server` instala sin prenguntar el servidor SSH
# `apt -y install tor` instala sin preguntar el paquete tor.
RUN set -x -e &&  \
    apt update && \
    apt -y install openssh-server && \
    apt -y install tor

RUN useradd -ms /bin/bash cebollo && echo "cebollo:1234" | chpasswd

COPY id_rsa.pub /home/cebollo/.ssh/authorized_keys
RUN chown -R cebollo:cebollo /home/cebollo/.ssh
RUN chmod 600 /home/cebollo/.ssh/authorized_keys

COPY nginx.conf /etc/nginx/
COPY torrc /etc/tor/
COPY sshd_config /etc/ssh/
COPY index.html /usr/share/nginx/html/

# Hay que definir el comando a lanzar cuando la imagen esté lista para ejecutarse.
# Para ello, se usa la palabra clave "CMD".
# El siguiente comando lanza los servicios SSH y Nginx y por último lanza tor.
# Nota: Este no se lanza como servicio para evitar que se cierre docker. Usar para producción.
CMD sh -c "service ssh start && service nginx start && tor"
# El siguiente comando lanza los servicios y finalmente deja la terminal Bash.
# Nota: Usar para desarrollo
#CMD sh -c "service ssh start && service nginx start && service tor start && bash"
