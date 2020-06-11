//
//  NetworkService.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/11/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

struct NetworkService {
    private init() {}
    static let shared = NetworkService()
    let provider = MoyaProvider<WeatherApi>(plugins: [NetworkLoggerPlugin()])
    
    func fetchForecast(request params: RequestForecast) -> Single<ResponseForecast> {
        return request(.forecastDaily(params))
    }
    
    private func request<T: Decodable>(_ target: WeatherApi) -> Single<T> {
        return Single.create(subscribe: { single in
            return self.provider.rx.request(target)
                .retry(AppConfiguration.NETWORK_RETRY_COUNT)
                .flatMap { response -> Single<Response> in
                    Single.just(response)
            }
            .map(T.self)
            .subscribe(onSuccess: { data in
                single(.success(data))
            }) { error in
                let errorResponse = ErrorResponse(.others)
                if let moyaError = error as? Moya.MoyaError {
                    switch moyaError {
                    case .underlying(let nsError as NSError, _):
                        if nsError.code == NSURLErrorTimedOut {
                            errorResponse.type = .timeout
                        } else if nsError.code == NSURLErrorNotConnectedToInternet {
                            errorResponse.type = .offline
                        }
                    default:
                        errorResponse.type = .others
                    }
                }
                single(.error(errorResponse))
            }
        })
    }

}
