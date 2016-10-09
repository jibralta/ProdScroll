//
//  ViewController.swift
//  ProdScroll
//
//  Created by Gladys Umali on 10/7/16.
//  Copyright © 2016 Joy Umali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomBackground: UIImageView!
    
    var images = [UIImageView]()
    
    var maxPage = 9
    var minPage = 0
    var currentPage = 0
    
    override func viewDidAppear(_ animated: Bool) {
        
        var contentWidth: CGFloat = 0.0    //variable created to store content width to set content size.
        
        let scrollWidth = scrollView.frame.size.width
        
        for x in 0...9 {
            
            let image = UIImage(named: "\(x)_prod.jpg")     // picking from the assets
            let imageView = UIImageView(image: image)   // and placing into ImageView
            images.append(imageView)                     // adding image to the array above
            
            // Adding icons to the scroll view. Each will be in the middle but on different screens
            var newX: CGFloat = 0.0 // origin or placement point is top left.
            newX = scrollWidth / 2 + scrollWidth * CGFloat(x)
            contentWidth += newX
            scrollView.addSubview(imageView)    //adds the imageView icon to scrollView
            
//            imageView.frame = CGRect(x: newX - 75, y: bottomBackground.frame.origin.y + (bottomBackground.frame.size.height / 2) - 75, width: 150, height: 150)
            
             imageView.frame = CGRect(x: newX - 75, y: (view.frame.size.height / 2) - 75, width: 150, height: 150)
            
            imageView.bringSubview(toFront: imageView)
        }
        
        scrollView.clipsToBounds = false
        
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.size.height)
        
    }

    
    
    @IBAction func detectSwipe(_ sender: UISwipeGestureRecognizer) {
        
        if sender.direction == UISwipeGestureRecognizerDirection.left && currentPage < maxPage {
            moveScrollView(direction: 1)
        }
        
        if sender.direction == UISwipeGestureRecognizerDirection.right && currentPage > minPage {
            moveScrollView(direction: -1)
        }
    }
    
    func moveScrollView(direction:Int) {
        currentPage += direction
        let movement: CGPoint = CGPoint(x: scrollView.frame.size.width * CGFloat(currentPage), y: 0.0)
        scrollView.setContentOffset(movement, animated: true)
        
                // Create a animation to increase the actual icon on screen
                UIView.animate(withDuration: 0.4){
                    if self.currentPage != self.maxPage || self.currentPage != self.minPage {
                    self.images[self.currentPage].transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
                    }
        
                    // Revert icon size of the non-active pages
                    for x in 0..<self.images.count {
                        if (x != self.currentPage) {
                            self.images[x].transform = CGAffineTransform.identity
                        }
                    }
                }
        
        

    }
    
    @IBOutlet weak var testImageRotate: UIScrollView!
    
    

}

