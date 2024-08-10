//
//  NetworkManager.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 03.08.2024.
//

import UIKit

private enum Path: String {
    case base = "https://skillbox.dev.instadev.net/api/v1"
    case mobileDevice = "/mobile-device"
    case news = "/news/with/promotions-and-event"
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
    
    private func fetchMobileDeviceId(
        by jsonData: [String: Any],
        retryCount: Int = 2,
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
        URLSession.shared.dataTask(
            with: request
        ) { [weak self] data, response, error in
            guard let self else { return }
            if let error {
                if retryCount > 0 {
                    fetchMobileDeviceId(
                        by: jsonData,
                        retryCount: retryCount - 1,
                        completion: completion)
                } else {
                    completion(.failure(.unknownError(error)))
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                if retryCount > 0 {
                    fetchMobileDeviceId(
                        by: jsonData,
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
                let mobileDevice = try decoder.decode(
                    MobileDevice.self,
                    from: data)
                completion(.success(mobileDevice.id))
            } catch {
                completion(.failure(.parsingFailure(error: error)))
            }
        }.resume()
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
}
