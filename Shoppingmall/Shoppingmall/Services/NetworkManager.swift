//
//  NetworkManager.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 26.01.2024.
//

import UIKit

enum NetworkError: Error {
    case noData
    case decodingError
}

private enum Path: String {
    case base = "https://skillbox.dev.instadev.net/api/v1"
    case mobileDevice = "/mobile-device"
}

final class NetworkManager {
    
    static let shared = NetworkManager()
        
    private var deviceId: String? {
        UserDefaults.standard.string(forKey: "deviceId")
    }
    
    private init() {}
    
    func setupDeviceId() {
        guard deviceId == nil else { return }
        
        let timestamp = Date().timeIntervalSince1970
        let jsonData: [String: Any] = [
            "install_app": Int(timestamp),
            "os": "iOS",
            "version_os": UIDevice.current.systemVersion,
            "model": UIDevice.current.model]
        
        getDeviceId(by: jsonData) { result in
            switch result {
            case .success(let deviceId):
                UserDefaults.standard.set(deviceId, forKey: "deviceId")
                print(deviceId)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getDeviceId(
        by jsonData: [String: Any],
        completion: @escaping (Result<Any, NetworkError>) -> Void
    ) {
        let url = URL(string: Path.base.rawValue + Path.mobileDevice.rawValue)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: jsonData)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let device = try decoder.decode(MobileDevice.self, from: data)
                completion(.success(device.id))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
