//
//  UIDevice+Extensions.swift
//  Template
//
//  Created by vadim josan on 27.11.2023.
//

import UIKit
import Core

extension UIDevice {
    class var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    class var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}

class DeviceType: DeviceTypeProtocol {
    var isPad: Bool { UIDevice.isPad }
    var isPhone: Bool { UIDevice.isPhone }
}
