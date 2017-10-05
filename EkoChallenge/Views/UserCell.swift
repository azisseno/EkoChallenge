//
//  UserCell.swift
//  EkoChallenge
//
//  Created by Azis Senoaji Prasetyotomo on 05/10/17.
//  Copyright © 2017 Azis Senoaji Prasetyotomo. All rights reserved.
//

import UIKit
import MapleBacon

class UserCell: UITableViewCell {

    let margin: CGFloat = 10
    let favButtonSide: CGFloat = 40
    var favButtonClicked: ((FavoriteButtonView) -> ())?
    lazy var avatarImageView: UIImageView = self.makeAvatarImageView()
    lazy var loginLabel: UILabel = self.makeLoginLabel()
    lazy var htmlLabel: UILabel = self.makeHtmlLabel()
    lazy var typeLabel: UILabel = self.makeTypeLabel()
    lazy var siteAdminStatusLabel: UILabel = self.makeSiteAdminStatusLabel()
    lazy var favoriteButton: FavoriteButtonView = self.makeFavoriteButton()
    
    func makeAvatarImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.frame.size = CGSize(width: 80, height: 80)
        imageView.frame.origin = CGPoint(x: 10, y: 10)
        imageView.backgroundColor = .white
        return imageView
    }
    
    func makeFavoriteButton() -> FavoriteButtonView {
        let fvButton = FavoriteButtonView(frame: CGRect(x: screenBounds.width - favButtonSide - margin,
                                              y: (avatarImageView.height / 2)  + margin,
                                              width: favButtonSide,
                                              height: favButtonSide))
        fvButton.backgroundColor = .white
        return fvButton
    }
    
    func makeFavoriteIcon() -> UIImageView {
        let fvIcon = UIImageView(frame: CGRect(x: screenBounds.width - favButtonSide - margin,
                                              y: (avatarImageView.height / 2)  + margin,
                                              width: favButtonSide,
                                              height: favButtonSide))
        fvIcon.backgroundColor = .white
        fvIcon.contentMode = .scaleAspectFit
        return fvIcon
    }
    
    func makeLoginLabel() -> UILabel {
        let label = UILabel()
        label.frame.origin = CGPoint(x: avatarImageView.x + avatarImageView.width + margin,
                                     y: 20)
        label.frame.size = CGSize(width: screenBounds.width - label.x - ((margin + favButtonSide + margin)),
                                  height: 22)
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.backgroundColor = .white
        return label
    }
    
    func makeHtmlLabel() -> UILabel {
        let label = UILabel()
        label.frame.origin = CGPoint(x: avatarImageView.x + avatarImageView.width + margin,
                                     y: loginLabel.y + loginLabel.height + margin)
        label.frame.size = CGSize(width: screenBounds.width - label.x - (margin + favButtonSide + margin),
                                  height: 22)
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.backgroundColor = .white
        return label
    }
    
    func makeTypeLabel() -> UILabel {
        let label = UILabel()
        label.frame.origin = CGPoint(x: margin,
                                     y: avatarImageView.y + avatarImageView.height + margin)
        label.frame.size = CGSize(width: screenBounds.width - label.x - margin,
                                  height: 16)
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.backgroundColor = .white
        return label
    }
    
    func makeSiteAdminStatusLabel() -> UILabel {
        let label = UILabel()
        label.frame.origin = CGPoint(x: margin,
                                     y: typeLabel.y + typeLabel.height + margin)
        label.frame.size = CGSize(width: screenBounds.width - label.x - margin,
                                  height: 16)
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.backgroundColor = .white
        return label
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(avatarImageView)
        addSubview(loginLabel)
        addSubview(htmlLabel)
        addSubview(typeLabel)
        addSubview(siteAdminStatusLabel)
        addSubview(favoriteButton)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(user: User) {
        if let url = URL(string: user.avatarUrl) {
            avatarImageView.setImage(withUrl: url, placeholder: UIImage(named: "placeholder"), crossFadePlaceholder: true)
        }
        loginLabel.text = user.login
        typeLabel.text = user.type
        htmlLabel.text = user.htmlUrl
        siteAdminStatusLabel.text = "site admin: \(user.siteAdmin)"
        renderFavButton(userId: user.id)
    }
    
    private func renderFavButton(userId: String) {
        favoriteButton.image = #imageLiteral(resourceName: "fav_deactive")
        let isFav = CoreDataStack.isFavoritedUser(with: userId)
        if isFav {
            favoriteButton.isSelected = true
        } else {
            favoriteButton.isSelected = false
        }
        favoriteButton.addTarget(self, action: #selector(favButtonAction(_:)), for: .touchUpInside)
    }
    
    @objc private func favButtonAction(_ sender: FavoriteButtonView) {
        favButtonClicked?(sender)
    }
}
