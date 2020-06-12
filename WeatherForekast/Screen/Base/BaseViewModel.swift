//
//  BaseViewModel.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/11/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelType {
    func setupData()
}

class BaseViewModel {
    var disposeBag = DisposeBag()
    var error = PublishSubject<ErrorResponse?>()
}
