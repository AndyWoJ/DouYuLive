//
//  HomeViewController.swift
//  DouYuLive
//
//  Created by wujian on 2017/1/4.
//  Copyright © 2017年 wujian. All rights reserved.
//

import UIKit

private let titleHeight = 40.0

class HomeViewController: UIViewController {

    lazy var pageTitleView : PageTitleView = {
        let titleViewFrame = CGRect(x: 0.0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: titleHeight)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleViewFrame, titles: titles)
        return titleView
    }()
    lazy var pageContentView :PageContentView = {
        
        let contentFrame = CGRect(x: 0, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        
        let contentView = PageContentView(frame: contentFrame, childVCs: <#T##[UIViewController]#>, parentVC: <#T##UIViewController#>)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK - 设置UI界面
extension HomeViewController{
    func setupUI(){
        //0,不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //1,设置导航栏
        setupNavigationBar()
        
        //2,添加titleView 
        view.addSubview(pageTitleView)
    }
    private func setupNavigationBar(){
        let leftButton = UIButton()
        leftButton.setImage(UIImage(named:"logo"), for: .normal)
        leftButton.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")//UIBarButtonItem(customView: leftButton)
        
        let size = CGSize(width: 44, height: 44)
        let QRCodeItem = UIBarButtonItem(imageName: "Image_scan", highlighted: "Image_scan_clicked", size: size)//UIBarButtonItem(customView:CreatedCustomView(name: "Image_scan"))
        let searchItem = UIBarButtonItem(imageName: "btn_search", highlighted: "btn_search_clicked", size: size)//UIBarButtonItem(customView:CreatedCustomView(name: "btn_search"))
        let historyItem = UIBarButtonItem(imageName: "Image_my_history", highlighted: "Image_my_history_clicked", size: size)//UIBarButtonItem(customView:CreatedCustomView(name: "Image_my_history"))
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,QRCodeItem]
    }
    /*
    private func CreatedCustomView(name:String) -> UIView{
        let button = UIButton()
        let clickedName = name + "_clicked"
        let size = CGSize(width: 44, height: 44)
        button.setImage(UIImage(named:name), for: .normal)
        button.setImage(UIImage(named:clickedName), for: .highlighted)
        button.frame = CGRect(origin:CGPoint(), size: size)
        return button
    }
     */
    
}

