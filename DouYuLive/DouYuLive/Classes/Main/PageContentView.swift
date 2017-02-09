//
//  PageContentView.swift
//  DouYuLive
//
//  Created by wujian on 2017/1/6.
//  Copyright © 2017年 wujian. All rights reserved.
//

import UIKit

private let ContentCellID = "ContentCellID"

protocol PageContentViewDelegate : class{
   func pageContentView(_ contentView:PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

class PageContentView: UIView {
    
    var childVCs :[UIViewController]
    weak var parentVC : UIViewController?
    var beginOffsetX : CGFloat = 0
    var isForbidScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    
    lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    //MARK : 自定义构造函数
    init(frame: CGRect, childVCs: [UIViewController], parentVC: UIViewController?) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame: frame)
        
        // 设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK : 设置UI界面
extension PageContentView {
    func setupUI(){
       //1.将所有子控制器添加到父控制器中
        for childVC in childVCs {
            parentVC?.addChildViewController(childVC)
        }
        
        //2.添加UICollectionView
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}
//MARK : 遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}
//MARK : 遵守UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false // 滚动需要执行代理方法
        beginOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbidScrollDelegate {return}
        
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > 0 {
            progress = (currentOffsetX / scrollViewW) - floor(currentOffsetX / scrollViewW)
            sourceIndex = Int(floor(currentOffsetX / scrollViewW))
            targetIndex = Int(ceil(currentOffsetX / scrollViewW))
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            if sourceIndex == targetIndex{
                progress = 1
            }
        }
        else{
            progress = ceil(currentOffsetX / scrollViewW) - (currentOffsetX / scrollViewW)
            sourceIndex = Int(ceil(currentOffsetX / scrollViewW))
            targetIndex = Int(floor(currentOffsetX / scrollViewW))
            if sourceIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
        }
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
//MARK : 对外暴露的方法
extension PageContentView{
    func setCurrentIndex(_ currentIndex : Int){
        isForbidScrollDelegate = true
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
    }

}

