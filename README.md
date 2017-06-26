README
====

How to publish / update the website
----

* Generating the website index;

```bash
./src/main/bash/build-websites.sh > src/main/webapp/index.html
```

* Update the "macro" resume of the campaign:

```bash
./src/main/bash/build-books.sh > src/main/webapp/book.html
```

* git commit and push to release

Misc
----

The OpenShift `jbossas` cartridge documentation can be found at:

https://github.com/openshift/origin-server/tree/master/cartridges/openshift-origin-cartridge-jbossas/README.md
