# Mobile Microservices

Ever wondered what it would be like to run HTTP servers at the edge, but the HTTP servers were mobile apps themselves? Also, they could talk to each other _even without an internet connection_. 


## iOS

### Usage

1. Make sure your devices are on the same Local Area Network. 
2. Ensure that your Local Area Network does not have Client Isolation Mode turned on. Client isolation ON means that peer to peer discovery on the Local Area Network is not possible.
3. Open up ios/MobileMicroservices.xcproj
4. Swift Package Manager will begin downloading [Vapor](https://docs.vapor.codes/) 
5. Run the app ideally on an iPhone or iPad. You _can_ run it in the simulator, but only 1 at a time.

### iOS Commentary

* The HTTP Server is a [Swift framework called Vapor](https://docs.vapor.codes/)
* Service Discovery is handled via Apple's Network Framework's [`NWBrowser`](https://developer.apple.com/documentation/network/nwbrowser).
* Note, `NWBrowser` does not have the ability to resolve a Hostname. [`NetServiceBrowser`](https://developer.apple.com/documentation/foundation/netservicebrowser) does but has been labeled as __deprecated as of iOS 15__.
* This project is a proof of concept and isn't recommended without a more robust implementation. Host name resolution depends more on Apple's device name guidelines [described here](https://support.apple.com/en-gb/guide/mac-help/mchlp1177/mac). 
* SwiftUI preview simulators _will not start the `NWBrowser` services_.

## Android

Coming Soon!