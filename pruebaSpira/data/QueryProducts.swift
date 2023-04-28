//
//  QueryProducts.swift
//  pruebaSpira
//
//  Created by MacBook Pro on 26/04/23.
//

import Foundation

protocol ProductsManagerDelegate {
    func showproductsList(lista:[Product])
}

struct ProductsManager {
    var delegado: ProductsManagerDelegate?
    func verProducto() {
        let urlString = "https://fakestoreapi.com/products"
        if let url =  URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { datos, respuesta, Error in
                if Error != nil {
                    print("error al obtener datos",Error?.localizedDescription)
                }
                if let secureData = datos?.parseData(quitarString: "null, "){
                    if let productsList = self.parseJSON(productsData: secureData){
                        print("lista de productos",productsList)
                        delegado?.showproductsList(lista: productsList)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(productsData:Data) -> [Product]?{
        let decoder = JSONDecoder()
        do {
            let DecodedData = try decoder.decode([Product].self, from: productsData)
            return DecodedData
        } catch  {
            print("error decoding Data",error.localizedDescription)
            return nil
        }
    }
}
extension Data{
    func parseData(quitarString str:String ) -> Data? {
        let DataAsString = String(data: self, encoding: .utf8)
        let parseDataString = DataAsString?.replacingOccurrences(of: str, with: "")
        guard let data = parseDataString?.data(using: .utf8) else {return nil}
        return data
        
    }
}
/*import UIKit

class GetProducts: UIViewController {
    func getProductsCall(completion: @escaping ([Product]) -> Void) {
        
        let url = URL(string: "https://fakestoreapi.com/products")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error al obtener los datos: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let productos = try decoder.decode([Product].self, from: data)
                completion(productos)
            } catch {
                print("Error al decodificar los datos: \(error.localizedDescription)")
                completion([])
            }
        }
        task.resume()
        
    }
    func getProductImage(UrlString:String,image:@escaping(UIImage)->()){
        let url = URL(string: UrlString)
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            if err != nil{
                print(err!.localizedDescription)
                return
            }
            DispatchQueue.main.async {
                image((UIImage(data: data!) ?? UIImage(named: "Camara"))!)
            }
        }.resume()
    }
}*/
