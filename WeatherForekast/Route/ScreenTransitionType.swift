//
//  ScreenTransitionType.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/11/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import Foundation
import RxSwift

enum ScreenTransitionType {
    case root
    case push
}

protocol ScreenCoordinatorType {
    @discardableResult
    func transition(to scene: Screen, type: ScreenTransitionType) -> Completable
    
    @discardableResult
    func pop(toRootview: Bool, animated: Bool) -> Completable
}
