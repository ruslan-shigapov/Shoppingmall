//
//  NetworkManager.swift
//  Shoppingmall
//
//  Created by Руслан Шигапов on 01.11.2023.
//

import UIKit
import Combine

private enum Path: String {
    case base = "https://skillbox.dev.instadev.net/api/v1"
    case mobileDevice = "/mobile-device"
}

enum NetworkError: Error {

}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private var subscription: AnyCancellable? = nil
        
    private var deviceId: String? {
        UserDefaults.standard.string(forKey: "deviceId")
    }
    
    var isFirstLaunching: Bool {
        deviceId == nil
    }
                
    private init() {}
    
    /// Запрос для добавления мобильного устройства в систему
    func setupDeviceId() {
        guard isFirstLaunching else { return }
        let url = URL(string: Path.base.rawValue + Path.mobileDevice.rawValue)!
        
        /// Время первого запуска приложения в формате timestamp
        let timestamp = Date().timeIntervalSince1970
        
        /// Объект в формате JSON для отправки в теле запроса
        let json: [String: Any] = [
            "install_app": Int(timestamp),
            "os": "iOS",
            "version_os": UIDevice.current.systemVersion,
            "model": UIDevice.current.model
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("text/plain", forHTTPHeaderField: "accept")
        request.httpBody = try? JSONSerialization.data(withJSONObject: json)
        
        subscription = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap {
                guard let httpResponse = $0.response as? HTTPURLResponse else {
                    return $0.data
                }
                print(httpResponse.statusCode)
                return $0.data
            }
            .decode(type: MobileDevice.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    print("device ID received")
                case .failure(let error):
                    print("finished with error: \(error)")
                }
            } receiveValue: { /*[weak self] in*/
                UserDefaults.standard.set($0.id, forKey: "deviceId")
//                print(self?.deviceId)
            }
    }
}
