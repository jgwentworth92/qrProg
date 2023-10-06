FROM python:3.12.0a1-buster

RUN apt-get update &&\
    /usr/local/bin/python3 -m pip install --upgrade pip &&\
    /usr/local/bin/python3 -m pip install --upgrade setuptools &&\
    adduser myuser

ENV PATH="/home/myuser/.local/bin:${PATH}"
ENV QR_CODE_IMAGE_DIRECTORY='images'
ENV QR_CODE_DEFAULT_URL='https://www.njit.edu'
ENV QR_CODE_DEFAULT_FILE_NAME='default.png'

WORKDIR /home/myuser

# This will only copy the necessary files, not everything.
# It's a good practice not to copy everything especially if there are unnecessary files/folders (like .git or __pycache__)
COPY --chown=myuser:myuser main.py requirements.txt ./

RUN pip3 install -r requirements.txt

ENTRYPOINT ["runuser", "-u", "myuser", "--", "python3"]
CMD ["main.py"]

