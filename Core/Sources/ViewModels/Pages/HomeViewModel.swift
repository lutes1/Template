//
//  HomeViewModel.swift
//
//
//  Created by Petru Lutenco on 11.04.2024.
//

import Foundation

public protocol HomeViewModelProtocol: ViewModelProtocol {
    var title: String { get }
}

class HomeViewModel: ViewModel, HomeViewModelProtocol {
    let title: String = "Welcome to the template app!"
}
