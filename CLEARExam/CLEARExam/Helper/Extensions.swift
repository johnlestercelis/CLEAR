//
//  Extensions.swift
//  CLEARExam
//
//  Created by John Lester Celis on 4/21/20.
//  Copyright © 2020 John Lester Celis. All rights reserved.
//

import UIKit

extension UINavigationController {
    func getReference<ViewController: UIViewController>(to viewController: ViewController.Type) -> ViewController? {
        return viewControllers.first { $0 is ViewController } as? ViewController
    }
}

extension Array where Element: Equatable{
    mutating func remove (element: Element) {
        if let i = self.firstIndex(of: element) {
            self.remove(at: i)
        }
    }
}

extension Date {
  func asString(style: DateFormatter.Style) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = style
    return dateFormatter.string(from: self)
  }
}

extension UIImageView {
    func roundCornersForAspectFit(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func loadImageUsingCache(withUrl urlString : String, stringDate: String, defaultImage: UIImage) {
      let imageCache = NSCache<NSString, AnyObject>()
      let url = URL(string: urlString)
      let userDef = UserDefaults.standard
      self.image =  defaultImage
      
      // check cached image
      let updatedDate = userDef.object(forKey: "updatedDate") as? String
      if stringDate == updatedDate, let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
        self.image = cachedImage
        return
      }
      
      // if not, download image from url
      if url != nil {
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
          if error != nil {
            print(error!)
            return
          }
          
          DispatchQueue.main.async {
            if let image = UIImage(data: data!) {
              userDef.set(stringDate, forKey: "updatedDate")
              imageCache.setObject(image, forKey: urlString as NSString)
              self.image = image
            }
          }
          
        }).resume()
      }
    }
}
