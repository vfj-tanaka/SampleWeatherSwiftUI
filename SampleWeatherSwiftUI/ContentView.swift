//
//  ContentView.swift
//  SampleWeatherSwiftUI
//
//  Created by mtanaka on 2022/10/05.
//

import SwiftUI

/*
 「ObservedObject」属性は自作クラスの変更通知を受け取るために必要
 これはSwiftUIが提供するproperty wrapper
 property wrapperは他にも以下のようなものがあります。
 @State
 @Binding
 @Environment
 @EnvironmentObject
 「viewModel.fetchWeahterForecast()」の箇所でサーバから天気予報情報を取得
 */

struct ContentView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Button {
                viewModel.fetchWeatheForecast()
            } label: {
                Text("取得")
                    .frame(width: 60, height: 32)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            Text(viewModel.address)
            Spacer()
            List {
                ForEach(0..<viewModel.weathers.count, id: \.self) {
                    WeatherRow(weather: viewModel.weathers[$0])
                }
            }
        }
        .padding()
    }
}

struct WeatherRow: View {
    
    var weather: Weather
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(weather.time)時")
                .font(.title)
            Text("天気: " + weather.weatherType.toString())
            Text("降水確率: \(weather.rainyPercent)%")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeatherViewModel())
    }
}
