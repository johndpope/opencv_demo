//
//  ViewController.swift
//  opencv-demo
//
//  Created by Daniel Saha on 7/18/16.
//  Copyright © 2016 Daniel Saha. All rights reserved.
//

import UIKit
import MobileCoreServices


class ViewController: UIViewController {

    
    var lastPoint:CGPoint!
    var isSwiping:Bool!
    var red:CGFloat!
    var green:CGFloat!
    var blue:CGFloat!
    
    
    @IBOutlet weak var openCVVersionLabel: UILabel!
    @IBOutlet weak var spiralImageView: UIImageView!
    
    @IBOutlet weak var userDrawView: UIImageView!
    
    @IBOutlet weak var imageDifferenceView: UIImageView!

    @IBOutlet weak var userDrawView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userDrawView2.image = nil;
        userDrawView2.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).CGColor
        userDrawView2.layer.cornerRadius = 5.0
        userDrawView2.layer.borderWidth = 2 // as you wish
//        userDrawView2.alpha = 1.0;
//        userDrawView2.backgroundColor = UIColor.clearColor();
//        
        
        
        userDrawView.image = nil;
        userDrawView.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).CGColor
        userDrawView.layer.cornerRadius = 5.0
        userDrawView.layer.borderWidth = 2 // as you wish
//        userDrawView.layer.backgroundColor = UIColor.grayColor().CGColor;
        //userDrawView.alpha = 1.0;
        //userDrawView.backgroundColor = UIColor.clearColor();
        
        imageDifferenceView.image = nil;
        imageDifferenceView.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).CGColor
        imageDifferenceView.layer.cornerRadius = 5.0
        imageDifferenceView.layer.borderWidth = 2 // as you wish
//        imageDifferenceView.alpha = 1.0;
//        imageDifferenceView.backgroundColor = UIColor.clearColor();

        
        openCVVersionLabel.text = OpenCVWrapper.openCVVersionString();
        red   = 1.0;
        green = 1.0;
        blue  = 1.0;
//
//        red   = (0.0/255.0);
//        green = (0.0/255.0);
//        blue  = (0.0/255.0);

        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func maskSpiral(sender: AnyObject) {
        
        //userDrawView2.image = OpenCVWrapper.makeGrayFromImage(userDrawView2.image);
        //userDrawView.image = OpenCVWrapper.subtractImages(spiralImageView.image, userDrawView2.image);
//        userDrawView.image = OpenCVWrapper.cleanse(userDrawView.image);
//        imageDifferenceView.image = OpenCVWrapper.cleanse(imageDifferenceView.image);
//        
//        imageDifferenceView.image = nil;
//        userDrawView.image = nil;
//        userDrawView2.image = nil;
//        imageDifferenceView.image = userDrawView2.image;


        
        
        userDrawView.image = userDrawView2.image;//OpenCVWrapper.cleanse(userDrawView2.image);
        
        imageDifferenceView.image = OpenCVWrapper.subtractImages(  userDrawView2.image, spiralImageView.image);
    }
    
    override func touchesBegan( touches: Set<UITouch>,
                                withEvent event: UIEvent?){
        isSwiping    = false
        if let touch = touches.first{
            lastPoint = touch.locationInView(userDrawView2)
        }
    }
    
    
    
    override func touchesMoved(touches: Set<UITouch>,
                               withEvent event: UIEvent?){
        
        isSwiping = true;
        if let touch = touches.first{
            let currentPoint = touch.locationInView(userDrawView2)
            print(currentPoint);
            UIGraphicsBeginImageContext(self.userDrawView2.frame.size)
            self.userDrawView2.image?.drawInRect(CGRectMake(0, 0, self.userDrawView2.frame.size.width, self.userDrawView2.frame.size.height))
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y)
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y)
            CGContextSetLineCap(UIGraphicsGetCurrentContext(),CGLineCap.Round)
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 9.0)
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(),red, green, blue, 1.0)
            CGContextStrokePath(UIGraphicsGetCurrentContext())
            self.userDrawView2.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            lastPoint = currentPoint
        }
    }

    

}

