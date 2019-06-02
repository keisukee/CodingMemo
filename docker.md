# docker-compose.yml jessie アップデート問題の解決法
RUN apt の前に下のスクリプトをぶっこむといける。
RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list
