//
//  BaseCoordinator.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 26.01.2024.
//

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var didFinish: (() -> Void)? { get set }
    func start()
}

extension Coordinator {
    
    func add(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func remove(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

class BaseCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var didFinish: (() -> Void)? = nil
    
    func start() {
        fatalError("Child should implement func start")
    }
}
