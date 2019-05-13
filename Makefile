DIRS = ../openjdk-cnb ../build-system-cnb ../jvm-application-cnb ../procfile-cnb

main: buildpacks my-buildpack my-app

buildpacks:
	$(foreach adir,$(DIRS),cd $(adir);go build -ldflags='-s -w' -o bin/package github.com/cloudfoundry/libcfbuildpack/packager; bin/package build-out;) 

my-buildpack:
	pack create-builder mybuild-pack:v1 --builder-config buildpacks/builder.toml

my-app:
	cd sample-java-app; pack build --builder mybuild-pack:v1 myapp --env-file myenv.conf

