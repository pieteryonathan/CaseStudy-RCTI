//
//  SheetViewControllerExtensions.swift
//  CaseStudy-RCTI
//
//  Created by Pieter Yonathan on 27/06/24.
//

import Foundation
import FittedSheets

extension SheetViewController {
    static func showController(_ controller: UIViewController, onParent parentController: UIViewController, sizes: [SheetSize] = [.fixed(300), .fullscreen]) -> SheetViewController {
        let options = SheetOptions(
            shrinkPresentingViewController: false
        )
        let sheetController = SheetViewController(controller: controller, sizes: sizes, options: options)
        sheetController.cornerRadius = 24
        sheetController.modalTransitionStyle = .crossDissolve
        sheetController.gripSize = CGSize.zero
        sheetController.allowPullingPastMaxHeight = false
        parentController.present(sheetController, animated: true, completion: nil)
        return sheetController
    }
    
    static func show(_ controller: UIViewController, onParent parentController: UIViewController, sizes: [SheetSize] = [.fixed(300), .fullscreen]) {
        let options = SheetOptions(
            shrinkPresentingViewController: false
        )
        let sheetController = SheetViewController(controller: controller, sizes: sizes, options: options)
        sheetController.cornerRadius = 24
        sheetController.modalTransitionStyle = .crossDissolve
        sheetController.gripSize = CGSize.zero
        sheetController.allowPullingPastMaxHeight = false
        parentController.present(sheetController, animated: true, completion: nil)
    }
    
    static func showPersisted(_ controller: UIViewController, onParent parentController: UIViewController, sizes: [SheetSize] = [.fixed(300), .fullscreen]) {
        let options = SheetOptions(
            shrinkPresentingViewController: false
        )
        let sheetController = SheetViewController(controller: controller, sizes: sizes, options: options)
        sheetController.cornerRadius = 24
        sheetController.modalTransitionStyle = .crossDissolve
        sheetController.gripSize = CGSize.zero
        sheetController.allowPullingPastMaxHeight = false
        sheetController.allowPullingPastMinHeight = false
        sheetController.allowGestureThroughOverlay = false
        sheetController.dismissOnPull = false
        sheetController.dismissOnOverlayTap = false
        parentController.present(sheetController, animated: true, completion: nil)
    }
}
