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
    var isLoading = BehaviorRelay<Bool>(value: false)
    var request = RequestForecast()
    
    func setupData() {
    }
    
    func fetchForecast(_ keyword: String? = nil) {
        guard let keyword = keyword, keyword.count >= 3 else { return }
        request.keyword = keyword
        isLoading.accept(true)
        NetworkService.shared.fetchForecast(request: request)
            .subscribe(onSuccess: { [weak self] response in
                guard let `self` = self else { return }
                self.isLoading.accept(false)
                if response.isNotFound {
                    self.forecast.accept([])
                    self.error.onNext(ErrorResponse(.notFound))
                } else if let lstForecast = response.lstForecast {
                    self.forecast.accept(lstForecast)
                    self.error.onNext(nil)
                }
            }) { [weak self] error in
                guard let `self` = self else { return }
                self.isLoading.accept(false)
                if let errorResponse = error as? ErrorResponse {
                    self.error.onNext(errorResponse)
                }
        }.disposed(by: disposeBag)
    }
    
    func openSettings() {
        Router.shared.toSettings { [weak self] request in
            guard let `self` = self else { return }
            if self.request != request {
                self.updateRequest(request)
            }
        }
    }
    
    func updateRequest(_ newRequest: RequestForecast) {
        request.count = newRequest.count
        request.lang = newRequest.lang
        request.units = newRequest.units
        fetchForecast(request.keyword)
    }
}
