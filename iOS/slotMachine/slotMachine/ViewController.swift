//
//  ViewController.swift
//  slotMachine
//
//  Created by JeremyXue on 2018/6/12.
//  Copyright © 2018年 JeremyXue. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    
    var scrollView = UIScrollView()
    var effectImage = UIImageView()
    let cardImage = UIImageView()
    let cardButton = UIButton()
    let clipView = UIView()
    let auraView = UIView()
    
    let end = 50
    let width = 108 * 3 / 2
    let height = 132 * 3 / 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        auraView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        auraView.center = view.center
        auraView.clipsToBounds = true
        
        view.addSubview(auraView)
        
        let effectImage = UIImageView()
        effectImage.image = UIImage(named: "card_aura_gray_180x180")
        effectImage.frame = CGRect(x: 0, y: 0, width: width * 30, height: height)
        
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (Timer) in
            effectImage.center.x -= CGFloat(self.width)
            if effectImage.center.x <= -2400 {
                effectImage.frame = CGRect(x: 0, y: 0, width: self.width * 30, height: self.height)
            }
        }
        
        auraView.addSubview(effectImage)
        auraView.isHidden = true
        
        animation()
        autoShineEffect()
        
        cardImage.image = UIImage(named: "card back")
        cardImage.frame = CGRect(x: 0, y: 0, width: width, height: height)
        cardImage.center = view.center
        cardImage.clipsToBounds = true
        
        cardButton.frame = cardImage.frame
        cardButton.center = view.center
        cardButton.addTarget(self, action: #selector(start), for: UIControlEvents.touchUpInside)
        
        view.addSubview(cardImage)
        view.addSubview(cardButton)
        
        scrollView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        scrollView.center = view.center
        scrollView.contentSize = CGSize(width: width * end, height: height)
        scrollView.contentOffset = CGPoint(x: width, y: 0)
        scrollView.isHidden = true
        scrollView.isPagingEnabled = true
        scrollView.layer.borderColor = UIColor.white.cgColor
        scrollView.layer.borderWidth = 3
        
        scrollView.delegate = self
        
        addImageToScrollView(start: 0, end: end)
        
        let resetButton = UIButton()
        resetButton.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        resetButton.center = CGPoint(x: view.center.x, y: view.center.y + scrollView.frame.height)
        resetButton.setTitle("RESET", for: UIControlState.normal)
        resetButton.tintColor = UIColor.white
        resetButton.backgroundColor = UIColor.red
        
        resetButton.addTarget(self, action: #selector(resetUI), for: UIControlEvents.touchUpInside)
        
        view.addSubview(scrollView)
        view.addSubview(resetButton)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func resetUI() {
        cardButton.isHidden = false
        cardImage.isHidden = false
        clipView.isHidden = false
        auraView.isHidden = true
        scrollView.isHidden = true
        effectImage.isHidden = false
        scrollView.layer.borderColor = UIColor.white.cgColor
        
        scrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height), animated: true)
    }
    
    func shineEffect(isEnd:Bool) {
        
        let effectImage = UIImageView()
        
        effectImage.image = UIImage(named: "card shine")
        effectImage.frame = CGRect(x: 0, y: 0, width: Double(width) * 1.3, height: Double(height) * 1.3)
        effectImage.center = view.center
        effectImage.contentMode = .scaleAspectFill
        effectImage.alpha = 0
        
        view.addSubview(effectImage)
        
        UIView.animate(withDuration: 0.5, animations: {
            effectImage.alpha = 1
        }) { (finish) in
            UIView.animate(withDuration: 0.5, animations: {
                effectImage.alpha = 0
                if isEnd {
                    self.auraView.isHidden = false
                    self.scrollView.layer.borderColor = UIColor.red.cgColor
                }
            })
        }
    }
    
    func autoShineEffect() {

        effectImage.image = UIImage(named: "card shine")
        effectImage.frame = CGRect(x: 0, y: 0, width: Double(width) * 1.3, height: Double(height) * 1.3)
        effectImage.center = view.center
        effectImage.contentMode = .scaleAspectFill
        effectImage.alpha = 0
        
        view.addSubview(effectImage)
        
        UIView.animate(withDuration: 1, delay: 0, options: [UIViewAnimationOptions.autoreverse,.repeat], animations: {
            self.effectImage.alpha = 1
        }, completion: nil)

    }
    
    @objc func start(_ sender:UIButton) {
        cardButton.isHidden = true
        cardImage.isHidden = true
        clipView.isHidden = true
        scrollView.isHidden = false
        effectImage.isHidden = true
        
        var move:CGFloat = 0
        shineEffect(isEnd: false)
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            move += CGFloat(self.width)
            print(move)
            self.scrollView.scrollRectToVisible(CGRect(x: move, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height), animated: true)
            
            if move > 8000 {
                timer.invalidate()
                self.shineEffect(isEnd: true)
            }
        }
    }
    
    
    func addImageToScrollView(start:Int,end:Int) {
        
        var imageNumber = 0
        
        // charater image
        for image in start...end {
            imageNumber = image % 10
            let characterImage = UIImageView()
            characterImage.image = UIImage(named: "\(imageNumber)")
            characterImage.contentMode = .scaleAspectFill
            characterImage.clipsToBounds = true
            characterImage.frame = CGRect(x: (image - 1) * width, y: 0, width: width, height: height)
            scrollView.addSubview(characterImage)
            
        }
        // mask image
        for mask in start...end {
            
            let maskImage = UIImageView()
            maskImage.image = UIImage(named: "color mask")
            maskImage.contentMode = .scaleAspectFill
            maskImage.clipsToBounds = true
            maskImage.frame = CGRect(x: (mask - 1) * width * 5, y: 0, width: width * 5, height: height)
            
            scrollView.addSubview(maskImage)
        
        }
    }
    
    func animation () {
        
        clipView.frame = CGRect(x: 0, y: 0, width: width * 3, height: height * 3)
        clipView.center = view.center
        clipView.clipsToBounds = true
        
        view.addSubview(clipView)
        
        let effectImage = UIImageView()
        effectImage.image = UIImage(named: "card_aura_gray_180x180")
        effectImage.frame = CGRect(x: 0, y: 0, width: width * 30 * 3, height: height * 3)
        
        clipView.addSubview(effectImage)
        
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (Timer) in
            effectImage.center.x -= CGFloat(self.width * 3)
            if effectImage.center.x <= -7290 {
                effectImage.frame = CGRect(x: 0, y: 0, width: self.width * 30 * 3, height: self.height * 3)
            }
        }
    }
}

