//
//  AppVersionErrors.swift
//
//
//  Created by Petru Lutenco on 27.03.2024.
//

import Foundation

enum AppVersionErrors: Error {
    case unableToGetInfoDictionaryFromBundle
    case unableToGetAppVersionFromInfoDictionary
}
