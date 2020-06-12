//
//  SettingsViewController.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/11/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SettingsViewController: BaseViewController<SettingsViewModel> {
    
    @IBOutlet weak var lblNumOfDays: UILabel!
    @IBOutlet weak var sliderNumOfDays: UISlider!
    @IBOutlet weak var lblLang: UILabel!
    @IBOutlet weak var segmentLanguage: UISegmentedControl!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var segmentTemp: UISegmentedControl!
    
    override func setupUI() {
        let btnBack = UIBarButtonItem(title: "Back".localized(), style: .plain, target: self, action: #selector(didTapBack))
        navigationItem.leftBarButtonItem = btnBack
        let btnDone = UIBarButtonItem(title: "Done".localized(), style: .done, target: self, action: #selector(didTapDone))
        navigationItem.rightBarButtonItem = btnDone
        
        [lblNumOfDays, lblLang, lblTemp].forEach {
            $0?.numberOfLines = 0
            $0?.font = UIFont.preferredFont(forTextStyle: .body)
        }
        
        sliderNumOfDays.minimumValue = Float(AppConfiguration.FORECAST_DAYS_MIN)
        sliderNumOfDays.maximumValue = Float(AppConfiguration.FORECAST_DAYS_MAX)
        sliderNumOfDays.rx.value.map {
            Int($0)
        }.subscribe(onNext: { value in
            self.sliderNumOfDays.value = Float(value)
            self.lblNumOfDays.text = "Number of days: \(value)".localized()
        }).disposed(by: disposeBag)
        sliderNumOfDays.value = Float(viewModel.request.count)
        
        segmentLanguage.removeAllSegments()
        segmentLanguage.insertSegment(withTitle: "English", at: 0, animated: false)
        segmentLanguage.insertSegment(withTitle: "Tiếng Việt", at: 1, animated: false)
        segmentLanguage.selectedSegmentIndex = 0
        
        segmentTemp.removeAllSegments()
        segmentTemp.insertSegment(withTitle: TemperatureUnit.celsius.name, at: 0, animated: false)
        segmentTemp.insertSegment(withTitle: TemperatureUnit.kelvin.name, at: 0, animated: false)
        segmentTemp.insertSegment(withTitle: TemperatureUnit.fahrenheit.name, at: 0, animated: false)
        segmentTemp.selectedSegmentIndex = 0
    }
    
    override func setupLocalization() {
        title = "Settings"
        lblNumOfDays.text = "Number of days".localized()
        lblLang.text = "Language".localized()
        lblTemp.text = "Temperature Unit".localized()
    }
    
    @objc func didTapBack() {
        viewModel.backPrevious()
    }
    
    @objc func didTapDone() {
        viewModel.finishSettings()
    }
}
