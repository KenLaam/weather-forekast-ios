//
//  WeatherApi.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/12/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import Moya

enum WeatherApi {
    case forecastDaily(_ request: RequestForecast)
}

extension WeatherApi: TargetType {
    var path: String {
        switch self {
        case .forecastDaily:
            return "forecast/daily"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .forecastDaily:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .forecastDaily(let request):
            guard var params = request.dictionary else {
                return .requestPlain
            }
            params["appid"] = AppConfiguration.OPENWEATHERMAP_API_KEY
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var baseURL: URL {
        return URL(string: AppConfiguration.OPENWEATHERMAP_ENDPOINT)!
    }
}
