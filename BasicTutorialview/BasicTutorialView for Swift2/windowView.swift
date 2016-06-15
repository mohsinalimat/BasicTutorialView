//
//  viewTemplate1.swift
//  demoMailTemplates
//
//  Created by Alan Roldán Maillo on 11/6/16.
//  Copyright © 2016 Alan Roldán Maillo. All rights reserved.
//

import UIKit

class windowView : NSObject
{
    private var anch: CGFloat = 0
    private var alt: CGFloat = 0
    private var this : UIViewController!
    private var marginBottom : CGFloat = 0
    private var modelView = 0
    
    private var shadow = UIView()
    private var window = UIView()
    private var images = [String]()
    private var titles = [String]()
    private var arrowLeft = UIButton()
    private var arrowRight = UIButton()
    private var imageView = UIImageView()
    private var titleLabel = UILabel()
    private var balls = [UIImageView]()
    private var iterator = 0
    
    func modelOne(ViewController:UIViewController, arrayImages: [String], arrayTitles: [String])
    {
        self.modelView = 0
        self.iterator = 0
        self.alt = UIScreen.mainScreen().bounds.height
        self.anch = UIScreen.mainScreen().bounds.width
        self.marginBottom = 25
        
        self.this = ViewController
        self.images = arrayImages
        self.titles = arrayTitles
        
        shadow = self.createShadow()
        this.view.addSubview(shadow)
        
        window = self.createWindow()
        this.view.addSubview(window)
        createSwipeGesture()
        
        createImage()
        createLabel()
        createArrow()
        createCircleIndicator(8,separate: 18)
        
        shadow.alpha = 0.0
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations:
            {
                self.shadow.alpha = 1.0
            }
            , completion: nil)
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations:
            {
                self.window.frame.origin.y = self.alt/2-(self.alt/3)
            }
            , completion: nil)
    }
    
    func modelTwo(ViewController:UIViewController, arrayImages: [String], arrayTitles: [String])
    {
        self.modelView = 1
        self.iterator = 0
        self.alt = UIScreen.mainScreen().bounds.height
        self.anch = UIScreen.mainScreen().bounds.width
        self.marginBottom = 2
        
        self.this = ViewController
        self.images = arrayImages
        self.titles = arrayTitles
        
        shadow = self.createShadow()
        this.view.addSubview(shadow)
        
        window = self.createWindow()
        this.view.addSubview(window)
        createSwipeGesture()
        
        createImage()
        createLabel()
        createCircleIndicator(9,separate: 22)
        
        shadow.alpha = 0.0
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations:
            {
                self.shadow.alpha = 1.0
            }
            , completion: nil)
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations:
            {
                self.window.frame.origin.y = self.alt/2-(self.alt/3)
            }
            , completion: nil)
    }
    
    private func createShadow()->UIView
    {
        var shadowView : UIView!
        shadowView = UIView(frame: CGRect(x: 0, y: 0, width: anch, height: alt))
        shadowView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        let gesture = UITapGestureRecognizer(target: self, action: "closeAll:")
        shadowView.addGestureRecognizer(gesture)
        
        return shadowView
    }
    
    private func createWindow()->UIView
    {
        var windowp : UIView!
        windowp = UIView(frame: CGRect(x: anch/2-alt/4, y: alt, width: alt/2, height: (alt/3)*2))
        windowp.backgroundColor = UIColor.whiteColor()
        windowp.layer.cornerRadius = 8
        
        if modelView == 1
        {
            // Set vertical effect
            let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y",type: .TiltAlongVerticalAxis)
            verticalMotionEffect.minimumRelativeValue = -15
            verticalMotionEffect.maximumRelativeValue = 15
            
            // Set horizontal effect
            let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x",type: .TiltAlongHorizontalAxis)
            horizontalMotionEffect.minimumRelativeValue = -15
            horizontalMotionEffect.maximumRelativeValue = 15
            
            // Create group to combine both
            let group = UIMotionEffectGroup()
            group.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
            
            // Add both effects to your view
            windowp.addMotionEffect(group)
        }
        
        return windowp
    }
    
    private func createSwipeGesture()
    {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "nextImage:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        window.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "backtImage:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        window.addGestureRecognizer(swipeRight)
    }
    
    private func createImage()
    {
        let image: UIImage = UIImage(named:images[0])!
        imageView = UIImageView(image: image)
        let sizeImage = window.frame.width-2
        imageView.frame = CGRectMake(1, window.frame.height-sizeImage-marginBottom,sizeImage,sizeImage)
        
        window.addSubview(imageView)
    }
    
    private func createLabel()
    {
        titleLabel.frame = (CGRect(x: 5, y: 5, width: window.frame.width-10, height: window.frame.height-window.frame.width-marginBottom-5))
        titleLabel.font = UIFont(name: "HelveticaNeue", size: 30)
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad
        {
            titleLabel.frame = (CGRect(x: 10, y: 10, width: window.frame.width-20, height: window.frame.height-window.frame.width-marginBottom-10))
            titleLabel.font = UIFont(name: "HelveticaNeue", size: 45)
        }
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.text = titles[0]
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        
        window.addSubview(titleLabel)
    }
    
    private func createArrow()
    {
        if images.count > 1
        {
            arrowLeft = UIButton(frame: CGRectMake(0,window.frame.height/2,45,30))
            arrowLeft.setImage(UIImage(named: "arrowLFT"), forState: .Normal)
            arrowLeft.addTarget(self, action:"backtImage:", forControlEvents:.TouchDown)
            arrowLeft.alpha = 0.8
            window.addSubview(arrowLeft)
            
            arrowRight = UIButton(frame: CGRectMake((window.frame.width-45),window.frame.height/2,45,30))
            arrowRight.setImage(UIImage(named: "arrowRGT"), forState: .Normal)
            arrowRight.addTarget(self, action:"nextImage:", forControlEvents:.TouchDown)
            arrowRight.alpha = 0.8
            window.addSubview(arrowRight)
            
            arrowLeft.hidden = true
        }
    }
    
    private func createCircleIndicator(sizeBall:CGFloat, separate:CGFloat)
    {
        if images.count > 1
        {
            var posy = window.frame.height-marginBottom/2-sizeBall
            var centerLocation = (window.frame.width/2)-sizeBall/2
            let centerBall = CGFloat(images.count)/2
            
            if modelView == 1
            {
                let w1 = alt-(self.alt/2+(self.alt/3))
                posy = w1/2 + (self.alt/2+(self.alt/3))
                centerLocation = (shadow.frame.width/2)-sizeBall/2
            }
            
            for i in 0...images.count-1
            {
                let ball = UIImageView()
                ball.image = UIImage(named: "bola1")
                let j:CGFloat = CGFloat(i) + 0.5
                
                if j < centerBall
                {
                    ball.frame = CGRectMake(centerLocation-(centerBall-j)*separate,posy, sizeBall, sizeBall)
                }
                else if j == centerBall
                {
                    ball.frame = CGRectMake(centerLocation,posy, sizeBall, sizeBall)
                }
                else if j > centerBall
                {
                    ball.frame = CGRectMake(centerLocation+(j-centerBall)*separate,posy, sizeBall, sizeBall)
                }
                
                balls.insert(ball, atIndex: i)
                if modelView == 0 {window.addSubview(ball)}
                else{shadow.addSubview(ball)}
            }
            
            balls[0].image = UIImage(named: "bola2")
        }
    }
    
    func nextImage(sender:AnyObject)
    {
        if iterator < images.count-1
        {
            if modelView == 1
            {
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations:
                    {
                        self.window.frame.origin.x = -(self.window.frame.size.width)
                }) { _ in
                    
                    self.changeImage(+1)
                    
                    self.window.frame.origin.x = self.anch
                    
                    UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations:
                        {
                            self.window.frame.origin.x = self.anch/2-self.alt/4
                    }) { _ in
                    }
                }
            }
            else
            {
                changeImage(+1)
            }
        }
    }
    
    func backtImage(sender:AnyObject)
    {
        if iterator > 0
        {
            if modelView == 1
            {
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations:
                    {
                        self.window.frame.origin.x = self.alt
                }) { _ in
                    
                    self.changeImage(-1)
                    
                    self.window.frame.origin.x = -(self.window.frame.size.width)
                    
                    UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations:
                        {
                            self.window.frame.origin.x = self.anch/2-self.alt/4
                    }) { _ in
                    }
                }
                
            }
            else
            {
                changeImage(-1)
            }

        }
    }
    
    private func changeImage(value:Int)
    {
        self.balls[self.iterator].image = UIImage(named: "bola1")
        self.iterator = iterator + value
        let image = UIImage(named: self.images[self.iterator])!
        self.imageView.image = image
        self.titleLabel.text = self.titles[self.iterator]
        self.balls[self.iterator].image = UIImage(named: "bola2")
        
        if self.iterator == 0
        {
            self.arrowLeft.hidden = true
            self.arrowRight.hidden = false
        }
        else if self.iterator == self.images.count-1
        {
            self.arrowLeft.hidden = false
            self.arrowRight.hidden = true
        }
        else
        {
            self.arrowLeft.hidden = false
            self.arrowRight.hidden = false
        }

    }
    
    func closeAll(sender:UITapGestureRecognizer)
    {
        shadow.alpha = 1.0
        UIView.animateWithDuration(0.7, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations:
            {
                self.shadow.alpha = 0
        }) { _ in
            self.shadow.removeFromSuperview()
        }
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations:
            {
                self.window.frame.origin.y = self.alt
        }) { _ in
            self.window.removeFromSuperview()
        }
    }
}
