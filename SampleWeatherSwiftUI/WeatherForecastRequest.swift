//
//  WeatherForecastRequest.swift
//  SampleWeatherSwiftUI
//
//  Created by mtanaka on 2022/10/05.
// サーバへのリクエスト情報の定義

import Foundation

struct WeatherForecastRequest: BaseRequest {
    typealias ResponseType = WeatherForecast
    
    var method: String {
        return "GET"
    }
    
    var path: String {
        return "/forecast"
    }
    
    var data: Data? {
        return nil
    }
}
