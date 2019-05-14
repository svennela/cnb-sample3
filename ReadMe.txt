# Remove build-out and check..
cd myisv-cbn
go build -ldflags='-s -w' -o bin/package github.com/cloudfoundry/libcfbuildpack/packager
bin/package build-out

git clone https://github.com/cloudfoundry/openjdk-cnb
git clone https://github.com/cloudfoundry/build-system-cnb
git clone https://github.com/cloudfoundry/jvm-application-cnb
git clone https://github.com/cloudfoundry/procfile-cnb

cd to each git repo above and run below commands
go build -ldflags='-s -w' -o bin/package github.com/cloudfoundry/libcfbuildpack/packager
bin/package build-out

pack create-builder mybuid-pack:v1 --builder-config buildpacks/builder.toml

cd to sample app folder.

pack build --builder mybuid-pack:v1 myapp --env-file myenv.conf

run the application
  docker run myapp
ssh into application
  docker run -it myapp  /bin/bash
