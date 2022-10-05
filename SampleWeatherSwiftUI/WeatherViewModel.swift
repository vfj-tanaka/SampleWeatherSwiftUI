//
//  WeatherViewModel.swift
//  SampleWeatherSwiftUI
//
//  Created by mtanaka on 2022/10/05.
// サーバからデータ取得及び取得データの保持/更新するクラス

import Foundation
import Combine

/*
 「cancellables」はpublisherをsubscribe(sink)した際の戻り値であるsubscriptionを保持
 cancellablesを保持しているインスタンスが破棄されるタイミングで保持しているsubscription(購読)を全てキャンセル&破棄(RxSwiftではDisposeBag)
 「Publish」属性がついている、「address」と「weathers」プロパティ
 これはCombineで提供されているproperty wrapperで「ObservableObject」プロトコルに準拠しているクラス(今回はWeatherViewModel)の変更をSwiftUI側に通知
 */

class WeatherViewModel: ObservableObject {
    
    private var cancellabels = Set<AnyCancellable>()
    
    @Published
    private(set) var address: String = "取得中"
    
    @Published
    private(set) var weathers: [Weather] = []
    
    func fetchWeatheForecast() {
        let request = WeatherForecastRequest()
        ApiClient.request(request)
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished fetchWeatherForecast.")
                case let .failure(error):
                    print(error)
                }
            } receiveValue: { [weak self] weatherForecast in
                guard let self = self else { return }
                self.weathers = weatherForecast.weathers
                self.address = weatherForecast.address
            }
            .store(in: &cancellabels)
    }
}
