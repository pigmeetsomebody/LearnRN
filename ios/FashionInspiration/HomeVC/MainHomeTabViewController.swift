//
//  MainHomeTabViewController.swift
//  FashionInspiration
//
//  Created by 朱彦谕 on 2022/4/22.
//

import UIKit

class MainHomeTabViewController: UIViewController {

    
    
    enum TabControllerInfo {
        case looks(String)
        case categorys(String)
    }

    let mainTabController = NSVAnimatedTabController()
    let containerStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.contentMode = .scaleToFill
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
                
        setNeedsStatusBarAppearanceUpdate()
        
        modalPresentationStyle = .fullScreen
        
        view.tintAdjustmentMode = .normal
        mainTabController.delegate = self
        config(tabControllerInfos: [.looks("Looks"), .categorys("Categorys")])
        view.addSubview(containerStackView)
        containerStackView.addArrangedSubview(mainTabController.view)
        addChild(mainTabController)
        
    }
    
    override func viewDidLayoutSubviews() {
        containerStackView.frame = view.bounds
    }

    
    func config(tabControllerInfos: [TabControllerInfo]) {
        var tabControllers: [UIViewController] = []
        var tabOptions: NSVAnimatedTabOptions = DefaultAnimatedTabOptions()
        var options: [NSVTabItemOptions] = []
        for info in tabControllerInfos {
            switch info {
            case .looks(let string):
                let option = DefaultTabItemOptions(title: string, image: nil)
                options.append(option)
                let looksVC = HomeLooksViewController()
                tabControllers.append(looksVC)
            case .categorys(let string):
                let option = DefaultTabItemOptions(title: string, image: nil)
                options.append(option)
                let categorysVC = HomeCategorysViewController()
                tabControllers.append(categorysVC)
            }
        }
        tabOptions.options = options
        mainTabController.configure(tabControllers: tabControllers, with: tabOptions)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainHomeTabViewController: NSVAnimatedTabControllerDelegate {
    func shouldSelect(at index: Int, item: AnimatedTabItem, tabController: UIViewController) -> Bool {
        return true
    }
    
    func didSelect(at index: Int, item: AnimatedTabItem, tabController: UIViewController) {
        
    }
    
    func shouldSelect(at index: Int, item: CenterItemSubOptionItem) -> Bool {
        return true
    }
    
    func didSelect(at index: Int, item: CenterItemSubOptionItem) {
        
    }
    
    func shouldOpenSubOptions() -> Bool {
        return true
    }
}
