FROM python:3

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install -y cron

RUN mkdir /code
WORKDIR /code
ADD . /code/
RUN chmod 0755 /code/*.sh

RUN touch /code/cron.log

COPY cjob /etc/cron.d/cjob
RUN chmod 0744 /etc/cron.d/cjob
RUN crontab /etc/cron.d/cjob

#CMD cron -f

ENTRYPOINT ["/bin/sh", "/code/entrypoint.sh"]