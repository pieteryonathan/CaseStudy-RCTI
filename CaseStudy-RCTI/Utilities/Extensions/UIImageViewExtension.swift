//
//  UIImageViewExtension.swift
//  CaseStudy-RCTI
//
//  Created by Pieter Yonathan on 26/06/24.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    
    func setBlur() {
        let blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let effectView:UIVisualEffectView = UIVisualEffectView (effect: blur)
        effectView.frame = frame
        effectView.alpha = 0.75
        self.addSubview(effectView)
    }
    
    func circlifyImage(opacity:Float = 0.25, radius: Float = 2.5, heightOffset: Int = 0) {
        clipsToBounds = true
        let roundValue = frame.width / 2
        layer.cornerRadius = roundValue
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = opacity
//        layer.shadowOffset = CGSize(width: 0, height: heightOffset)
//        layer.shadowRadius = CGFloat(radius)
    }
    
    func afImage(_ url: String, placeholder: UIImage? = nil, filter: ImageFilter? = nil,imageTransition: UIImageView.ImageTransition = .crossDissolve(0.2), contentModeOnComplete: UIView.ContentMode? = nil, completion: ((DataResponse<UIImage, AFIError>) -> Void)? = nil) {
        image = placeholder
        if let url = try? url.asURL() {
            af.setImage(
                withURL: url,
                placeholderImage: placeholder,
                filter: filter,
                imageTransition: imageTransition,
                completion: { [weak self] dataResponse in
                    guard let self = self else { return }
                    
                    self.contentMode = contentModeOnComplete ?? self.contentMode
                    completion?(dataResponse)
                })
        }
    }
}

public struct CoreImageFilter: ImageFilter {

    let filterName: String
    let parameters: [String: AnyObject]

    public init(filterName : String, parameters : [String : AnyObject]?) {
        self.filterName = filterName
        self.parameters = parameters ?? [:]
    }

    public var filter: (UIImage) -> UIImage {
        return { image in
            return image.af.imageFiltered(withCoreImageFilter: self.filterName, parameters: self.parameters) ?? image
        }
    }
}
