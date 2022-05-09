//
//  HomeLooksViewController.swift
//  FashionInspiration
//
//  Created by 朱彦谕 on 2022/4/22.
//

import UIKit
import RealmSwift
import SnapKit

class HomeLooksViewController: UIViewController {

    private var looksData: Results<LookModel>?
    private var lookIndex = 0
    private let looksVM = LookViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        looksVM.dataArray.bind { [weak self] looks in
            guard let self = self else { return }
            self.looksData = looks
            self.setupLookSwipeableView()
            self.lookIndex = 0
            self.swipeableView.discardViews()
            self.swipeableView.loadViews()
            
        }
        looksVM.fetchDataFromLocalDBOrServer(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard swipeableView.superview != nil else {
            return
        }
        swipeableView.nextView = {
            return self.nextLookCardView()
        }
    }
    
    private let swipeableView = ZLSwipeableView()

    private func setupLookSwipeableView() {
        if swipeableView.superview != nil {
            return
        }
        swipeableView.allowedDirection = [.Left, .Right]
        view.addSubview(swipeableView)
        swipeableView.didSwipe = { [weak self] (view, direction, vector) in
            guard let self = self else { return }
            self.updateBackgroundImage()
        }
//        let tabOptions: NSVAnimatedTabOptions = DefaultAnimatedTabOptions()
//        let tabHeght = tabOptions.tabHeight
//        let leftInset: CGFloat = 50
//        let bottomInset: CGFloat = 16
//        let topInset: CGFloat = 88
//        let swipeableViewHeight = UIScreen.main.bounds.size.height - topInset - bottomInset - tabHeght
        swipeableView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view)
            make.size.equalTo(LookCardView.lookCardSize())
        }
    }
    
    private func nextLookCardView() -> UIView? {
        guard let looksData = looksData, lookIndex < looksData.count else {
            return nil
        }
//        let containerView = UIView(frame: swipeableView.bounds)
        let lookView = LookCardView(frame: swipeableView.bounds)
//        containerView.backgroundColor = .red
        let look = looksData[lookIndex]
        lookView.tag = lookIndex
        lookView.lookModel = look
        lookIndex += 1
//        containerView.addSubview(lookView)
//        lookView.snp.makeConstraints { make in
//            make.top.leading.bottom.trailing.equalTo(containerView)
//        }
        return lookView
    }
    
    private func updateBackgroundImage() {
        
    }

}
