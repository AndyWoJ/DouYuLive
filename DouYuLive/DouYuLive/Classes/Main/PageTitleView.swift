//
//  PageTitleView.swift
//  DouYuLive
//
//  Created by wujian on 2017/1/5.
//  Copyright © 2017年 wujian. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index : Int)
}

private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectedColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)

private let kScrollLineH : CGFloat = 2 // 滚动指示线
private var currentIndex : Int = 0
class PageTitleView: UIView {
    
    var titles :[String]
    lazy var titleLables : [UILabel] = [UILabel]()
    weak var delegate : PageTitleViewDelegate?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor =  UIColor(R: kSelectedColor.0, G: kSelectedColor.1, B: kSelectedColor.2)
        return scrollLine
    }()
    
    //MARK - 自定义构造函数，必须重写initWithCoder函数
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
    fileprivate func setUpTitleLabels(){
        let labelW :CGFloat = frame.width / CGFloat(titles.count)
        let labelH :CGFloat = frame.height - kScrollLineH
        let labelY :CGFloat = 0
        
        for(index,title)  in titles.enumerated() {
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(R: kNormalColor.0, G: kNormalColor.1, B: kNormalColor.2)
            label.textAlignment = .center
            
            
            let labelX :CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            
            titleLables.append(label)
            
            //MARK :给label添加手势
            label.isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self, action: #selector(titleLabelClicked))
            label.addGestureRecognizer(gesture)
        }
    }
    fileprivate func setUpTitleBottomLineAndScrollLine(){
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let bottomLineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height-bottomLineH, width: frame.width, height: bottomLineH)
        addSubview(bottomLine) //直接加到当前view中
        
        guard let firstLabel = titleLables.first else{return}
        firstLabel.textColor = UIColor(R: kSelectedColor.0, G: kSelectedColor.1, B: kSelectedColor.2)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        
    }
}
//MARK : label的点击手势监听
extension PageTitleView{
    @objc func titleLabelClicked(_ tapGesture:UITapGestureRecognizer){
        //MARK : 拿到当前点击的label
        guard let currentLabel = tapGesture.view as? UILabel else {return}
        
        let preLabel = titleLables[currentIndex]
        
        preLabel.textColor = UIColor.darkGray
        currentLabel.textColor = UIColor(R: kSelectedColor.0, G: kSelectedColor.1, B: kSelectedColor.2)
        
        currentIndex = currentLabel.tag
        
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.2) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}
//MARK : 对外暴露的方法
extension PageTitleView{
     func setTitleViewWithProgress(_ progress : CGFloat, sourceIndex : Int, targetIndex :Int){
        //1.取出
        let sourceLabel = titleLables[sourceIndex]
        let targetLabel = titleLables[targetIndex]
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //2.颜色的渐变
        let colorDelta = (kSelectedColor.0-kNormalColor.0,kSelectedColor.1-kNormalColor.1,kSelectedColor.2-kNormalColor.2)
        sourceLabel.textColor = UIColor(R: kSelectedColor.0-colorDelta.0*progress, G: kSelectedColor.1-colorDelta.1*progress, B: kSelectedColor.2-colorDelta.2*progress)
        
        targetLabel.textColor = UIColor(R: kNormalColor.0+colorDelta.0*progress, G: kNormalColor.1+colorDelta.1*progress, B: kNormalColor.2+colorDelta.2*progress)
        
        //3.更新currentIndex
        currentIndex = targetIndex
    }
}
