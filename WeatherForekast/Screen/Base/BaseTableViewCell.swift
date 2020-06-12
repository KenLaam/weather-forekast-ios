//
//  BaseTableViewCell.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/12/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseTableViewCell<T: ViewModelType>: UITableViewCell, BindableType {
    var disposeBag = DisposeBag()
    var viewModel: T!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    private func setup() {
        setupUI()
        updateData()
    }
    
    func bindViewModel() {
        
    }
    
    func setupUI() {
        
    }
    
    //MARK: Text and localized
    func updateData() {
        
    }
}

