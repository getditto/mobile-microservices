//
//  LocalNetworkManager.swift
//  MobileMicroservices
//
//  Created by Maximilian Alexander on 7/24/23.
//

import Foundation
import Network
import Vapor

struct Device: Hashable {
    let endpoint: NWEndpoint
    let name: String
    var ipAddress: String?
}

class LocalNetworkManager: ObservableObject {
    
    let browser: NWBrowser
    let listener: NWListener
    
    var app: Application!
    
    let domain: String
    let type: String
    let httpServerPort: Int
    
    let myHttpServerURL: String
    
    @Published var httpServerURLs: [String] = []
    @Published var listenerState: NWListener.State?
    @Published var browserState: NWBrowser.State?
    
    var connections: [NWEndpoint: NWConnection] = [:]
    
    init(domain: String, type: String, httpServerPort: Int = 9898) {
        self.domain = domain
        self.type = type
        self.httpServerPort = httpServerPort
        self.myHttpServerURL = "http://\(ProcessInfo.processInfo.hostName):\(httpServerPort)"
        
        let browserParameter = NWParameters.tcp
        browser = NWBrowser(for: .bonjourWithTXTRecord(type: type, domain: nil), using: browserParameter)
        listener = try! NWListener(using: .tcp)
        
        let currentHost = ProcessInfo.processInfo.hostName
        print(currentHost)
        
        
        // we don't want SwiftUI previews to participate
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1" {
            listen()
            browse()
            // let's setup an http server
            
        }
        
    }
    
    func browse() {
        let bonjourParms = NWParameters.init()
        bonjourParms.allowLocalEndpointReuse = true
        // setting this to true will ensure that devices only connect from local links
        bonjourParms.acceptLocalOnly = true
        bonjourParms.allowFastOpen = true
        
        browser.stateUpdateHandler = { [weak self] newState in
            self?.browserState = newState
        }
        browser.browseResultsChangedHandler = { [weak self] ( results, changes ) in
            for change in changes {
                switch change {
                case .added(let result):
                    if case NWBrowser.Result.Metadata.bonjour(let txtRecord) = result.metadata, let httpServerURL = txtRecord.dictionary["httpServerURL"] {
                        self?.httpServerURLs.append(httpServerURL)
                    }
                    break
                case .removed(let result):
                    if case NWBrowser.Result.Metadata.bonjour(let txtRecord) = result.metadata, let httpServerURL = txtRecord.dictionary["httpServerURL"] {
                        self?.httpServerURLs.removeAll(where: { $0 == httpServerURL })
                    }
                    break
                default:
                    break
                }
            }
        }
        browser.start(queue: .main)
    }
    
    
    func listen() {
        // ensure to make the service name "" and it'll list the devices name
        let currentHost = ProcessInfo.processInfo.hostName
        
        let txtRecord = NWTXTRecord(["httpServerURL": "http://\(currentHost):9898"])
        
        self.listener.service = NWListener.Service(name: currentHost, type: type, domain: nil , txtRecord: txtRecord.data)
        self.listener.serviceRegistrationUpdateHandler = { serviceChange in
            print("serviceChange \(serviceChange)")
        }
        self.listener.stateUpdateHandler = { [weak self] (newState) in
            self?.listenerState = newState
        }
        self.listener.newConnectionHandler = { newConnection in
        }
        self.listener.start(queue: .main)
    }
    
    func setupHTTPServer() {
        Task(priority: .background) {
            do {
                self.app = Application(.development)
                self.app.http.server.configuration.hostname = "0.0.0.0"
                self.app.http.server.configuration.port = httpServerPort
                self.app.get() { req in
                    return "Hello from \(self.myHttpServerURL)"
                }
                try app.start()
            }
            catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
}
