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
    var onPullToRefresh = PublishSubject<Void>()
    var refreshingIndicator = PublishSubject<Bool>()
    var toggleSearchBar = BehaviorRelay<Bool>(value: false)
    
    var request = RequestForecast()
    
    func setupObs() {
        request.keyword = "saigon"
        onPullToRefresh.subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.refreshingIndicator.onNext(true)
            self.fetchForecast()
        }).disposed(by: disposeBag)
    }
    
    func fetchForecast(_ keyword: String? = nil) {
        if let keyword = keyword {
            request.keyword = keyword
        }
        request.count = 7
        request.units = .celsius
        NetworkService.shared.fetchForecast(request: request)
            .subscribe(onSuccess: { [weak self] response in
                guard let `self` = self else { return }
                self.refreshingIndicator.onNext(false)
                self.error.onNext(nil)
                self.forecast.accept(response.lstForecast)
            }) { [weak self] error in
                guard let `self` = self else { return }
                self.refreshingIndicator.onNext(false)
                if let errorResponse = error as? ErrorResponse {
                    self.error.onNext(errorResponse)
                }
        }.disposed(by: disposeBag)
    }
}
