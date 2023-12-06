//
//  NetworkManager.swift
//  Shoppingmall
//
//  Created by Руслан Шигапов on 01.11.2023.
//

import UIKit

private enum Path: String {
    case base = "https://skillbox.dev.instadev.net/api/v1"
    case mobileDevice = "/mobile-device"
}

enum NetworkError: Error {
    case noData
    case decodingError
}

final class NetworkManager {
    
    static let shared = NetworkManager()
            
    private var deviceId: String? {
        UserDefaults.standard.string(
            forKey: UserDefaultsNamespace.shared.deviceIdKey
        )
    }
                
    private init() {}
    
    /// Установка идентификатора мобильного устройства
    func setupDeviceId() {
        guard deviceId == nil else { return }

        /// Время первого запуска приложения в формате timestamp
        let timestamp = Date().timeIntervalSince1970
        
        /// Данные в формате JSON для отправки в теле запроса
        let jsonData: [String: Any] = [
            "install_app": Int(timestamp),
            "os": "iOS",
            "version_os": UIDevice.current.systemVersion,
            "model": UIDevice.current.model
        ]
        
        getDeviceId(by: jsonData) { result in
            switch result {
            case .success(let deviceId):
                UserDefaults.standard.set(
                    deviceId,
                    forKey: UserDefaultsNamespace.shared.deviceIdKey
                )
                print(deviceId)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// Запрос для добавления устройства в систему
    func getDeviceId(
        by jsonData: [String: Any],
        completion: @escaping (Result<Any, NetworkError>) -> Void
    ) {
        let url = URL(string: Path.base.rawValue + Path.mobileDevice.rawValue)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: jsonData)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder() // TODO: вынести в свойство класса
                let device = try decoder.decode(MobileDevice.self, from: data)
                completion(.success(device.id))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
