//
//  SampleWeatherSwiftUIApp.swift
//  SampleWeatherSwiftUI
//
//  Created by mtanaka on 2022/10/05.
//

import SwiftUI

@main
struct SampleWeatherSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: WeatherViewModel())
        }
    }
}
