# Cuda environment with Docker

## Requirements
* Install [nvidia-container-toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html): to enable container using **gpu**

## Build and run environment
Restart docker.
```
sudo systemctl restart docker
```
Initiate container.
```
sudo docker compose up --build -d
```
Connect VScode with virtual ssh-server.
```
ssh -p 60001 hicehehe@<ip address>
```
Inside container, install pytorch normally, refer [here](https://pytorch.org/#:~:text=Aid%20to%20Ukraine.-,INSTALL%20PYTORCH,-Select%20your%20preferences).