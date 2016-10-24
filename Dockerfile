FROM dbmi/pynxgu

#Code for sciauth-app
RUN mkdir /sciauth-app/
WORKDIR /sciauth-app/

RUN  echo "abcdefgh" && git clone -b development https://github.com/hms-dbmi/SciAuth.git 
RUN pip install -r /sciauth-app/SciAuth/requirements.txt

COPY gunicorn-nginx-entry.sh /
RUN chmod u+x /gunicorn-nginx-entry.sh

COPY sciauth.conf /etc/nginx/sites-available/pynxgu.conf

WORKDIR /

ENTRYPOINT ["./gunicorn-nginx-entry.sh"]