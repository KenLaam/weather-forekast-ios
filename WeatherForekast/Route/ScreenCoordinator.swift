//
//  ScreenCoordinator.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/11/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ScreenCoordinator : ScreenCoordinatorType {
    private var window: UIWindow
    weak var currentViewController: UIViewController?
    
    required init(window: UIWindow) {
        self.window = window
        currentViewController = window.rootViewController
    }
    
    func actualViewController(from viewController: UIViewController) -> UIViewController {
        if let navigationController = viewController as? UINavigationController {
            return navigationController.viewControllers.last!
        }
                
        return viewController
    }
    
    @discardableResult
    func transition(to scene: Screen, type: ScreenTransitionType) -> Completable {
        let vc = scene.createViewController()
        return transition(to: vc, type: type)
    }
    
    @discardableResult
    private func transition(to viewController: UIViewController, type: ScreenTransitionType) -> Completable {
        let subject = PublishSubject<Void>()
        let viewController = viewController
        switch type {
        case .root:
            if let _ = currentViewController?.presentingViewController {
                currentViewController?.dismiss(animated: false)
            }
            self.window.rootViewController = viewController
            self.window.makeKeyAndVisible()
            self.currentViewController = actualViewController(from: viewController)
            subject.onCompleted()
            
        case .push:
            if let vc = currentViewController {
                currentViewController = actualViewController(from: vc)
            }
            guard let navigationController = currentViewController?.navigationController else {
                subject.onCompleted()
                break
            }
            
            _ = navigationController.rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .map { _ in }
                .bind(to: subject)
            
            navigationController.pushViewController(viewController, animated: true)
            currentViewController = actualViewController(from: viewController)
        }
        
        return subject.asObservable()
            .take(1)
            .ignoreElements()
    }
    
    @discardableResult
    func pop(toRootview: Bool, animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()
        if let presenter = currentViewController?.presentingViewController {
            currentViewController?.dismiss(animated: animated) { [weak self] in
                guard let `self` = self else { return }
                self.currentViewController = self.actualViewController(from: presenter)
                subject.onCompleted()
            }
        } else if let navigationController = currentViewController?.navigationController {
            _ = navigationController.rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .map { _ in }
                .bind(to: subject)
            if toRootview {
                guard navigationController.popToRootViewController(animated: animated) != nil else {
                    subject.onCompleted()
                    return subject.asObservable()
                        .take(1)
                        .ignoreElements()
                }
            } else {
                guard navigationController.popViewController(animated: animated) != nil else {
                    subject.onCompleted()
                    return subject.asObservable()
                        .take(1)
                        .ignoreElements()
                }
            }
            currentViewController = actualViewController(from: navigationController.viewControllers.last!)
        } else {
            // Another case
        }
        return subject.asObservable()
            .take(1)
            .ignoreElements()
    }
    
    @discardableResult
    func popToRoot(animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()
        if let navigationController = currentViewController?.navigationController {
            _ = navigationController.rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .map { _ in }
                .bind(to: subject)
            guard navigationController.popToRootViewController(animated: animated) != nil else {
                subject.onCompleted()
                return subject.asObservable()
                    .take(1)
                    .ignoreElements()
            }
            currentViewController = actualViewController(from: navigationController.viewControllers.last!)
        }
        return subject.asObservable()
            .take(1)
            .ignoreElements()
    }
    
    func refreshCurrentViewController(_ controller: UIViewController) {
        currentViewController = actualViewController(from: controller)
    }
}

