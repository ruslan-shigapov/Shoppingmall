//
//  BigCardCellViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 24.11.2024.
//

import Combine
import UIKit

protocol BigCardCellViewModelProtocol {
    var title: String { get }
    var dates: String { get }
    var imagePublisher: AnyPublisher<UIImage?, Never> { get }
}

final class BigCardCellViewModel: BigCardCellViewModelProtocol {
    
    private let card: Card
    
    private var subscription: AnyCancellable?
    
    @Published private var image: UIImage?
    
    var title: String {
        card.title ?? card.name ?? ""
    }
    
    var dates: String {
        guard let dates = card.date,
              let startDate: TimeInterval = Double(dates.start),
              let finishDate: TimeInterval = Double(dates.finish) else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM"
        let formattedStartDate = dateFormatter.string(
            from: Date(timeIntervalSince1970: startDate))
        let formattedFinishDate = dateFormatter.string(
            from: Date(timeIntervalSince1970: finishDate))
        return "\(formattedStartDate) - \(formattedFinishDate)"
    }
    
    var imagePublisher: AnyPublisher<UIImage?, Never> {
        $image.eraseToAnyPublisher()
    }
    
    init(card: Card) {
        self.card = card
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self else { return }
            loadImage()
        }
    }
    
    private func loadImage() {
        guard let url = URL(string: card.logoUrl) else { return }
        subscription?.cancel()
        subscription = NetworkManager.shared.publishImage(byUrl: url)
            .receive(on: DispatchQueue.main)
            .catch {
                print($0)
                return Just<UIImage?>(nil)
            }
            .assign(to: \.image, on: self)
    }
}
