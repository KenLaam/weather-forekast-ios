//
//  ForecastTableViewCell.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/12/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import UIKit

class ForecastTableViewCell: BaseTableViewCell<ForecastCellViewModel> {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func bindViewModel() {
        let input = ForecastCellViewModel.Input()
        let _ = viewModel.transform(input)
        
        viewModel.date.bind(to: lblDate.rx.text).disposed(by: disposeBag)
        viewModel.temp.bind(to: lblTemp.rx.text).disposed(by: disposeBag)
        viewModel.pressure.bind(to: lblPressure.rx.text).disposed(by: disposeBag)
        viewModel.humidity.bind(to: lblHumidity.rx.text).disposed(by: disposeBag)
        viewModel.description.bind(to: lblDescription.rx.text).disposed(by: disposeBag)
    }
    
}
