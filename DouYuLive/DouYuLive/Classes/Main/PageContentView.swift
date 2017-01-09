//
//  PageContentView.swift
//  DouYuLive
//
//  Created by wujian on 2017/1/6.
//  Copyright © 2017年 wujian. All rights reserved.
//

import UIKit

class PageContentView: UIView {
    
    private var childVCs :[UIViewController]
    private var parentVC : UIViewController
    
    init(frame: CGRect, childVCs: [UIViewController], parentVC: UIViewController) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
