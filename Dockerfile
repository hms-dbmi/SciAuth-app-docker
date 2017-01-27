FROM dbmi/pynxgu

COPY SciAuth /SciAuth/
RUN pip install -r /SciAuth/requirements.txt

RUN mkdir /entry_scripts/
COPY gunicorn-nginx-entry.sh /entry_scripts/
RUN chmod u+x /entry_scripts/gunicorn-nginx-entry.sh

COPY sciauth.conf /etc/nginx/sites-available/pynxgu.conf

WORKDIR /

ENTRYPOINT ["/entry_scripts/gunicorn-nginx-entry.sh"]