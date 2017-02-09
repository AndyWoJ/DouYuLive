//
//  HomeViewController.swift
//  DouYuLive
//
//  Created by wujian on 2017/1/4.
//  Copyright © 2017年 wujian. All rights reserved.
//

import UIKit

private let kTitleViewH = 40.0

class HomeViewController: UIViewController {

    //MARK: 懒加载pageTitleView
    lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleViewFrame = CGRect(x: 0.0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleViewFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    lazy var pageContentView :PageContentView = {[weak self] in
        
        let contentY = kStatusBarH + kNavigationBarH + kTitleViewH
        let contentH = kScreenH - contentY - kTabBarH
        let contentFrame = CGRect(x: 0, y: contentY, width: kScreenW, height: contentH)
        
        // all child viewControllers
        var childViewControlls = [UIViewController]()
        childViewControlls.append(RecommendViewController())
        for _ in 0..<3{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(R: CGFloat(arc4random_uniform(255)), G: CGFloat(arc4random_uniform(255)), B: CGFloat(arc4random_uniform(255)))
            childViewControlls.append(vc)
        }
       
        
        let contentView = PageContentView(frame: contentFrame, childVCs: childViewControlls, parentVC: self)
        contentView.delegate = self
        return contentView
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
        
        //3,添加pageContentView
        view.addSubview(pageContentView)
        
    }
    fileprivate func setupNavigationBar(){
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
//MARK : 遵守PageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate{
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}
//MARK : 遵守PageContentViewDelegate
extension HomeViewController : PageContentViewDelegate{
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleViewWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
