//
//  HomeViewModel.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/11/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel, ViewModelType {
    
    var forecast = BehaviorRelay<[Forecast]>(value: [])
    var request = RequestForecast()
    
    func setupData() {
    }
    
    func fetchForecast(_ keyword: String? = nil) {
        if keyword != nil {
            request.keyword = keyword
        }
        request.count = 7
        request.units = .celsius
        NetworkService.shared.fetchForecast(request: request)
            .subscribe(onSuccess: { [weak self] response in
                guard let `self` = self else { return }
                if response.isNotFound {
                    self.forecast.accept([])
                    self.error.onNext(ErrorResponse(.notFound))
                } else if let lstForecast = response.lstForecast {
                    self.forecast.accept(lstForecast)
                    self.error.onNext(nil)
                }
            }) { [weak self] error in
                guard let `self` = self else { return }
                if let errorResponse = error as? ErrorResponse {
                    self.error.onNext(errorResponse)
                }
        }.disposed(by: disposeBag)
    }
    
    func openSettings() {
        Router.shared.toSettings()
    }
}
