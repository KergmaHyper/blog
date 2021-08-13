#!/bin/bash
mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

cp app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

echo "From python" >> tempdir/Dockerfile
echo "RUN pip install flask" >> tempdir/Dockerfile
echo "RUN pip install flask-sqlalchemy" >> tempdir/Dockerfile
echo "COPY ./static /home/myapp_blog/static/" >> tempdir/Dockerfile
echo "COPY ./templates /home/myapp_blog/templates/" >> tempdir/Dockerfile
echo "COPY ./app.py /home/myapp_blog/" >> tempdir/Dockerfile
echo "COPY ./blog.db /home/myapp_blog/" >> tempdir/Dockerfile
echo "EXPOSE 6060" >> tempdir/Dockerfile
echo "CMD python3 /home/myapp_blog/app.py" >> tempdir/Dockerfile

cd tempdir
docker build -t appblog .
docker run -t -d --rm -p 6060:6060 --name blogrunning appblog
docker ps -a

