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
    struct Input {
    }
    
    struct Output {
    }
    
    var forecast = BehaviorRelay<[Forecast]>(value: [])
    var onPullToRefresh = PublishSubject<Void>()
    var refreshingIndicator = PublishSubject<Bool>()
    
    var request = RequestForecast()
    
    func transform(_ input: Input) -> Output {
        request.keyword = "saigon"
        onPullToRefresh.subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.refreshingIndicator.onNext(true)
            self.fetchForecast { response in
                self.forecast.accept(response.lstForecast)
            }
        }).disposed(by: disposeBag)
        return Output()
    }
    
    func fetchForecast(completion: @escaping (ResponseForecast) -> Void) {
        NetworkService.shared.fetchForecast(request: request)
            .subscribe(onSuccess: { [weak self] response in
                guard let `self` = self else { return }
                self.refreshingIndicator.onNext(false)
                self.error.onNext(nil)
            }) { [weak self] error in
                guard let `self` = self else { return }
                self.refreshingIndicator.onNext(false)
                if let errorResponse = error as? ErrorResponse {
                    self.error.onNext(errorResponse)
                }
        }.disposed(by: disposeBag)
    }
}
