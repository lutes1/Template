//
//  ObservableModel.swift
//  Shared
//
//  Created by vadim josan on 14.12.2023.
//

import Foundation
import Combine

public class ObservableModel<T>: ObservableObject {
    @Published
    public var value: T
    
    public init(initialValue: T) {
        self.value = initialValue
    }
    
    public func sink(receiveValue: @escaping ((T) -> Void)) -> AnyCancellable {
        $value.receive(on: DispatchQueue.main).sink(receiveValue: receiveValue)
    }
}

