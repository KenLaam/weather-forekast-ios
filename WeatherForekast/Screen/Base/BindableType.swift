//
//  BindableType.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/11/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import UIKit
import RxSwift

protocol BindableType {
    associatedtype ViewModelType
    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
}

extension BindableType where Self: UIViewController {
    mutating func bindVM(to model: Self.ViewModelType) {
        viewModel = model
    }
}

extension BindableType where Self: UIView {
    mutating func bindVM(to model: Self.ViewModelType) {
        viewModel = model
        bindViewModel()
    }
}
