//
//  NetworkManager.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 03.08.2024.
//

import UIKit
import Combine

private enum Path: String {
    case base = "https://skillbox.dev.instadev.net/api/v1"
    case mobileDevice = "/mobile-device"
    case news = "/news/with/promotions"
    case services = "/shops/category/slug/services/"
    case events = "/events"
    case categories = "/categories"
    case shops = "/shops/category/slug/"
    case shopDetails = "/shops/"
    case offers = "/promotions"
}

enum NetworkError: Error {
    case parsingFailure(error: Error)
    case unknownError(_ error: Error)
    case invalidResponse
    case noData
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private var subscription: AnyCancellable?
    
    private var mobileDeviceId: String? {
        UserDefaults.standard.string(forKey: "mobileDeviceId")
    }
    
    private var imageCache = NSCache<NSURL, UIImage>()
    
    private init() {}
    
    private func publish<T: Decodable>(
        _ request: URLRequest
    ) -> AnyPublisher<T, NetworkError> {
        URLSession.shared.dataTaskPublisher(for: request)
            .mapError { NetworkError.unknownError($0) }
            .tryMap {
                guard let httpResponse = $0.response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.invalidResponse
                }
                guard !$0.data.isEmpty else {
                    throw NetworkError.noData
                }
                return $0.data
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { NetworkError.parsingFailure(error: $0) }
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    private func publishMobileDeviceId(
        by jsonData: [String: Any]
    ) -> AnyPublisher<String, NetworkError> {
        let url = URL(string: Path.base.rawValue + Path.mobileDevice.rawValue)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(
                withJSONObject: jsonData)
        } catch {
            return Fail(error: NetworkError.parsingFailure(error: error))
                .eraseToAnyPublisher()
        }
        return publish(request)
            .map { (mobileDevice: MobileDevice) in
                mobileDevice.id
            }
            .eraseToAnyPublisher()
    }
    
    func setupMobileDeviceId() {
        guard mobileDeviceId == nil else { return }
        let timestamp = Date().timeIntervalSince1970
        let jsonData: [String: Any] = [
            "install_app": Int(timestamp),
            "os": "iOS",
            "version_os": UIDevice.current.systemVersion,
            "model": UIDevice.current.model
        ]
        subscription = publishMobileDeviceId(by: jsonData)
            .sink {
                switch $0 {
                case .finished: break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: {
                UserDefaults.standard.setValue($0, forKey: "mobileDeviceId")
            }
    }
    
    func publishCards(
        forBlock blockTitle: Constants.Texts.BlockTitles,
        shopId: String
    ) -> AnyPublisher<[Card], NetworkError> {
        let extraPath = switch blockTitle {
        case .news: Path.news.rawValue
        case .offers: Path.shopDetails.rawValue + shopId + Path.offers.rawValue
        case .usefulInfo: Path.services.rawValue
        case .events: Path.events.rawValue
        }
        var urlComponents = URLComponents(
            string: Path.base.rawValue + extraPath)
        let queryItemName = blockTitle == .news ? "on_main" : "on_home"
        urlComponents?.queryItems = [
            URLQueryItem(name: queryItemName, value: "true")
        ]
        guard let url = urlComponents?.url else {
            return Just([])
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        return publish(URLRequest(url: url))
    }
    
    func publishImage(
        byUrl url: URL
    ) -> AnyPublisher<UIImage?, NetworkError> {
        if let cachedImage = imageCache.object(forKey: url as NSURL) {
            return Just(cachedImage)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap {
                guard let image = UIImage(data: $0.data) else {
                    throw NetworkError.noData
                }
                return image
            }
            .mapError { NetworkError.unknownError($0) }
            .retry(2)
            .handleEvents(receiveOutput:  { [weak self] in
                if let self, let image = $0 {
                    self.imageCache.setObject(image, forKey: url as NSURL)
                }
            })
            .eraseToAnyPublisher()
    }
    
    func publishCategories() -> AnyPublisher<[Category], NetworkError> {
        let url = URL(string: Path.base.rawValue + Path.categories.rawValue)!
        return publish(URLRequest(url: url))
    }
    
    func publishShops(
        for category: String
    ) -> AnyPublisher<[Shop], NetworkError> {
        let path = Path.base.rawValue + Path.shops.rawValue + category
        let url = URL(string: path)!
        return publish(URLRequest(url: url))
    }
    
    func publishShopDetails(
        byId id: String
    ) -> AnyPublisher<Shop, NetworkError> {
        let path = Path.base.rawValue + Path.shopDetails.rawValue + id
        let url = URL(string: path)!
        return publish(URLRequest(url: url))
    }
}
