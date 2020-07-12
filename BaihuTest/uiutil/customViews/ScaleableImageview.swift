//
//  ScaleableImageview.swift
//  BaihuTest
//
//  Created by liudong on 2020/7/12.
//  Copyright © 2020 liudong. All rights reserved.
//

import UIKit
import SnapKit

class ScaleableImageview: UIView,UIScrollViewDelegate {
    var scrollView:UIScrollView?
    var imageview:UIImageView
    var imageSrc:UIImage?
    @objc var tapDelegate:ScaleableImageViewTapped?
    
    override init(frame: CGRect) {
        scrollView = UIScrollView.init(frame: frame)
        scrollView!.minimumZoomScale = 1.0
        scrollView!.maximumZoomScale = 10.0
        scrollView!.contentSize = CGSize.init(width: frame.width, height: frame.height)
        
        imageview = UIImageView.init()
        super.init(frame: frame)
        scrollView!.delegate = self
        self.addSubview(scrollView!)
        scrollView?.addSubview(imageview)
        imageview.contentMode = .scaleAspectFit
        imageview.snp.makeConstraints { (maker) in
            maker.width.equalTo(frame.width)
            maker.height.equalTo(frame.height)
            maker.center.equalToSuperview()
        }
        imageview.isUserInteractionEnabled = true
        imageview.isMultipleTouchEnabled = true
        imageview.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onTapped)))
    }
    
    @objc func setImage(imageUrl:URL) -> Void {
        imageview.sd_setImage(with: imageUrl) { [weak self] (image, _, _, _)  in
            guard let self = self else {return }
            self.resetSize(image: image)
        }
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageview
    }
    
    func resetSize(image:UIImage?) {
        guard let src = image else {
            return
        }
        scrollView?.frame = self.bounds
        scrollView?.zoomScale = 1.0
        imageview.frame.size = scaleSize(size: src.size)
        imageview.center = scrollView?.center as! CGPoint
    }
    
    //获取imageView的缩放尺寸（确保首次显示是可以完整显示整张图片）
    func scaleSize(size:CGSize) -> CGSize {
        let width = size.width
        let height = size.height
        let widthRatio = width/UIScreen.main.bounds.width
        let heightRatio = height/UIScreen.main.bounds.height
        let ratio = max(heightRatio, widthRatio)
        return CGSize(width: width/ratio, height: height/ratio)
    }
    
    @objc func onTapped(){
        tapDelegate?.imageViewTap()
    }
    //查找所在的ViewController
    func responderViewController() -> UIViewController? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self){
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
     
}

@objc protocol ScaleableImageViewTapped {
   @objc func imageViewTap()->Void
}
