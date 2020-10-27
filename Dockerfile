FROM alpine

RUN adduser -D student

RUN printf "%s\n%s" 1337p455w0rD 1337p455w0rD | passwd student

RUN mkdir /home/student/.ssh

COPY sshchal.pub /home/student/.ssh/authorized_keys

RUN rm -f /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key

RUN apk update

RUN apk add openssh-server gcc libc-dev shadow

WORKDIR /app

COPY init.sh /app

COPY newshell.c /app

RUN gcc newshell.c -o newshell

RUN usermod --shell /app/newshell student

RUN echo "" > /etc/motd

EXPOSE 22

CMD ./init.sh
