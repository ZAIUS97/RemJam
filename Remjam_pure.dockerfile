FROM archlinux:latest

# Update and Install Requirements
RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm git neofetch neovim wget curl python python-pip unzip yara gcc radare2 base-devel

# Install Radare2-Ghidra Plugin
RUN r2pm update && r2pm -ci r2ghidra

# Install JARM
RUN git clone https://github.com/salesforce/jarm.git

RUN cd jarm && pip install -r requirements.txt --break-system-packages

# Install CAPA
RUN wget https://github.com/mandiant/capa/releases/download/v6.1.0/capa-v6.1.0-linux.zip

RUN unzip capa-v6.1.0-linux.zip

RUN chmod +x capa

RUN mv capa /usr/local/bin/capa

RUN rm capa-v6.1.0-linux.zip

# Install YarGen
RUN wget https://github.com/Neo23x0/yarGen/archive/refs/tags/0.23.4.zip

RUN unzip 0.23.4.zip

RUN mv yarGen-0.23.4 yarGen

RUN cd yarGen && python -m pip install -r requirements.txt --break-system-packages

RUN cd yarGen && python yarGen.py --update

RUN rm 0.23.4.zip

# Install FLOSS
RUN wget https://github.com/mandiant/flare-floss/releases/download/v3.0.1/floss-v3.0.1-linux.zip

RUN unzip floss-v3.0.1-linux.zip

RUN mv floss /usr/local/bin/floss

RUN rm floss-v3.0.1-linux.zip

# Installing LOKI

RUN git clone https://github.com/Neo23x0/Loki.git

RUN cd Loki && python -m pip install -r requirements.txt --break-system-packages

# Default command
CMD ["/bin/bash"]
