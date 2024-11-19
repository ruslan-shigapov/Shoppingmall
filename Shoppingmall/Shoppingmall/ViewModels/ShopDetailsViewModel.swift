//
//  ShopDetailsViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 07.09.2024.
//

import UIKit
import Combine

protocol ShopDetailsViewModelProtocol: BlockCellViewModelDelegate {
    var wasEmptyBlockDetected: (() -> Void)? { get set }
    var title: String { get }
    var imagePublisher: AnyPublisher<UIImage?, Never> { get }
    var floor: String { get }
    var website: String { get }
    var description: String { get }
    func fetchShopDetails(completion: @escaping () -> Void)
    func getNumberOfRows() -> Int
    func getBlockCellViewModel() -> BlockCellViewModelProtocol
}

final class ShopDetailsViewModel: ShopDetailsViewModelProtocol {
    
    private let shop: Shop
    
    private var detailedShop: Shop?
    
    private var subscription: AnyCancellable?
    
    @Published private var logoImage: UIImage?
        
    var wasEmptyBlockDetected: (() -> Void)?
        
    var title: String {
        shop.name
    }
    
    var imagePublisher: AnyPublisher<UIImage?, Never> {
        $logoImage.eraseToAnyPublisher()
    }
    
    var floor: String {
        guard let floor = detailedShop?.floor else { return "" }
        return "\(floor) этаж"
    }
    
    var website: String {
        detailedShop?.siteUrl ?? ""
    }
    
    var description: String {
        guard let description = detailedShop?.description else { return "" }
        return description.replacingOccurrences(
            of: "<[^>]*>",
            with: "",
            options: .regularExpression)
    }
    
    init(shop: Shop) {
        self.shop = shop
    }
    
    private func loadImage() {
        subscription?.cancel()
        guard let url = URL(string: shop.logoUrl) else { return }
        subscription = NetworkManager.shared.publishImage(byUrl: url)
            .receive(on: DispatchQueue.main)
            .catch {
                print($0)
                return Just<UIImage?>(nil)
            }
            .assign(to: \.logoImage, on: self)
    }
    
    func fetchShopDetails(completion: @escaping () -> Void) {
        subscription?.cancel()
        subscription = NetworkManager.shared.publishShopDetails(byId: shop.id)
            .receive(on: DispatchQueue.main)
            .sink {
                switch $0 {
                case .finished: break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] in
                guard let self else { return }
                detailedShop = $0
                loadImage()
                completion()
            }
    }
    
    func getNumberOfRows() -> Int {
        1
    }
    
    func getBlockCellViewModel() -> BlockCellViewModelProtocol {
        let viewModel = BlockCellViewModel(
            blockTitle: Constants.Texts.BlockTitles.offers,
            shopId: detailedShop?.id ?? "")
        viewModel.delegate = self as BlockCellViewModelDelegate
        return viewModel
    }
    
    func removeEmptyBlock(title: Constants.Texts.BlockTitles) {
        if title == Constants.Texts.BlockTitles.offers {
            wasEmptyBlockDetected?()
        }
    }
}
