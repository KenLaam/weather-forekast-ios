//
//  Router.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/11/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import UIKit
import RxSwift

class Router {
    
    static let shared = Router()
    private init() {}
    
    var coordinator: ScreenCoordinator!
    let disposeBag = DisposeBag()
    
    func setWindow(window: UIWindow) {
        coordinator = ScreenCoordinator(window: window)
    }
    
    @discardableResult
    func pop(_ animated: Bool = true) -> Completable {
        return coordinator.pop(toRootview: false, animated: animated)
    }
    
    @discardableResult
    func popToHome() -> Completable {
        return coordinator.pop(toRootview: true, animated: true)
    }
    
    // MARK: Navigation
    func toHome() {
        coordinator.transition(to: .home, type: .root)
    }
    
    func toSettings(handler: @escaping HandlerUpdateSettings) {
        coordinator.transition(to: .settings(handler), type: .push)
    }
}
