//
//  BaseViewController.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/11/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewController<VM: ViewModelType>: UIViewController, BindableType {
    var viewModel: VM!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLocalization()
    }
    
    func setupUI() {
        
    }
    
    func setupLocalization() {
        
    }
    
    func bindViewModel() {
        
    }
}
