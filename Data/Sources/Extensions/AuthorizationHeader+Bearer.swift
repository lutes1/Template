//
//  AuthorizationHeader+Bearer.swift
//  Data
//
//  Created by Petru Lutenco on 23.11.2023.
//

import Foundation
import Papyrus

extension RequestBuilder.AuthorizationHeader {
    public static var bearer: RequestBuilder.AuthorizationHeader {
        RequestBuilder.AuthorizationHeader(value: "")
    }
}
