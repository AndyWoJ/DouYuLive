//
//  UIColor-Extension.swift
//  DouYuLive
//
//  Created by wujian on 2017/1/9.
//  Copyright © 2017年 wujian. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(R: CGFloat, G: CGFloat, B: CGFloat) {
        self.init(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: 1.0)
    }
     
}
