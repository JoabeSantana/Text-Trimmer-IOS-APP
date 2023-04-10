//
//  ContentView.swift
//  Text-Trimmer
//
//  Created by Joabe Santana Correia on 10/04/23.
//

import SwiftUI

struct TextTrimmerView: View {
    
    @State private var nome: String = ""
    
    var campoTexto: String {
        get {
            return nome
        }
    }
    
    private let pasteboard = UIPasteboard.general
    
    var body: some View {
       // NavigationView {
            VStack {
                Text("Text Trimmer")
                    .font(.headline)
                Spacer()
                HStack{
                    ZStack {
                        TextFieldView(bindingVariable: $nome)
                    }
                    
                    Button(action: {
                        pasteboard.setItems([["public.utf8-plain-text" : campoTexto]])
                    }, label: {
                        Image(systemName: "doc.on.doc")
                            .padding()
                            .foregroundColor(.white)
                            .background(campoTexto.isEmpty ? Color.gray.cornerRadius(10) : Color.blue.cornerRadius(10))
                            .font(.headline)
                    })
                    .disabled(campoTexto.isEmpty)
                }
                
                Button(action: {
                    nome = nome.replacingOccurrences(
                        of: "[/[^A-Z0-9]+/ig]",
                        with: "",
                        options: .regularExpression,
                        range: nome.startIndex..<nome.endIndex)
                }, label: {
                    Text("Trim")
                        .padding()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.cornerRadius(10))
                        .font(.headline)
                })
                Spacer()
            }
            .padding()
            //.navigationTitle("Text Trimmer")
            //.navigationBarTitleDisplayMode(.inline)
       // }
    }
}

struct TextFieldView : View {
    
    var bindingVariable: Binding<String>
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(lineWidth: 1.5)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
        TextField(
            "Input your Text here",
            text: bindingVariable
        )
        .padding()
        .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TextTrimmerView()
            .previewDevice("iPhone 14 Pro Max")
            .preferredColorScheme(.dark)
    }
}
