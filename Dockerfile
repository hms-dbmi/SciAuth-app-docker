FROM dbmi/pynxgu

#Code for sciauth-app
RUN mkdir /sciauth-app/
WORKDIR /sciauth-app/

RUN  echo "abcdefgh" && git clone -b development https://github.com/hms-dbmi/SciAuth.git 
RUN pip install -r /sciauth-app/SciAuth/requirements.txt

RUN mkdir /entry_scripts/
COPY gunicorn-nginx-entry.sh /entry_scripts/
RUN chmod u+x /entry_scripts/gunicorn-nginx-entry.sh

COPY sciauth.conf /etc/nginx/sites-available/pynxgu.conf

WORKDIR /

ENTRYPOINT ["/entry_scripts/gunicorn-nginx-entry.sh"]