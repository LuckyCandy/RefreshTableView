//
//  RefreshView.swift
//  DRTableView
//
//  Created by DamonLi on 16/9/8.
//  Copyright © 2016年 Pioneer. All rights reserved.
//

import UIKit

private let DScenceHeight:CGFloat = 60;

protocol RefreshViewDelegate:class {
    func refreshViewStartLoading(refreshView:RefreshView)
}

class RefreshView: UIView , UIScrollViewDelegate{
    
    fileprivate unowned var scrollView:UIScrollView
    
    fileprivate var progress :CGFloat = 0.0
    
    fileprivate var tipArrow:UIImageView!   //操作提示箭头
    fileprivate var tipLabel:UILabel!            //操作提示语
    fileprivate var timeLabel:UILabel!         //时间提示
    fileprivate var loadingView:UIActivityIndicatorView!
    
    private var isLoading:Bool = false       //是否正在加载网络数据
    
    var delegate:RefreshViewDelegate?
    
    init(frame: CGRect,scrollView:UIScrollView) {
        self.scrollView = scrollView
        super.init(frame: frame)
        backgroundColor = UIColor.lightGray
        initRefreshItems()
        updateViewByProgress()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let refreshVisableHeight = max(0,-scrollView.contentOffset.y - scrollView.contentInset.top)
        progress = min(1,refreshVisableHeight/DRefreshViewHeight)
        //根据进度改变refeshView
        updateViewByProgress()
    }
    
    //根据下拉进度更新显示
    private func updateViewByProgress(){
        if(isLoading){
            return
        }
        if(progress >= 0.4){
            tipArrow.image = UIImage(named: "releaseArrow")
            tipLabel.text = "松开刷新"
        }else{
            tipArrow.image = UIImage(named: "pullArrow");
            tipLabel.text = "下拉刷新"
        }
    }
    
    //初始化刷新显示控件
    private func initRefreshItems(){
        tipArrow = UIImageView(frame: CGRect(x: 30, y: 150, width: 30, height: 30))
        tipArrow.image = UIImage(named: "pullArrow");
        tipLabel = UILabel(frame: CGRect(x: 60, y: 150, width: 200, height: 15))
        tipLabel.font = UIFont.systemFont(ofSize: 14.0)
        tipLabel.text = "下拉刷新"
        tipLabel.font = UIFont.systemFont(ofSize: 12)
        tipLabel.textAlignment = .center
        timeLabel = UILabel(frame: CGRect(x: 60, y: 175, width: 200, height: 15))
        timeLabel.font = UIFont.systemFont(ofSize: 14.0)
        timeLabel.text = "上次更新时间: 暂无"
        timeLabel.textColor = UIColor.gray
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont.systemFont(ofSize: 11)
        loadingView = UIActivityIndicatorView(frame: CGRect(x: 30, y: 160, width: 20, height: 20))
        loadingView.activityIndicatorViewStyle = .whiteLarge
        loadingView.hidesWhenStopped = true
        loadingView.stopAnimating()
        addSubview(tipArrow)
        addSubview(tipLabel)
        addSubview(timeLabel)
        addSubview(loadingView)
    }
    
    //用户拖动结束后调用
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if !isLoading && progress >= 0.4{
            startLoading()
            delegate?.refreshViewStartLoading(refreshView: self)
        }
    }
    
    //开始加载网络数据
    private func startLoading(){
        isLoading = true
        tipArrow.isHidden = true
        loadingView.startAnimating()
        tipLabel.text = "正在加载..."
        print("开始时的top:\(self.scrollView.contentInset.top),\(self.scrollView.contentOffset.y)")
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {() -> Void in
            self.scrollView.contentInset.top = 60
            //self.scrollView.contentOffset.y = -DScenceHeight
            }, completion: nil)
    }
    
    //结束加载网络数据
    func endLoading(){
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {() -> Void in
            self.scrollView.contentInset.top = 0
        }) { (Bool) -> Void in
            self.loadingView.stopAnimating()
            self.lastUpdateTime()
            self.isLoading = false
            self.tipArrow.isHidden = false
            self.tipLabel.text = "下拉刷新"
        }
    }
    
    //显示最后一次刷新时间
    private func lastUpdateTime(){
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        timeLabel.text = "上次更新时间: \(dateFormatter.string(from: Date()))"
    }
}
