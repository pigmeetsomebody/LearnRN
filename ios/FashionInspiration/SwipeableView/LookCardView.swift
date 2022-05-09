//
//  LookCardView.swift
//  FashionInspiration
//
//  Created by 朱彦谕 on 2022/4/23.
//

import UIKit
import SnapKit
import SDWebImage

class LookCardView: UIView {
    struct UIConst {
        static let leftMargin: CGFloat = 32
        static let avatarWidth: CGFloat = 66
        static let itemPadding: CGFloat = 8
        static let cornerRadius: CGFloat = 18
    }
    
    private let lookImageView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.contentMode = .scaleAspectFit
        imgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imgView.layer.cornerRadius = UIConst.cornerRadius
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private let avatarImageView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.contentMode = .center
        imgView.layer.cornerRadius = UIConst.avatarWidth / 2
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.black.withAlphaComponent(0.9)
        return label
    }()
   
    private let hashTagsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        return label
    }()
    
    private let maskLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    
    private func setupMaskShapeLayer() {
        maskLayer.frame = bounds
        maskLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: UIConst.cornerRadius).cgPath
        maskLayer.fillColor = UIColor.white.cgColor
        maskLayer.shadowPath = maskLayer.path
        maskLayer.shadowOffset = CGSize(width: 0, height: 16)
        maskLayer.shadowRadius = 30
        maskLayer.shadowOpacity = 1
        maskLayer.shadowColor = UIColor(white: 0, alpha: 0.04).cgColor
    }
    
    class func photoSize() -> CGSize {
        let width = UIScreen.main.bounds.size.width - UIConst.leftMargin * 2
        let height = width * 16 / 9
        return CGSize(width: width, height: height)
    }
    
    class func lookCardSize() -> CGSize {
        let photoHeight = photoSize().height
        let photoWidth = photoSize().width
        let contentHeight = photoHeight + UIConst.avatarWidth + UIConst.itemPadding * 2
        return CGSize(width: photoWidth, height: contentHeight)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMaskShapeLayer()
        layer.addSublayer(maskLayer)
        addSubview(lookImageView)
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        addSubview(hashTagsLabel)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var lookModel: LookModel? {
        didSet {
            guard let lookModel = lookModel else {
                return
            }
            configContent(look: lookModel)
        }
    }
    
    func commonInit() {
        lookImageView.snp.makeConstraints { make in
            make.size.equalTo(LookCardView.photoSize())
            make.top.leading.equalTo(self)
        }
        avatarImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: UIConst.avatarWidth, height: UIConst.avatarWidth))
            make.top.equalTo(lookImageView.snp.bottom).offset(8)
            make.leading.equalTo(lookImageView.snp.leading).offset(8)
        }
        usernameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(8)
            make.top.equalTo(avatarImageView.snp.top).offset(8)
            make.height.equalTo(usernameLabel.font.lineHeight)
        }
        
        hashTagsLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(8)
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
            make.height.equalTo(hashTagsLabel.font.lineHeight)
        }
        
    }
    
    func configContent(look: LookModel) {
        lookImageView.sd_setImage(with: URL(string: look.lookPhoto), completed: nil)
        avatarImageView.sd_setImage(with: URL(string: (look.userInfo?.avatar ?? "")), completed: nil)
        usernameLabel.text = look.userInfo?.username
        var tags: String = ""
        hashTagsLabel.text = "This is a discription"
        guard let hashTags = look.hashTags else { return }
        for i in 0..<hashTags.count {
            if i > 3 {
                break
            }
            tags += (hashTags[i] + "")
        }
    }

}


extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        
        self.init(
            red: CGFloat((hex >> 16) & 0xFF),
            green: CGFloat((hex >> 8) & 0xFF),
            blue: CGFloat(hex & 0xFF), alpha: alpha)
    }
}
