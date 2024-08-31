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
    case offers = "/offers"
    case services = "/shops/category/slug/services/"
    case events = "/events"
}

enum NetworkError: Error {
    case parsingFailure(error: Error)
    case unknownError(_ error: Error)
    case invalidResponse
    case noData
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let decoder = JSONDecoder()
    
    private var mobileDeviceId: String? {
        UserDefaults.standard.string(forKey: "mobileDeviceId")
    }
    
    private init() {}
    
    private func performRequest<T: Decodable>(
        _ request: URLRequest,
        retryCount: Int = 2,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        URLSession.shared.dataTask(
            with: request
        ) { [weak self] data, response, error in
            guard let self else { return }
            if let error {
                completion(.failure(.unknownError(error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                if retryCount > 0 {
                    performRequest(
                        request,
                        retryCount: retryCount - 1,
                        completion: completion)
                } else {
                    completion(.failure(.invalidResponse))
                }
                return
            }
            guard let data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decodedData = try decoder.decode(
                    T.self,
                    from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.parsingFailure(error: error)))
            }
        }.resume()
    }
    
    private func fetchMobileDeviceId(
        by jsonData: [String: Any],
        completion: @escaping (Result<String, NetworkError>) -> Void
    ) {
        let url = URL(string: Path.base.rawValue + Path.mobileDevice.rawValue)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(
                withJSONObject: jsonData)
        } catch {
            completion(.failure(.parsingFailure(error: error)))
            return
        }
        performRequest(
            request
        ) { (result: Result<MobileDevice, NetworkError>) in
            switch result {
            case .success(let mobileDevice):
                completion(.success(mobileDevice.id))
            case .failure(let error):
                completion(.failure(error))
            }
        }
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
        fetchMobileDeviceId(by: jsonData) { result in
            switch result {
            case .success(let mobileDeviceId):
                UserDefaults.standard.setValue(
                    mobileDeviceId,
                    forKey: "mobileDeviceId")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCards(
        forBlock blockTitle: Constants.Texts.BlockTitles,
        completion: @escaping (Result<[Card], NetworkError>) -> Void
    ) {
        let extraPath = switch blockTitle {
        case .news: Path.news.rawValue
        case .newOffers: Path.offers.rawValue
        case .usefulInfo: Path.services.rawValue
        case .events: Path.events.rawValue
        }
        var urlComponents = URLComponents(
            string: Path.base.rawValue + extraPath)
        let queryItemName = blockTitle == .news ? "on_main" : "on_home"
        urlComponents?.queryItems = [
            URLQueryItem(name: queryItemName, value: "true")
        ]
        guard let url = urlComponents?.url else { return }
        let request = URLRequest(url: url)
        performRequest(request) { (result: Result<[Card], NetworkError>) in
            switch result {
            case .success(let cards):
                DispatchQueue.main.async {
                    completion(.success(cards))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func imagePublisher(
        byUrl url: URL
    ) -> AnyPublisher<UIImage?, NetworkError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap {
                guard let image = UIImage(data: $0.data) else {
                    throw NetworkError.noData
                }
                return image
            }
            .mapError { NetworkError.unknownError($0) }
            .retry(1)
            .eraseToAnyPublisher()
    }
}
