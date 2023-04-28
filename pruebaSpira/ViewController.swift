//
//  ViewController.swift
//  pruebaSpira
//
//  Created by MacBook Pro on 26/04/23.
//

import UIKit

class ViewController: UIViewController {
    var productsManager = ProductsManager()
    var productsData :[Product] = []
    var detalleProducto: Product?
    var productoSeleccionado:Product?
    
    @IBOutlet weak var tablaProductos: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablaProductos.register(UINib(nibName: "ProductoViewCell", bundle: nil), forCellReuseIdentifier: "celdaProducto")
        productsManager.delegado = self
        productsManager.verProducto()
    }
    
    
    func datatable() {
        tablaProductos.delegate = self
        tablaProductos.dataSource = self
    }
    
    
    
}
extension ViewController:ProductsManagerDelegate{
    func showproductsList(lista: [Product]) {
        productsData = lista
        DispatchQueue.main.async {
            
            self.datatable()
            self.tablaProductos.reloadData()
        }
    }
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(productsData)
        return productsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaProductos.dequeueReusableCell(withIdentifier: "celdaProducto", for: indexPath) as! ProductoViewCell
        //nombre del producto
        celda.productTitle.text = productsData[indexPath.row].title
        //imagen del producto
        
        if let urlString = productsData[indexPath.row].image as? String {
            if let imageUrl = URL(string: urlString){
                DispatchQueue.global().async {
                    guard let imagenData = try? Data(contentsOf: imageUrl) else
                    { return }
                    let image = UIImage(data:  imagenData)
                    DispatchQueue.main.async {
                        celda.productImage.image = image
                    }
                }
            }
        }
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         productoSeleccionado = productsData[indexPath.row]
        performSegue(withIdentifier: "productDetail", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productDetail"{
            let productoSelected = segue.destination as! SecondViewController
            productoSelected.product = productoSeleccionado
            //print(productoSeleccionado)
        }
    }
    
    
}

