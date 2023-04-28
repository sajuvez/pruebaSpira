//
//  SecondViewController.swift
//  pruebaSpira
//
//  Created by MacBook Pro on 27/04/23.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productCategory: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productRate: UILabel!
    @IBOutlet weak var productCount: UILabel!
    var product: Product!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = product!.title
        productImage.loadFrom(URLAddres:product.image)
        productDescription.text = product!.description
        productCategory.text = "categoria: \(product!.category)"
        productPrice.text = "precio:  $\(product!.price)"
        productRate.text = "rating: \(product!.rating.rate)"
        productCount.text = "unidades: \(product!.rating.count)"
        
        print("producto seleccionado:  \(product)")
        if let producto = product {
            titleLbl?.text = producto.title
        }
        
        
        self.titleLbl?.text = product?.title
        self.navigationController?.navigationItem.leftBarButtonItem?.isEnabled = true
        self.navigationController?.isNavigationBarHidden = false
        
        // Do any additional setup after loading the view.
    }
}
extension UIImageView{
    func loadFrom(URLAddres:String) {
        guard let url = URL(string:  URLAddres) else { return }
        DispatchQueue.main.async {
            if let imageData = try? Data(contentsOf: url){
                if let loadedImage = UIImage(data: imageData){
                    self.image = loadedImage
                }
            }
        }
    }
}
