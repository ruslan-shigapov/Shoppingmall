//
//  OnboardingScrollView.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 03.08.2024.
//

import UIKit

final class OnboardingScrollView: UIScrollView {
    
    private var pageViews: [OnboardingPageView] = []

    init(pageViews: [OnboardingPageView]) {
        self.pageViews = pageViews
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupPages()
    }
    
    private func setupUI() {
        showsHorizontalScrollIndicator = false
        isPagingEnabled = true
    }
    
    private func setupPages() {
        contentSize = CGSize(
            width: frame.width * CGFloat(pageViews.count),
            height: frame.height)
        for (index, pageView) in pageViews.enumerated() {
            pageView.frame = CGRect(
                x: frame.width * CGFloat(index),
                y: 0,
                width: frame.width,
                height: frame.height)
            addSubview(pageView)
        }
    }
}
