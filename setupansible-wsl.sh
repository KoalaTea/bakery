sudo apt-get update
sudo apt-get install python3-pip git libffi-dev libssl-dev -y
sudo apt install \
      python3-dev \
      python3-pip \
      python3-venv \
      python3-virtualenv
python3 -m venv venv
. venv/bin/activate
pip install --user ansible pywinrm
ansible-galaxy collection install community.general
