//
//  DetailView.swift
//  ToDoList
//
//  Created by Jim Walejko on 4/1/26.
//

import SwiftUI

struct DetailView: View {
    var passedValue: String  //  Don't initialize - it will be passed from the parent view
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack{
            Image(systemName: "swift")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.orange)
            Text("You are a Swifty Legend! \nAnd you passed over the value \(passedValue)")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button("Get Back!"){
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    DetailView(passedValue: "Item 1")
}
