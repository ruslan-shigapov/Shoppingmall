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
}

enum NetworkError: Error {
    case invalidURL
    case parsingFailure(error: Error)
    case unknownError(_ error: Error)
    case invalidResponse(_ statusCode: Int)
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
        completion: @escaping (Result<String, NetworkError>) -> Void
    ) {
        guard let url = URL(
            string: Path.base.rawValue + Path.mobileDevice.rawValue
        ) else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(
                withJSONObject: jsonData)
        } catch {
            completion(.failure(.parsingFailure(error: error)))
        }
        URLSession.shared.dataTask(
            with: request
        ) { [weak self] data, response, error in
            guard let self else { return }
            if let error {
                completion(.failure(.unknownError(error)))
                return
            }
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                switch statusCode {
                case 200:
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
                default:
                    completion(.failure(.invalidResponse(statusCode)))
                }
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
