//
//  ContentView.swift
//  CloudOptionalServers
//
//  Created by Maximilian Alexander on 7/24/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var localNetwork = LocalNetworkManager(domain: "local.", type: "_myServiceType._tcp")
    
    var body: some View {
        NavigationStack {
            List {
                Section("Service Status") {
                    if let browserState = localNetwork.browserState {
                        Text("Browser State: \(browserState.humanReadable)")
                    }
                    if let listenerState = localNetwork.listenerState {
                        Text("Listener State: \(listenerState.humanReadable)")
                    }
                }
                Section("Discovered Devices") {
                    ForEach(localNetwork.httpServerURLs, id: \.self) { url in
                        NavigationLink(url, value: url)
                    }
                }
            }
            .navigationTitle("Cloud Optional Servers")
            .navigationDestination(for: String.self) { url in
                WebView(url: url)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
