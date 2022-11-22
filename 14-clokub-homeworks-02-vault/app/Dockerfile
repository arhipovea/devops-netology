FROM fedora:37

RUN dnf -y install pip
RUN pip install hvac==1.0.2

WORKDIR /app
COPY secret.py .

CMD ["python3", "secret.py"]

EXPOSE 8200