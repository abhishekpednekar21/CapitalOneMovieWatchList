//
//  UIView+Extension.swift
//  MovieWatchListDemo
//
//  Created by Abhishek Pednekar on 2022-06-22.
//

import Foundation
import UIKit

public extension UIView {
    
    func constraintsToFillSuperview() -> [NSLayoutConstraint] {
        return self.constraintsToFillSuperview(insets: .zero)
    }
    
    func constrainToFillSuperview() {
        NSLayoutConstraint.activate(self.constraintsToFillSuperview())
    }
    
    func constraintsToFillSuperview(insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        guard let superview = self.superview else { return [] }
        var constraints: [NSLayoutConstraint] = []
        constraints.append(self.topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top))
        constraints.append(self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: insets.left))
        constraints.append(self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom))
        constraints.append(self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -insets.right))
        return constraints
    }
    
    
    func constrainToFillSuperview(insets: UIEdgeInsets) {
        NSLayoutConstraint.activate(self.constraintsToFillSuperview(insets: insets))
    }
    
    func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool) {
            var topInset = CGFloat(0)
            var bottomInset = CGFloat(0)

            if #available(iOS 11, *), enableInsets {
                let insets = self.safeAreaInsets
                topInset = insets.top
                bottomInset = insets.bottom

                print("Top: \(topInset)")
                print("bottom: \(bottomInset)")
            }

            translatesAutoresizingMaskIntoConstraints = false

            if let top = top {
                self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
            }
            if let left = left {
                self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
            }
            if let right = right {
                rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }
            if let bottom = bottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
            }
            if height != 0 {
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }
            if width != 0 {
                widthAnchor.constraint(equalToConstant: width).isActive = true
            }
        }
}

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    func loadImageUsingCacheWithUrlString(urlString: String) {
        if let image = imageCache.object(forKey: urlString as NSString) {
            self.image = image
            return
        }
        URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    self.image = downloadedImage
                }
            }
        }).resume()
    }
}
