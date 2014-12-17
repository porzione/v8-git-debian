Debian packaging for latest google V8 library
===========

**Don't use built packages in production, please. For testing purposes only.**

**amd64 only (google calls this x64)**

### in short

You need debian stuff: build-essential, debhelper, cdbs, etc.
And you need ruby and rake.

Prepare v8 source tree and tools as described [here] (https://code.google.com/p/v8-wiki/wiki/UsingGit).
Also will be helpful [this page] (https://code.google.com/p/v8-wiki/wiki/BuildingWithGYP).

In source three run 

```
rake -f ~/prog/v8deb/Rakefile src:checkout
rake -f ~/prog/v8deb/Rakefile debian:files
```

inspect output and `debian` folder. If everything is ok then run

```
dpkg-buildpackage -nc
```


