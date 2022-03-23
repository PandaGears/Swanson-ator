//
//  ContentView.swift
//  Swansonator
//
//  Created by Tamara Radloff on 2022/03/16.
//

import SwiftUI


struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct ContentView: View {
    @State var Quote: String = ""
    var body: some View {
            VStack() {
                Text("Live, Love, Ron")
                    .font(Font.custom("Noteworthy", size: 20)).bold()
                    .foregroundColor(Color.white)
                Image("ronSwanson")
                    .resizable()
                Spacer()
                Text(Quote)
                    .foregroundColor(Color.white)
                    .font(Font.custom("Noteworthy", size: 14)).bold()
                Spacer()
                Button("Get a Quote") {
                    QuoteButton()
                }
                .buttonStyle(GrowingButton())
            }.background(Color.black)
        
    }
    private func QuoteButton(){
        let url = URL(string: "https://ron-swanson-quotes.herokuapp.com/v2/quotes")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print("error here")
                }
                else {
                    if let content = data {
                        do {
                            let quote = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
                            let swansonQuote = (quote[0] as! String)
                            Quote = swansonQuote
                        }
                        catch {
                            print(error)
                        }
                    }
                }
            }
        }
            task.resume()
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
