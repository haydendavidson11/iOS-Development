//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Hayden Davidson on 2/23/21.
//

import SwiftUI

struct CheckoutView: View {
    @State private var confirmationTitle = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    @ObservedObject var order: Order
    var body: some View {
        GeometryReader { geo in
            ScrollView{
                VStack{
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    Text("Your total is $\(self.order.orderData.cost, specifier: "%.2f")")
                        .font(.title)
                    Button("Place Order"){
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text(confirmationTitle), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
        .navigationBarTitle("Check out", displayMode: .inline)
    }
    
    //MARK: - Place order
    
    func placeOrder() {
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(order.orderData) else {
            print("Failed to encode order")
            return
        }
        guard let encodedOrder = String(data: encoded, encoding: .utf8) else{
            print("Can not encode data to json string")
            return
        }
        print(encodedOrder)
        
        
        let url = URL(string: "http://127.0.0.1:8080/addorder")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        
        
        URLSession.shared.dataTask(with: request) {
           
            data, response, error in
//            let orderData = OrderData()
            guard let data = data  else {
                self.confirmationTitle = "Network Error"
                self.confirmationMessage = "Please connect to the internet and try again."
                self.showingConfirmation = true
                
                print("No data in response: \(error?.localizedDescription ?? "Unknown Error").")
                return
            }
            
           
//            Decode the order
            let decoder = JSONDecoder()
            let orderData = OrderData()
            if let decodedOrder: OrderData = try? decoder.decode(orderData, from: data) {
                self.confirmationTitle = "Thank You!"
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(OrderData.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
                print(decodedOrder)
            } else {
                print("here")
            }
            
            
        }.resume()
    }
    
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
