//
//  ExtensionMethods.swift
//  MobileMicroservices
//
//  Created by Maximilian Alexander on 7/24/23.
//

import Foundation
import Network

extension NWBrowser.State {
    var humanReadable: String {
        switch self {
        case .setup:
            return "Setup"
        case .ready:
            return "Ready"
        case .failed(let nWError):
            return "Failed: \(nWError.localizedDescription)"
        case .cancelled:
            return "Canceled"
        case .waiting(let nWError):
            return "Waiting \(nWError.localizedDescription)"
        @unknown default:
            return "Unknown"
        }
    }
}

extension NWListener.State {
    var humanReadable: String {
        switch self {
        case .setup:
            return "Setup"
        case .waiting(let nWError):
            return "Waiting \(nWError.localizedDescription)"
        case .ready:
            return "Ready"
        case .failed(let nWError):
            return "Failed: \(nWError.localizedDescription)"
        case .cancelled:
            return "Canceled"
        @unknown default:
            return "Unknown"
        }
    }
}
