//
//  ApiClient.swift
//  SampleWeatherSwiftUI
//
//  Created by mtanaka on 2022/10/05.
// サーバAPIにリクエストするためのクライアント

import Foundation
import Combine

/*
 URLSessionにはCombineを利用できるようにメソッドが用意されている　「dataTaskPublisher」
 dataTaskPublisherが返すPublisherは「(data: Data, response: URLResponse)」のタプル型のデータを送信してきますので、それをmapで受信データのみを取り出している
 変換したデータを受け取るスレッドを「receive」メソッド(RxSwiftであればObserverOnのようなもの)で設定して、最後に型消去を行い、汎用的なPublisherに変換するために「eraseToAnyPublisher」を使用
 「eraseToAnyPublisher」で抽象化することで扱いやすくしている
 */

final class ApiClient {
    
    private static let contentType = "application/json"
    private static let decoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    static func request<T, V>(_ request: T) -> AnyPublisher<V, Error> where T:BaseRequest, V:Codable, T.ResponseType == V {
        let urlRequest = try! request.asURLRequest()
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .map({ $0.data })
            .decode(type: V.self, decoder: ApiClient.decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
