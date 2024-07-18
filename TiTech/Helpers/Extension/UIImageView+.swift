//
//  UIImageView+.swift
//  VFTeKYC
//
//  Created by Hoàng Minh Thành on 28/02/2023.
//

import Foundation
import UIKit
import Kingfisher
import ImageIO

extension UIImageView {
    func computeCropRect(for sourceFrame : CGRect) -> CGRect {
        
        let widthScale = bounds.size.width / image!.size.width
        let heightScale = bounds.size.height / image!.size.height
        
        var x : CGFloat = 0
        var y : CGFloat = 0
        var width : CGFloat = 0
        var height : CGFloat = 0
        var offSet : CGFloat = 0
        
        if widthScale < heightScale {
//            offSet = (bounds.size.height - (image!.size.height * widthScale))/2
//            x = sourceFrame.origin.x / widthScale
//            y = image!.size.height/5//(sourceFrame.origin.y - offSet) / widthScale
//            width = image!.size.width - image!.size.width/9//sourceFrame.size.width / widthScale
//            height = image!.size.height/2 - image!.size.height/5//sourceFrame.size.height / widthScale
            
            offSet = (bounds.size.height - (image!.size.height * widthScale))/2
            x = sourceFrame.origin.x / widthScale
            y = image!.size.height/5
            width = image!.size.width - image!.size.width/9
            height = width*(202/320)
            
        } else {
//            offSet = (bounds.size.width - (image!.size.width * heightScale))/2
//            x = (sourceFrame.origin.x - offSet) / heightScale
//            y = sourceFrame.origin.y / heightScale
//            width = sourceFrame.size.width / heightScale
//            height = sourceFrame.size.height / heightScale
            offSet = (bounds.size.height - (image!.size.height * widthScale))/2
            x = sourceFrame.origin.x / widthScale
            y = sourceFrame.origin.y / heightScale
            width = image!.size.width - image!.size.width/9
            height = width*(202/320)
        }
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func computeCropFaceRect(for sourceFrame : CGRect) -> CGRect {
        
        let widthScale = bounds.size.width / image!.size.width
        let heightScale = bounds.size.height / image!.size.height
        
        var x : CGFloat = 0
        var y : CGFloat = 0
        var width : CGFloat = 0
        var height : CGFloat = 0
        var offSet : CGFloat = 0
        
        if widthScale < heightScale {
            offSet = (bounds.size.height - (image!.size.height * widthScale))/1.2
            x = sourceFrame.origin.x / widthScale
            y = (sourceFrame.origin.y - offSet) / widthScale
            width = sourceFrame.size.width / widthScale
            height = width*(253/197) /// widthScale
        } else {
            offSet = (bounds.size.width - (image!.size.width * heightScale))/1.3
            x = (sourceFrame.origin.x - offSet) / heightScale
            y = image!.size.height/5//sourceFrame.origin.y / heightScale
            width = sourceFrame.size.width / heightScale
            height = image!.size.height/2//sourceFrame.size.height / heightScale
        }
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func realImageRect() -> CGRect {
        let imageViewSize = self.frame.size
        let imgSize = self.image?.size
        
        guard let imageSize = imgSize else {
            return CGRect.zero
        }
        
        let scaleWidth = imageViewSize.width / imageSize.width
        let scaleHeight = imageViewSize.height / imageSize.height
        let aspect = fmin(scaleWidth, scaleHeight)
        
        var imageRect = CGRect(x: 0, y: 0, width: imageSize.width * aspect, height: imageSize.height * aspect)
        
        // Center image
        imageRect.origin.x = (imageViewSize.width - imageRect.size.width) / 2
        imageRect.origin.y = (imageViewSize.height - imageRect.size.height) / 2
        
        // Add imageView offset
        imageRect.origin.x += self.frame.origin.x
        imageRect.origin.y += self.frame.origin.y
        
        return imageRect
    }
}

extension UIImage {
    func cropTo(size: CGSize) -> UIImage {
        guard let cgimage = self.cgImage else { return self }

        let contextImage: UIImage = UIImage(cgImage: cgimage)

        var cropWidth: CGFloat = size.width
        var cropHeight: CGFloat = size.height

        if (self.size.height < size.height || self.size.width < size.width){
            return self
        }

        let heightPercentage = self.size.height/size.height
        let widthPercentage = self.size.width/size.width

        if (heightPercentage < widthPercentage) {
            cropHeight = size.height*heightPercentage
            cropWidth = size.width*heightPercentage
        } else {
            cropHeight = size.height*widthPercentage
            cropWidth = size.width*widthPercentage
        }

        let posX: CGFloat = (self.size.width - cropWidth)/2
        let posY: CGFloat = (self.size.height - cropHeight)/2

        let rect: CGRect = CGRect(x: posX, y: posY, width: cropWidth, height: cropHeight)

        // Create bitmap image from context using the rect
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!

        // Create a new image based on the imageRef and rotate back to the original orientation
        let cropped: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)

        return cropped
    }
}

extension UIImageView {
    func setImageWith(imageUrl: String, placeHolder: UIImage? = nil) {
        let baseURL = "https://cms.1sk.vn"
        let url = URL(string: baseURL + imageUrl)
        let processor = DownsamplingImageProcessor(size: bounds.size)
        kf.setImage(with: url, placeholder: placeHolder,
                    options: [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale)
        ])
    }
    
    func setImageVietcetera(imageUrl: String, placeHolder: UIImage? = nil) {
        let baseURL = APIConstants.VIETCETERA_IMAGE_BASE_URL
        let url = URL(string: baseURL + imageUrl)
        let processor = DownsamplingImageProcessor(size: bounds.size)
        kf.setImage(with: url, placeholder: placeHolder,
                    options: [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale)
        ])
    }

    func setImage(with imageURL: String, completion: ((UIImage) -> Void)?) {
        guard let url = URL(string: imageURL) else {
            return
        }
        KingfisherManager.shared.retrieveImage(with: url) { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.image = result.image
                    completion?(result.image)
                }
            case .failure:
                break
            }
        }
    }
}

extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

// MARK: Gif Image Extension
extension UIImage {
    
    public class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("image doesn't exist")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source)
    }
    
    public class func gifImageWithURL(_ gifUrl: String) -> UIImage? {
        guard let bundleURL: URL = URL(string: gifUrl)
        else {
            print("image named \"\(gifUrl)\" doesn't exist")
            return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("image named \"\(gifUrl)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    public class func gifImageWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
            print("SwiftGif: This image named \"\(name)\" does not exist")
            return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(
            CFDictionaryGetValue(cfProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()),
            to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                             Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as? Double ?? 0
        
        if delay < 0.1 {
            delay = 0.1
        }
        
        return delay
    }
    
    class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        if a < b {
            let c = a
            a = b
            b = c
        }
        
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b!
            } else {
                a = b
                b = rest
            }
        }
    }
    
    class func gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        
        return gcd
    }
    
    class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                                                            source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        let animation = UIImage.animatedImage(with: frames,
                                              duration: Double(duration) / 1000.0)
        
        return animation
    }
}
