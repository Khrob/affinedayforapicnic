//
//  ViewController.swift
//  DrawTest
//
//  Created by Khrob Edmonds on 24/1/19.
//  Copyright © 2019 TangoSoup. All rights reserved.
//

import UIKit

class Outer : UIView
{
    let image:UIImage = #imageLiteral(resourceName: "test-grid")
    
    override func draw(_ rect: CGRect) { image.draw(in: rect) }
}

class Inner : UIView
{
    let image:UIImage = #imageLiteral(resourceName: "test-2")
    
    override func draw(_ rect: CGRect) { image.draw(in: rect) }
}

class ViewController: UIViewController
{
    @IBOutlet weak var outer: Outer!
    @IBOutlet weak var inner: Inner!
    @IBOutlet weak var output_image_1: UIImageView!
    @IBOutlet weak var output_image_2: UIImageView!
    
    @IBAction func test_1_pushed(_ sender: Any) { output_image_1.image = get_image_1() }
    @IBAction func test_2_pushed(_ sender: Any) { output_image_2.image = get_image_2() }
    
    override func viewDidLoad()
    {
        print (inner.center)
        print (inner.frame)
        print (inner.bounds)
        
        inner.transform = inner.transform.concatenating(CGAffineTransform(rotationAngle: CGFloat.pi / 4.0))
        
        print (inner.center)
        print (inner.frame)
        print (inner.bounds)
    }
    
    func get_image_1 () -> UIImage
    {
        let renderer = UIGraphicsImageRenderer(bounds: outer.bounds)
        return renderer.image { _ in outer.drawHierarchy(in: outer.bounds, afterScreenUpdates: true) }
    }
    
    func get_image_2 () -> UIImage
    {
        let renderer = UIGraphicsImageRenderer(bounds: outer.bounds)
        
        return renderer.image { context in
            outer.image.draw(in: outer.bounds)
            context.cgContext.concatenate(inner.transform)
            inner.image.draw(in: inner.bounds)
        }
    }
}

