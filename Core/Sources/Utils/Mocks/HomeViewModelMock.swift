//
//  HomeViewModelMock.swift
//  Core
//
//  Created by vadim josan on 27.11.2023.
//

import Foundation

class HomeViewModelMock: HomeViewModelProtocol {
    var pageState: PageState = .ready
    
    let title: String = "This is a mocked title!"
}
