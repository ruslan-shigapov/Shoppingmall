//
//  OnboardingScrollView.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 03.08.2024.
//

import UIKit

final class OnboardingScrollView: UIScrollView {
    
    // MARK: Views
    private let firstPageView = OnboardingPageView(
        color: .deepBlue,
        title: Constants.Texts.firstPageTitle,
        currentPage: 0)
    private let secondPageView = OnboardingPageView(
        color: .milkyPink,
        title: Constants.Texts.secondPageTitle,
        currentPage: 1)
    private let thirdPageView = OnboardingPageView(
        color: .deepBlue,
        title: Constants.Texts.thirdPageTitle,
        currentPage: 2,
        description: Constants.Texts.thirdPageDescription,
        primaryButtonTitle: Constants.Texts.ButtonTitles.allow,
        secondaryButtonTitle: Constants.Texts.ButtonTitles.later)
    private let fourthPageView = OnboardingPageView(
        color: .smokyBlack,
        title: Constants.Texts.fourthPageTitle,
        currentPage: 3,
        description: Constants.Texts.fourthPageDescription,
        primaryButtonTitle: Constants.Texts.ButtonTitles.register,
        secondaryButtonTitle: Constants.Texts.ButtonTitles.alreadyRegistered)

    // MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setupPages()
    }
    
    // MARK: Private Methods 
    private func setupUI() {
        showsHorizontalScrollIndicator = false
        isPagingEnabled = true
    }
    
    private func setupPages() {
        let pageViews = [
            firstPageView,
            secondPageView,
            thirdPageView,
            fourthPageView
        ]
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
