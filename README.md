# docker-postgis

**Note:** This project is still under construction.

A simple docker container that provides a build environment for Kivy

See: http://kivy.org/#home
 

**Note:** We recommend using ``apt-cacher-ng`` to speed up package fetching -
you should configure the host for it in the provided 71-apt-cacher-ng file.

## Getting the image

There are various ways to get the image onto your system:


The preferred way (but using most bandwidth for the initial image) is to
get our docker trusted build like this:


```
docker pull kartoza/kivy
```

To build the image yourself without apt-cacher (also consumes more bandwidth
since deb packages need to be refetched each time you build) do:

```
docker build -t kartoza/kivy git://github.com/kartoza/docker-kivy
```

To build with apt-cache (and minimised download requirements) do you need to
clone this repo locally first and modify the contents of 71-apt-cacher-ng to
match your cacher host. Then build using a local url instead of directly from
github.

```
git clone git://github.com/kartoza/docker-kivy
```

Now edit ``71-apt-cacher-ng`` then do:

```
docker build -t kartoza/kivy .
```

## Run


To create a running container do:

```
sudo docker run --name "kivy" --hostname="kivy" --rm -i -t kartoza/kivy --help
```

## Credits

Tim Sutton (tim@kartoza.com)
May 2014
