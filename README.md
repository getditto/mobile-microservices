# Mobile Microservices

Ever wondered what it would be like to run HTTP servers at the edge, but the HTTP servers were mobile apps themselves? Also, they could talk to each other _even without an internet connection_. 


## iOS

* The HTTP Server is a [Swift framework called Vapor](https://docs.vapor.codes/)
* Service Discovery is handled via Apple's Network Framework's [`NWBrowser`](https://developer.apple.com/documentation/network/nwbrowser).
* Note, `NWBrowser` does not have the ability to resolve a Hostname. [`NetServiceBrowser`](https://developer.apple.com/documentation/foundation/netservicebrowser) does but has been labeled as __deprecated as of iOS 15__.

## Android

Coming Soon!