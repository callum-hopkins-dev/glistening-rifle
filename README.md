# glistening-rifle

A modded minecraft server designed to be ran in a containerised environment.

## about

`glistening-rifle` is an extremely simple minecraft server running on the fabric mod-loader and has been packaged into a `dockerfile` which is tested with both `docker` and `podman`. The world persistance is handled by mounting a volume to the `/var/universe` directory of the container. The `/mods` folder of this repository contains all of the mods which will be loaded into the server. These mods are copied at build-time into the container image which may result in large cache sizes. Finally, the `ops.txt` folder can be used to add players who should be operators by default.

**NOTE:** The `dockerfile` does not pre-cache the fabric mod-loader, or the mods during build-time which means the container must have open internet access to bootstrap the necessary files at run-time.

## usage

### server

To run the server on your local machine you will first need to install an `oci` container runtime such as `docker` or `podman`.
 - Clone this repository to your local machine: `git clone https://github.com/dev-callum-hopkins/glistening-rifle.git --branch upbeat-offer`
 - Enter the repository directory: `cd glistening-rifle`
 - And build the container image: `podman build . -t ghcr.io/dev-callum-hopkins/glistening-rifle:upbeat-offer`
 - Create a storage volume to persist the world data `podman volume create glistening-rifle`
 - Finally run the container: `podman run -v "glistening-rifle:/var/universe" -p 25565:25565 -d ghcr.io/dev-callum-hopkins/glistening-rifle:upbeat-offer`
 
If you are running `docker` then the previous commands can just be substitute with `docker` instead of `podman`. 

### client

To connect to the server as a client you will first need to install the fabric mod-loader: [https://fabricmc.net/use/installer/](https://fabricmc.net/use/installer/)
 - Clone this repository to your local machine: `git clone https://github.com/dev-callum-hopkins/glistening-rifle.git --branch upbeat-offer`
 - Then copy the files within the `/mods` directory to your minecraft instance's prefered mods folder.
