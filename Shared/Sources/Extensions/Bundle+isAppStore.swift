//
//  Bundle+isAppStore.swift
//
//
//  Created by vadim josan on 11.01.2024.
//

import Foundation

extension Bundle {
    public var isAppStore: Bool {
#if targetEnvironment(simulator)
        return false
#else
        let isRunningTestFlightBeta  = (Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt")
        let hasEmbeddedMobileProvision = Bundle.main.path(forResource: "embedded", ofType: "mobileprovision") != nil
        if (isRunningTestFlightBeta || hasEmbeddedMobileProvision) {
            return false
        } else {
            return true
        }
#endif
    }
}
