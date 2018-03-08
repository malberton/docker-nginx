# Setting Up NGINX With Docker
---

After installing Docker, you can use the existing official [NGINX image](https://hub.docker.com/_/nginx/) to build your own custom image

### Before Building the Image
- Begin by navigating to this repo's root directory (in Terminal) after cloning it
- (Optional) Update the `www/index.html` file however you'd like
- (Optional) Edit the `conf/default.conf` file as you require
- Make sure any changes you've made are reflected properly in the **Dockerfile**
  - The **Dockerfile** lists the instructions for building the image that will be used as the basis for any containers you make
  - In this particular case, the **Dockerfile** builds the image from the existing `nginx` official image
  - The `index.html` and `default.conf` files are copied into their appropriate folders in the `nginx` image
  - Additionally, those same volumes are exposed so that they can be accessible later on

### Building the Image
- To build the image, enter the following command in Terminal:
  - `$ docker build -t <image_name> .`
    - `docker build` is the command used for building images in Docker
    - `-t <image_name>` names the new image
    - `.` indicates that the image will run the **Dockerfile** located in the current folder (you should still be in the repo's root folder)
  - After entering the command, Docker will build the image by pulling the latest `nginx` image automatically from the repo in Docker Hub. This is the base image that will be modified to create the one indicated in the **Dockerfile**

### Running a Container
- Now that the image has been built, we need to start up a container to run:
  - `$ docker run --name <container_name> -p 1111:80 -d <image_name>`
    - `docker run` is the command used for running a container from an image
    - `--name <container_name>` gives the new container a name of your choosing. Omitting this auto-generates a name
    - `-p 80:80` maps the port of the host machine to the container (general form is `-p host-port:container-port`)
    - `-d` indicates that this container will run in detached mode. This just means it will run in the background
    - `<image_name>` refers to the image build earlier. This just tells Docker which image to use to run this container from
- At this point, the image should be up and running. You can verify this in one of two ways:
  - In Terminal, enter `$ curl localhost:1111`
  - In your web browser, navigate to `localhost:1111`
  - If successful in either case, you should see the contents of the `index.html` file

### Modifying the Container
- Remember those volumes we mounted in the **Dockerfile**? We did that so that in case a file in those folders needs to be edited, we can gain access to it with a *helper container*
  - `$ docker run -i -t --volumes-from <container_name> --name <helper_container_name> ubuntu bash`
    - `-i` means that we will be running an interactive shell
    - `-t` allocates a pseudo-TTY
    - `--volumes-from <container_name>` allows access to the volumes mounted in `<container_name>`
    - `ubuntu bash` uses the `ubuntu` image running a `bash` shell so you can modify as needed
  - At ths point, you should be given root access to the helper container
    - In Terminal, the command line should switch to `root@<helper_container_ID>:/#`
  - Now you can navigate to the volumes that we mounted via the **Dockerfile**!
  - Any modifications you make here (`<helper_container_name>`) are shared with the previously created container (`<container_name>`)
    - For example, navigate to `usr/share/nginx/html/index.html` and change whatever you'd like
    - Refresh your browser or issue a new `curl localhost:1111` command in Terminal (assuming your first container is still running)
    - You should see that any changes made inside the helper container are reflected in the first container!
---

Obviously there is a lot more that can be done, but this is just meant to be a starting point for learning Docker and being introduced to NGINX
