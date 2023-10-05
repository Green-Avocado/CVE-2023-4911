FROM ubuntu:jammy-20230816

RUN apt-get update && apt-get install -y gcc python3

RUN useradd -m user
USER user
WORKDIR /home/user

COPY --chown=user ./patch.py /home/user/patch.py
COPY --chown=user ./poc.c /home/user/poc.c

RUN python3 patch.py
RUN gcc poc.c -o poc

FROM ubuntu:jammy-20230816

RUN useradd -m user
USER user
WORKDIR /home/user

COPY --chown=user --from=0 /home/user/poc /home/user/poc
COPY --chown=user --from=0 /home/user/'"'/libc.so.6 /home/user/'"'/libc.so.6

CMD ["/bin/bash"]
