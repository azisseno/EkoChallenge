//
//  BaseHelper.swift
//  EkoChallenge
//
//  Created by Azis Senoaji Prasetyotomo on 05/10/17.
//  Copyright © 2017 Azis Senoaji Prasetyotomo. All rights reserved.
//

import UIKit

func debugPrint(_ items: Any...) {
    #if DEBUG
        print(items)
    #endif
}

var screenBounds: CGRect {
    return UIScreen.main.bounds
}
