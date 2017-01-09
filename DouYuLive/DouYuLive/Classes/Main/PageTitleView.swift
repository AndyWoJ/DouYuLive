//
//  PageTitleView.swift
//  DouYuLive
//
//  Created by wujian on 2017/1/5.
//  Copyright © 2017年 wujian. All rights reserved.
//

import UIKit

private let kScrollLineH : CGFloat = 2 // 滚动指示线

class PageTitleView: UIView {
    
    var titles :[String]
    lazy var titleLables : [UILabel] = [UILabel]()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor =  UIColor.orange
        return scrollLine
    }()
    
    //MARK - 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}

extension PageTitleView{
    func setupUI (){
        //1,添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2,添加Title对应的Label
        setUpTitleLabels()
        
        //3,设置底线和滑动块
        setUpTitleBottomLineAndScrollLine()
    }
    private func setUpTitleLabels(){
        let labelW :CGFloat = frame.width / CGFloat(titles.count)
        let labelH :CGFloat = frame.height - kScrollLineH
        let labelY :CGFloat = 0
        
        for(index,title)  in titles.enumerated() {
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            
            let labelX :CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            
            titleLables.append(label)
        }
    }
    private func setUpTitleBottomLineAndScrollLine(){
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let bottomLineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height-bottomLineH, width: frame.width, height: bottomLineH)
        addSubview(bottomLine)
        
        guard let firstLabel = titleLables.first else{return}
        firstLabel.textColor = UIColor.orange
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        
    }
}
