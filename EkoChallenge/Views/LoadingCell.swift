//
//  LoadingCell.swift
//  EkoChallenge
//
//  Created by Azis Senoaji Prasetyotomo on 05/10/17.
//  Copyright © 2017 Azis Senoaji Prasetyotomo. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {

    lazy var activityView = self.makeActivityView()
    func makeActivityView() -> UIActivityIndicatorView {
        let vw = UIActivityIndicatorView()
        vw.color = .black
        vw.frame.size = CGSize(width: 20, height: 20)
        vw.frame.origin = CGPoint(x: screenBounds.width / 2 - 10, y: 15)
        return vw
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(activityView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        activityView.startAnimating()
    }

}
