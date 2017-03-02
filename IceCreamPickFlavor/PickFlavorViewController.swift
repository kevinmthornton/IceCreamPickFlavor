//
//  ViewController.swift
//  IceCreamShop
//
//  Created by Joshua Greene on 2/8/15.
//  Copyright (c) 2015 Razeware, LLC. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

public class PickFlavorViewController: UIViewController, UICollectionViewDelegate {
  
  // MARK: Instance Variables
  
  var flavors: [Flavor] = [] {
    didSet {
      pickFlavorDataSource?.flavors = flavors
    }
  }
  
  // this is wired in the datasource of the storyboard file
  // the collectionView is pulled from the storyboard as an IBOutlet
  private var pickFlavorDataSource: PickFlavorDataSource? {
    return collectionView?.dataSource as! PickFlavorDataSource?
  }
  
  private let flavorFactory = FlavorFactory()
  
  // MARK: Outlets
  @IBOutlet var contentView: UIView!
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var iceCreamView: IceCreamView!
  @IBOutlet var label: UILabel!
  
  // MARK: View Lifecycle
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    loadFlavors()
  }
  
  private func loadFlavors() {
    
    showLoadingHUD()  // <-- Add this line
    
    // use Alamofire to create a GET request and download a plist containing ice cream flavors
    Alamofire.request(
      .GET, "http://www.raywenderlich.com/downloads/Flavors.plist",
      parameters: nil,
      encoding: .PropertyList(.XMLFormat_v1_0, 0), headers: nil)
      .responsePropertyList { [weak self] (_, _, result) -> Void in
        // In order to break a strong reference cycle, you use a weak reference to self in the response completion block
        // Once the block executes, you immediately get a strong reference to self so that you can set properties on it later
        guard let strongSelf = self else {
          return
        }
        
        strongSelf.hideLoadingHUD()
        
        // create a flavorsArray variable to hold the plist array on success.
        var flavorsArray: [[String : String]]! = nil
        
        // switch on result to determine whether the response was successful or not and get the values out of it
        switch result {
          
          case .Success(let array):
            if let array = array as? [[String : String]] {
              flavorsArray = array
            }
            
          case .Failure(_, _):
            print("Couldn't download flavors!")
            return
        }
        
        // set self.flavors to an array of Flavor objects created by a FlavorFactory
        // flavorsFromDictionaryArray: takes an array of dictionaries and uses them to create instances of Flavor
        strongSelf.flavors = strongSelf.flavorFactory.flavorsFromDictionaryArray(flavorsArray)
        strongSelf.collectionView.reloadData()
        strongSelf.selectFirstFlavor()
    }
  }
  
  private func showLoadingHUD() {
    let hud = MBProgressHUD.showHUDAddedTo(contentView, animated: true)
    hud.labelText = "Loading..."
  }
  
  private func hideLoadingHUD() {
    MBProgressHUD.hideAllHUDsForView(contentView, animated: true)
  }
  
  private func selectFirstFlavor() {
    
    if let flavor = flavors.first {
      updateWithFlavor(flavor)
    }
  }
  
  // MARK: UICollectionViewDelegate
  
  public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let flavor = flavors[indexPath.row]
    updateWithFlavor(flavor)
  }
  
  // MARK: Internal
  
  private func updateWithFlavor(flavor: Flavor) {
    iceCreamView.updateWithFlavor(flavor)
    label.text = flavor.name
  }
}
