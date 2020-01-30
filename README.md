# Multi-architecture Build Demo Repository

This repository was created as a resource to demonstrate multi-architecture
buids for the 2020 IBM Fast Start series of internal and business partner
conferences.

During the presentation, I refer to several online resources to demonstrate
good and bad practices of multi-archtecture design.  Here are links to the
resources I use.  (_n.b._ I have pinned the commits used for the images, so
you may wish to explore history or see what's changed since I prepared this
reference.)

## OpenWhisk Utility Image

The primary reason this hasn't been made more multi-architecture friendly is
that because of certain incompatibilities introduced after Docker 1.12, the
images must use Docker 1.12.  Having said that, you can see several instances
of binary downloads in the images.

-   [One-architecture build](https://github.com/apache/openwhisk/blob/4cb41be6b7ea14c8002c9decda4b20f8d0fdd691/tools/ow-utils/Dockerfile)

-   [Multi-architecture adaptation](https://github.com/jonpspri/openwhisk/commit/3bba43349a64f9b79f4bcc21618b76169a08947b#diff-26bd532dcbceedd883aaf9e4c66456c0)
    Here we use `uname -m` to make architecture-friendly decisions

## OpenWhisk API Gateway

-   [OpenWhisk API Gateway](https://github.com/apache/openwhisk-apigateway/blob/fd1f48d88143b431f89f404ac03a1021e0dad38b/Dockerfile)
    I'm not proud to say that this is `uname -m` use taken to the extreme.  The
    testing process has not yet been verified in the multi-architecture build.
    That could happen by the time I get to Las Vegas :).

## Boost Library Builder
-   [Boost Library Builder](https://github.com/jonpspri/boost-builder/blob/8e6185ee469689aef5b14efcd588181990c16e3f/Dockerfile)
    As a counterpoint, this project Just Builds because it pushes responsiblity
    for the architecture-dependent aspects of the build to the library
    configuration script.
