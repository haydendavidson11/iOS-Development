//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Hayden Davidson on 2/23/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Selected your cake type", selection: $order.orderData.type) {
                        ForEach(0..<OrderData.types.count) {
                            Text(OrderData.types[$0])
                        }
                    }
                    Stepper(value: $order.orderData.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.orderData.quantity)")
                    }
                }
                Section{
                    Toggle(isOn: $order.orderData.specialRequestEnabled.animation()){
                        Text("Any special requests?")
                    }
                    
                    if order.orderData.specialRequestEnabled{
                        Toggle(isOn: $order.orderData.extraFrosting){
                            Text("Add extra frosting")
                        }
                        Toggle(isOn: $order.orderData.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                Section{
                    NavigationLink(destination: AddressView(order: order)){
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
