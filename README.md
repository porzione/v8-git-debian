Build latest google V8 library to debian package 
===========

**Don't use built packages in production, please. For testing purposes only.**

### in short

You need debian stuff: build-essential, debhelper, cdbs, etc.
And you need ruby and rake, sorry for this.

Prepare v8 source tree and tools and described [here] (https://code.google.com/p/v8-wiki/wiki/UsingGit).
Also will be helpful [this page] (https://code.google.com/p/v8-wiki/wiki/BuildingWithGYP).

In source three run 

```
rake -f ~/prog/v8deb/Rakefile
```

inspect output and `debian` folder. If everything is ok then run

```
dpkg-buildpackage -nc
```


