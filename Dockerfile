FROM ubuntu
ENV DEBIAN_FRONTEND=noninteractive
ENV SOURCE_URL https://pan.yropo.workers.dev/source/zhenxun/
ENV ZHENXUN_URL https://github.com/HibiKier/zhenxun_bot
RUN apt update && apt install -y --no-install-recommends \
    ssh wget npm git vim python3-pip screen fonts-liberation libasound2 libatk-bridge2.0-0 libatk1.0-0 libatspi2.0-0 libcairo2 libcups2 libdbus-1-3 libdrm2 libgbm1 libglib2.0-0 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libx11-6 libxcb1 libxcomposite1 libxdamage1 libxext6 libxfixes3 libxrandr2 xvfb \
    && npm install -g wstunnel
RUN git clone ${ZHENXUN_URL}.git /root/zhenxun_bot \
    && mkdir /run/sshd /root/go-cqhttp /root/zhenxun_bot/data/draw_card /root/zhenxun_bot/resources/img/draw_card \
    && wget ${SOURCE_URL}go-cqhttp -O /root/go-cqhttp/go-cqhttp \
    && wget ${SOURCE_URL}config.yml -O /root/go-cqhttp/config.yml \
    && wget ${SOURCE_URL}data_draw_card.tar.gz -O /root/zhenxun_bot/data/draw_card/draw_card.tar.gz \
    && wget ${SOURCE_URL}img_draw_card.tar.gz -O /root/zhenxun_bot/resources/img/draw_card/draw_card.tar.gz \
    && pip install -r /root/zhenxun_bot/requirements.txt \
    && tar -zxvf /root/zhenxun_bot/data/draw_card/draw_card.tar.gz \
    && tar -zxvf /root/zhenxun_bot/resources/img/draw_card/draw_card.tar.gz
RUN echo 'wstunnel -s 0.0.0.0:80 &' >>/1.sh \
    && echo '/usr/sbin/sshd -D' >>/1.sh \
    && echo '/etc/init.d/frps restart' >>/1.sh \
    && echo 'PermitRootLogin yes' >>  /etc/ssh/sshd_config \ 
    && echo root:uncleluo|chpasswd \
    && chmod 755 /1.sh
EXPOSE 80 8888 443 5130 5131 5132 5133 5134 5135 3306
CMD  /1.sh
