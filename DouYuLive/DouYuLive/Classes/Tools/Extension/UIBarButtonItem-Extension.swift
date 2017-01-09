//
//  UIBarButtonItem-Extension.swift
//  DouYuLive
//
//  Created by wujian on 2017/1/4.
//  Copyright © 2017年 wujian. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
   /* 
    class func createBarButtonItem(imageName:String, highlighted:String?, size:CGSize) -> UIBarButtonItem{
        let buttonItem = UIButton()
        buttonItem.setImage(UIImage(named:imageName), for: .normal)
        buttonItem.setImage(UIImage(named:highlighted!), for: .highlighted)
        buttonItem.frame = CGRect(origin: CGPoint(), size: size)
        
        return UIBarButtonItem(customView: buttonItem)
    }
    */
    
    //使用构造函数的方式实现向系统类中添加方法
    convenience init(imageName:String, highlighted: String = "", size: CGSize = CGSize()) {
        let buttonItem = UIButton()
        buttonItem.setImage(UIImage(named:imageName), for: .normal)
        if highlighted != ""{
            buttonItem.setImage(UIImage(named:highlighted), for: .highlighted)
        }
        if size != CGSize() {
            buttonItem.frame = CGRect(origin: CGPoint(), size: size)
        }else{
            buttonItem.sizeToFit()
        }

        self.init(customView:buttonItem)
    }
}
