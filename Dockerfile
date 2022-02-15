FROM ubuntu
ARG DATABASE_URL
ENV DEBIAN_FRONTEND=noninteractive
ENV SOURCE_URL https://pan.yropo.workers.dev/source/zhenxun/
# ENV SOURCE_KEY ?rootId=0AHwYBwaQO4iYUk9PVA
ENV ZHENXUN_URL https://github.com/HibiKier/zhenxun_bot
ENV ZHENXUN_DIR /root/zhenxun_bot
ENV CQHTTP_DIR /root/go-cqhttp
RUN apt update && apt install -y --no-install-recommends \
    ssh wget npm git vim python3-pip screen fonts-liberation libasound2 libatk-bridge2.0-0 libatk1.0-0 libatspi2.0-0 libcairo2 libcups2 libdbus-1-3 libdrm2 libgbm1 libglib2.0-0 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libx11-6 libxcb1 libxcomposite1 libxdamage1 libxext6 libxfixes3 libxrandr2 xvfb \
    && npm install -g wstunnel
RUN git clone ${ZHENXUN_URL}.git ${ZHENXUN_DIR} \
    && mkdir /run/sshd ${CQHTTP_DIR} ${ZHENXUN_DIR}/data/draw_card ${ZHENXUN_DIR}/resources/img/draw_card /root/.cache \
    && wget ${SOURCE_URL}go-cqhttp -O ${CQHTTP_DIR}/go-cqhttp \
    && wget ${SOURCE_URL}config.yml -O ${CQHTTP_DIR}/config.yml \
    && wget ${SOURCE_URL}data_draw_card.tar.gz -O /root/.cache/data_draw_card.tar.gz \
    && wget ${SOURCE_URL}img_draw_card.tar.gz -O /root/.cache/img_draw_card.tar.gz \
    && pip install -r ${ZHENXUN_DIR}/requirements.txt \
    && tar -zxvf /root/.cache/data_draw_card.tar.gz -C ${ZHENXUN_DIR}/data/draw_card/ \
    && tar -zxvf /root/.cache/img_draw_card.tar.gz -C ${ZHENXUN_DIR}/resources/img/draw_card/ \
    && rm -f /root/.cache/*.tar.gz
RUN echo 'cd /root/zhenxun_bot && python3 bot.py && python3 bot.py &' >> /openssh.sh \
    # && echo '/usr/sbin/sshd -D' >> /openssh.sh \
    # && echo 'wstunnel -s 0.0.0.0:80 &' >> /openssh.sh \
    && echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
    && sed -i "/bind: str = \"\"/cbind: str = \"${DATABASE_URL}\"" ${ZHENXUN_DIR}/configs/config.py \
    && echo root:akashi520|chpasswd \
    && chmod 755 /openssh.sh ${CQHTTP_DIR}/go-cqhttp
EXPOSE 80 443 3306 5432 8888
CMD  /openssh.sh
