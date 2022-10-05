//
//  WeatherForecast.swift
//  SampleWeatherSwiftUI
//
//  Created by mtanaka on 2022/10/05.
// サーバから取得するデータモデルの定義

import Foundation

struct WeatherForecast: Codable {
    // 住所
    let address: String
    // 天気予報
    let weathers: [Weather]
}

struct Weather: Codable {
    // 時間
    let time: Int
    // 天気種別
    let weatherType: WeatherType
    // 降水確率
    let rainyPercent: Int
}

enum WeatherType: Int, Codable {
    
    case sunny = 0
    case cloudy = 1
    case rain = 2
    
    func toString() -> String {
        switch self {
        case .sunny: return "晴れ"
        case .cloudy: return "曇り"
        case .rain: return "雨"
        }
    }
}
